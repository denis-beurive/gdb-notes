# Auto stepping

Create the GDB command file below "`auto_step.gdb`":

```gdb
define step_mult
    set $step_mult_max = 1000
    if $argc >= 1
        set $step_mult_max = $arg0
    end

    set $step_mult_count = 0
    while ($step_mult_count < $step_mult_max)
        set $step_mult_count = $step_mult_count + 1
        printf "step #%d\n", $step_mult_count
        step
    end
end

start
step_mult 10000
```

> Thanks to [Michael Burr](https://stackoverflow.com/users/12711/michael-burr).
>
> The `start` command does the equivalent of setting a temporary breakpoint at the beginning of the main procedure and then invoking the `run` command ([source](https://sourceware.org/gdb/download/onlinedocs/gdb/Starting.html)). 

Usage:

```bash
gdb --batch --command=auto_step.gdb --args ./program.exe
```

