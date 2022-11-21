-- Add relevant paths and actively debug with mobdebug with ZBS on MacOS (intel)
--package.path = package.path .. ";/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/lualibs/?.lua;/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/lualibs/?/?.lua"
--package.cpath = ";/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/bin/clibs53/?.dylib;" .. package.cpath
 
--require('mobdebug').start()

-- This prevents paragraphs that are shorter than one line being indented

function Para (elem)
  if FORMAT:match 'latex' then
    -- define max num of characters on a line before it gets indented
    max_length = 30
    
    -- gets length of para
    line_length = #pandoc.utils.stringify(elem)
    
    if line_length < max_length then    
      lead = pandoc.RawInline('latex', "\\noindent ")
      table.insert(elem.c, 1, lead)
      return {
        elem
      }
    else
      return {
        elem
      }
    end
  end
end

