-- Find the quarto project dir and identify the glossary file
local dir = os.getenv("QUARTO_PROJECT_DIR")
local glossary_file = dir .. "/_glossary.yml"

-- Add the quarto project dir/scripts to the path so we can load the yaml parser
package.path = package.path .. ";" .. dir .. "\\scripts\\?.lua;" .. dir .. "/scripts/?.lua;"
local yaml = require "yaml"

-- Load glossary file
local function loadGlossary(filename)
  local file = io.open(filename, "rb")
  if not file then
    error("Cannot find the glossary file")
  end
  local content = file:read("*all")
  file:close()
  return content
end

local glossary = yaml.eval(loadGlossary(glossary_file))

-- Pre-compute key length bounds for fast rejection
local min_key_len = math.huge
local max_key_len = 0
for k, _ in pairs(glossary) do
  local len = #k
  if len < min_key_len then min_key_len = len end
  if len > max_key_len then max_key_len = len end
end

-- Pre-compute separator set once
local separators = {[","]=true, [";"]=true, ["/"]=true, ["."]=true}

-- Quick check: does string contain a separator?
local function hasSeparator(text)
  for i = 1, #text do
    if separators[string.sub(text, i, i)] then
      return true
    end
  end
  return false
end

local function findSeparator(text)
  for i = 1, #text do
    local s = string.sub(text, i, i)
    if separators[s] then
      return s
    end
  end
end

-- Track which terms have been seen in the current section
local seen_terms = {}

local function separatedList(text)
  local separator = findSeparator(text)
  if not separator then return end
  local found
  local t = {}
  for abb in string.gmatch(text, "%P+") do
    if glossary[abb] then
      found = true
      seen_terms[abb] = true
      t[#t+1] = pandoc.Span(abb, {title = glossary[abb], class = "glossary"})
      t[#t+1] = pandoc.Str(separator)
    end
  end
  if found then
    if #t > 2 then t[#t] = nil end
    return t
  end
end

-- Process a single Str element
local function processStr(el)
  local text = el.text
  local len = #text

  -- Fast rejection: skip strings that can't match any glossary key
  if len < min_key_len then
    return
  end

  -- Direct glossary match
  if len <= max_key_len and glossary[text] then
    if seen_terms[text] then return end
    seen_terms[text] = true
    return pandoc.Span(text, {title = glossary[text], class = "glossary"})
  end

  -- Only try separated list if string contains a separator
  if hasSeparator(text) then
    return separatedList(text)
  end
end

-- Str walker for use with walk_block
local str_filter = {
  Str = processStr
}

-- Process a block element (Para, BulletList, Table)
local function processBlock(el)
  return pandoc.walk_block(el, str_filter)
end

-- Main filter: process entire document to track sections
if FORMAT:match 'html' then
  return {
    {
      Header = function(_)
        -- Reset seen terms at each header regardless of level (first-match-per-section)
        -- To restrict to e.g. H1/H2 only, add: if _.level <= 2 then ... end
        seen_terms = {}
      end,
      BulletList = processBlock,
      Para = processBlock,
      Table = processBlock
    }
  }
end
