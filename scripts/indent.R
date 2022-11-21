library(stringr)
library(rmarkdown)

# File: String containing current file name

# Lines: Character vector containing current file lines


level = yaml_front_matter(file)[['level']]

# Correct all other headings in the file

lines = str_replace(lines,
                    "^([#]{2,4} )(?![(]EMPTY[)])", #Skip headers starting with (EMPTY) because they'll get handled later
                    "##\\1")

# Indent the first heading by the heading level, if required

if(!is.null(level)) {
  lines = str_replace(lines,
                      "(^# )(?![(]EMPTY[)])",
                      paste(paste(rep("#", level),
                                  collapse = ""),
                            " ",
                            sep = ""))
}
