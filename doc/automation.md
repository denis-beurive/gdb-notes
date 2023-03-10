# GDB automation

Create the GDB command file below "`test.gdb`":

```gdb
# rust-gdb --batch --command=test.gdb --args ./string_vs_str arg1 arg2

set width 0
set height 0
set verbose off

### Set 2 breakpoints
b main.rs:6
b main.rs:8

### Start the process
r

### Display the memory mapping into the file "map.txt"
set logging redirect on
set logging file map.txt
set logging overwrite on
set logging enabled on
info proc map
set logging enabled off

### Get information about "my_string"
echo == my_string ==\n
print my_string
ptype my_string
print &my_string
print my_string.vec
c

### Get information about "my_str"
echo == my_str ==\n
print my_str
ptype my_str
print &my_str
print my_str.length
print my_str.data_ptr
```

Execute the command file on the executable "`string_vs_str.exe`".

```bash
rust-gdb --batch --command=test.gdb --args ./string_vs_str.exe arg1 arg2
```

> Here, we use `rust-gdb`, but the procedure is identical for `gdb`.
>
> Please note that, if the executable takes parameters, we simply put them to the end of the command line (`arg1 arg2 ...`).
