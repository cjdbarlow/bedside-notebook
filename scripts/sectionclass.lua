-- Add relevant paths and actively debug with mobdebug with ZBS on MacOS (intel)
--package.path = package.path .. ";/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/lualibs/?.lua;/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/lualibs/?/?.lua"
--package.cpath = ";/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/bin/clibs53/?.dylib;" .. package.cpath
 
--require('mobdebug').start()


--This function lets sections be treated differently, depending on the output format.
function Header(elem)
  num_classes = #elem.classes
  
  if num_classes == 0 then
    return elem
  end

  is_header = 0
  i = 1
  repeat
    if elem.classes[i] == 'bookpart' then
      is_header = 1;
    end
    i = i + 1
  until (is_header == 1 or i == num_classes)
  
  -- modify the classes based on the output format
  if is_header == 1 then
    if FORMAT:match 'latex' then
      elem.classes[num_classes + 1] = 'unlisted'
      elem.classes[num_classes + 2] = 'unnumbered'
    elseif FORMAT:match 'html' then
      elem.classes[num_classes + 1] = 'unnumbered'
    end
  end
  return elem
end