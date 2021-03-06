# Useful commands.[^format]
[^format]: https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax

## Command to find a specific string in files and directories.
### **grep -Rw ./ -e 'def load_volfile'**
1. -R: tells **grep** to read all files in all the directories recursively.[^1]
2. -w: instructs **grep** to select only those lines containing matches that form whole words.[^1]
3. -e: is used to specify the string (pattern) to be searched.[^1]

## Command to find number of files in a directory.
### **ls -1 | wc -l**
1. -1 (The numeric digit "one".) Force output to be one entry per line. This is the default when output is not to a terminal.
2. wc stands for word count; -l stands for new line count.

[^1]: https://www.tecmint.com/find-a-specific-string-or-word-in-files-and-directories/
