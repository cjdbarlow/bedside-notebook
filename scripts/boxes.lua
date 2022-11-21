function Div (elem)
  if FORMAT:match 'latex' then
    if elem.classes[1] == "info" then
      return {
        pandoc.RawBlock('latex', '\\begin{info}'),
        elem,
        pandoc.RawBlock('latex', '\\end{info}')
      }
    elseif elem.classes[1] == "danger" then
      return {
        pandoc.RawBlock('latex', '\\begin{danger}'),
        elem,
        pandoc.RawBlock('latex', '\\end{danger}')
      }
    elseif elem.classes[1] == "caution" then
      return {
        pandoc.RawBlock('latex', '\\begin{caution}'),
        elem,
        pandoc.RawBlock('latex', '\\end{caution}')
      }
    elseif elem.classes[1] == "tick" then
      return {
        pandoc.RawBlock('latex', '\\begin{tick}'),
        elem,
        pandoc.RawBlock('latex', '\\end{tick}')
      }
    elseif elem.classes[1] == "ANZCA" then
      return {
        pandoc.RawBlock('latex', '\\begin{ANZCA}'),
        elem,
        pandoc.RawBlock('latex', '\\end{ANZCA}')
      }
    elseif elem.classes[1] == "CICM" then
      return {
        pandoc.RawBlock('latex', '\\begin{CICM}'),
        elem,
        pandoc.RawBlock('latex', '\\end{CICM}')
      }
    elseif elem.classes[1] == "dual" then
      return {
        pandoc.RawBlock('latex', '\\begin{dual}'),
        elem,
        pandoc.RawBlock('latex', '\\end{dual}')
      }
    else
      return elem
    end
  end
end