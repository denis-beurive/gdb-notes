# Using bc for hexadecimal calculation

## General description

You can use the command line calculator `bc` to perform hexadecimal calculations.

For example: `echo 'obase=16;ibase=16;5555555C5000 - 1' | bc`


```bash
$ echo 'obase=16;ibase=16;5555555C5000 - 1' | bc
5555555C4FFF
```

> **WARNING**: 
> * you must use uppercase letters to write hexadecimal numbers.
> * do not prefix the values with "`0x`".

## Tips and tricks

Use Bash to convert lowercase letters to uppercase:

```bash
$ value="7ffffffff000"
$ echo ${value^^}
7FFFFFFFF000
$ echo "obase=16;ibase=16;${value^^} - 1" | bc
7FFFFFFFEFFF
```

Use Bash to convert lowercase letters to uppercase, and to remove the "`0x`" prefix:


```bash
$ value="0x7ffffffff000"
$ echo ${value^^}
0X7FFFFFFFF000
$ echo ${value^^} | sed 's/^..//'
7FFFFFFFF000
$ echo "obase=16;ibase=16;$( echo ${value^^} | sed 's/^..//' ) - 1" | bc
7FFFFFFFEFFF
```
