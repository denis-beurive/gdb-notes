# Logging into a file

Execute the GDB command "`info proc map`" and store the result into the file "`map.txt`".

```gdb
set logging redirect on
set logging file map.txt
set logging overwrite on
set logging enabled on
info proc map
set logging enabled off
```

