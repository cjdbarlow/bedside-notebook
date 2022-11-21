-- Add relevant paths and actively debug with mobdebug with ZBS on MacOS (intel)
-- package.path = package.path .. ";/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/lualibs/?.lua;/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/lualibs/?/?.lua"
-- package.cpath = ";/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/bin/clibs53/?.dylib;" .. package.cpath
 
-- require('mobdebug').start()
 
function Table (elem)
  -- html sorts itself out
  if FORMAT:match 'latex' then
    
    -- Get the number of columns of the table
    num_col = #elem.colspecs
    -- Get number of rows. Assumes table only has 1 body, which seems to be true in test cases. Excludes header rows.
    num_rows = #elem.bodies[1].body 
    num_total = num_col + num_rows
    
    -- Set maximum number of columns that a table can have before...
    max_natural_width = 2 -- number of columns before we intervene
    max_full_col = 3 -- number of columns before we make it a fullwidth table
    max_landscape_cols = 5 -- number of columns before we rotate the table
    max_landscape_all = 22 -- number of everything (rows plus columns) before we make the table landscape
    
    -- Get the full table width
    -- (Should be 1 in most cases but not sure if pandoc/authors can do funny things so we will calculate it,)
    -- (further debugging has discovered that pandoc doesn't always provide colwidths, so we check that they're there and assume 1 if they're not)
    if elem.colspecs[1][2] == nil then
      x = 1
    else
      x = 0
      for i = 1, num_col, 1 do
        x = x + elem.colspecs[i][2]
      end
    end
    
    for i = 1, num_col, 1 do
      elem.colspecs[i][2] = x/num_col
    end
    
    -- do the thing
    if num_col <= max_natural_width then
      return{elem}
      
    elseif num_col > max_natural_width and num_col <= max_full_col then
      -- Make all columns equal width
      for i = 1, num_col, 1 do
        elem.colspecs[i][2] = x/num_col
      end
      return{elem}

    elseif num_col > max_full_col then
      -- Make the first column (usually a title column in my use-case, and gets shafted by pandoc regularly) fixed width, and divide the width between the rest)
      -- We don't subtract the first column width from the total available width because 0.2 seems to fill the margin nicely and gives the rest of the table more space
      elem.colspecs[1][2] = 0.2
      
      for i = 2, num_col, 1 do
        elem.colspecs[i][2] = x/num_col
      end
      
      if num_col > max_landscape_cols or num_total > max_landscape_all then
        return {
          pandoc.RawBlock('latex', '\\newgeometry{margin=3cm} \\begin{landscape} \\csname @colroom\\endcsname=\\vsize \\textheight=\\vsize \\csname @colht\\endcsname=\\vsize'),
          elem,
          pandoc.RawBlock('latex', '\\end{landscape} \\restoregeometry')
        }     
      else
        return {
          -- Table* cannot tolerate tables running longer than one page, so settings might need to be adjusted to prevent this occurring
          pandoc.RawBlock('latex', '\\begin{table*}'),
          elem,
          pandoc.RawBlock('latex', '\\end{table*}')
        }
      end
    end
  end
end
