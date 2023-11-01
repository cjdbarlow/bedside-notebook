-- Get list of files to be rendered
local files = {}

input = os.getenv("QUARTO_PROJECT_INPUT_FILES")
for filePath in input:gmatch("[^\r\n]+") do
    table.insert(files, filePath)
end


-- Get the working directory
local dir = os.getenv("QUARTO_PROJECT_DIR")


-- Define the find and replace strings
local old = "```{mermaid}\n\n"

local styleFilePath = dir .. "/styles/mermaid_styling"
local styleFile = io.open(styleFilePath, "r")
local new = styleFile:read("*all")
styleFile:close()
new = new .. "\n\n"

-- Function to perform find and replace
local function findAndReplaceInFile(filePath, old, new)
    -- Plain string replacement courtesy of: https://stackoverflow.com/questions/76013378/lua-string-gsub-not-to-use-special
    -- This avoids painful headaches trying to do find and replace around special characters
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

-- Save the input file list, so we can revert the changes after
-- We have to save it because the *input* list in the post-render script
out = assert(io.open("mermaidFilelist", "w"))
out:write(input)
out:close()