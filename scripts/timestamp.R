# File: String containing current file name

# Lines: Character vector containing current file lines


# Get time the file was last modified, in a nice format

last_mod = strftime(file.info(file)$mtime,
                     format = "%d %B %Y")

# Append this to the character vector containing the file contents, for html output only

if (class(lines) == "character" & output_format == "bookdown::gitbook"){
    lines = append(lines, paste("\nPage last updated:", last_mod))
}
