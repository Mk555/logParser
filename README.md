# logParser
**Parse the logs of a folder**

# USAGE

`main.pl -p <Path of the folder> [-v] [-h]`

*-p Path of the folder w/ the log files - [MANDATORY]*  
*-v Verbose mode (print the lines where the word(s) are found*  
*-h Human readable (print the folder name & the line)*  


##Path


You don't have to put a star at the end of the path. The script adds a "/\*" at the end of it (for the `glob` function).
