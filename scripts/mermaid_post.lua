-- Read the input file and get list of files to be rendered
local inputFile = io.open("mermaidFilelist")
local input = inputFile:read("*all")
inputFile:close()

local files = {}
for filePath in input:gmatch("[^\r\n]+") do
    table.insert(files, filePath)
end


-- Define the find and replace strings
local dir = os.getenv("QUARTO_PROJECT_DIR")
local styleFilePath = dir .. "/styles/mermaid_styling"
local styleFile = io.open(styleFilePath, "r")
local old = styleFile:read("*all")
styleFile:close()
old = old

local new = "```{mermaid}"


-- Function to perform find and replace
local function findAndReplaceInFile(filePath, old, new)
    -- Plain string replacement courtesy of: https://stackoverflow.com/questions/76013378/lua-string-gsub-not-to-use-special
    function string:replace(substring, replacement, n)
        return (self:gsub(substring:gsub("%p", "%%%0"), replacement:gsub("%%", "%%%%"), n))
    end
    
    local file = io.open(filePath, "r")
    local content = file:read("*a")
    file:close()

    local content = content:replace(old, new)

    file = io.open(filePath, "w")
    file:write(content)
    file:close()
end

-- Process each file in the list
for i, filePath in ipairs(files) do
    findAndReplaceInFile(filePath, old, new)
end

-- Delete the file list
os.remove("mermaidFilelist")