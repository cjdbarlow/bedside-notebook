-- Add relevant paths and actively debug with mobdebug with ZBS on OSX
--package.path = package.path .. ";/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/lualibs/?.lua;/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/lualibs/?/?.lua"
--package.cpath = ";/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/bin/clibs53/?/core.dylib"
--require('mobdebug').start()

--package.path = package.path .. ';.;./scripts/?.lua;'

cwd = debug.getinfo(1).short_src;
print(cwd)

-- Find the quarto project dir and identify the glossary file
dir = os.getenv("QUARTO_PROJECT_DIR")
glossary_file = dir .. "/_glossary.yml"

-- Add the quarto project dir/scripts to the path so we can load the yaml parser
package.path = package.path .. ";" .. dir .. "\\scripts\\?.lua;" .. dir .. "/scripts/?.lua;"
local yaml = require "yaml"


-- Load glossary file
local function loadGlossary(filename)
  file = io.open(filename, "rb")
  if not file then
    error("Cannot find the glossary file")
  else
    local glossary = file:read("*all")
    return glossary
  end
end

local glossary = yaml.eval(loadGlossary(glossary_file))



-- functions to find separators and then split out glossary elements
local Set = function(list)
    local set = {}
    for i,v in ipairs(list) do
        set[v] = true
    end
    return set
end

local findSeparator = function(text)
    local separator = Set{",", ";", "/", "."}
    for i = 1, #text do
        local s = string.sub(text,i,i)
        if separator[s] then
            return s
        end
    end
end

local separatedList = function(text)
    local found
    local t = {}
    local separator = findSeparator(text)
    if not separator then return end
    for abb in string.gmatch(text, "%P+") do
        if glossary[abb] then
            found = true
            t[#t+1] = pandoc.Span(abb, {title = abb, class = "glossary"})
            t[#t+1] = pandoc.Str(separator)
        end
    end
    if found then
        -- remove last separator if there are more then one elements in the list
        -- because otherwise the seperator is part of the element and needs to stay
        if #t > 2 then t[#t] = nil end
        return t
    end
end


-- Function that substitutes glossary term for term with mouseover link
function glos_sub (el)
  return pandoc.walk_block(el, {
    Str = function(el)
        if glossary[el.text] then
            return pandoc.Span(el.text, {title = glossary[el.text], class = "glossary"})
        else
            return separatedList(el.text)
        end
    end
  })
end


-- Run on desired elements (in order to exclude headings and toc elements)
if FORMAT:match 'html' then
    return {
      {BulletList = glos_sub},
      {Para = glos_sub},
      {Table = glos_sub}
    }
end