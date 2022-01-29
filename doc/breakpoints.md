# Breakpoints management

## Run / Step / Next / Continue

* run: `r`: start the execution of the program.
* step: `s`: continue to the next source line. `step` steps inside any functions called within the line.
* next: `n`: continue to the next source line in the current - innermost - stack frame. Contrary to `step`, 
  `next` does not enter functions if the execution reaches a function call. The function the evaluated and the execution is stopped right after the execution of the function.
* continue: `c`: continue the execution until the next breakpoint.

## List

`i b` (for `info breakpoint`)

## Set / Unset

set:

* `b [<file name>]:<line number>`

unset: 

* `clear [<file name>]:<line number>`
* `del [<breakpoint ID>]` or `d break [<breakpoint ID>]` (for `delete breakpoint [<breakpoint ID>]`). If no ID is given, then the command will delete all breakpoints.


> * See other options [here](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_28.html). For examples:
>   a break that is active for only one execution (`tbreak`), break on conditions...
> * Breakpoint IDs are obtained by using the command `i b`.

