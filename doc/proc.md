# Memory mapping

## Find the stack and the heap

Type the following command: `info proc map`

The result looks something like:

```
process 7197
Mapped address spaces:

          Start Addr           End Addr       Size     Offset  Perms  objfile
      0x555555554000     0x55555555a000     0x6000        0x0  r--p   /home/denis/Documents/github/rust-playground/variables/target/debug/variables
      0x55555555a000     0x555555591000    0x37000     0x6000  r-xp   /home/denis/Documents/github/rust-playground/variables/target/debug/variables
      0x555555591000     0x55555559f000     0xe000    0x3d000  r--p   /home/denis/Documents/github/rust-playground/variables/target/debug/variables
      0x5555555a0000     0x5555555a3000     0x3000    0x4b000  r--p   /home/denis/Documents/github/rust-playground/variables/target/debug/variables
      0x5555555a3000     0x5555555a4000     0x1000    0x4e000  rw-p   /home/denis/Documents/github/rust-playground/variables/target/debug/variables
      0x5555555a4000     0x5555555c5000    0x21000        0x0  rw-p   [heap]
      0x7ffff7d5c000     0x7ffff7d5f000     0x3000        0x0  rw-p   
      0x7ffff7d5f000     0x7ffff7d87000    0x28000        0x0  r--p   /usr/lib/x86_64-linux-gnu/libc.so.6
      0x7ffff7d87000     0x7ffff7f1c000   0x195000    0x28000  r-xp   /usr/lib/x86_64-linux-gnu/libc.so.6
      0x7ffff7f1c000     0x7ffff7f74000    0x58000   0x1bd000  r--p   /usr/lib/x86_64-linux-gnu/libc.so.6
      0x7ffff7f74000     0x7ffff7f78000     0x4000   0x214000  r--p   /usr/lib/x86_64-linux-gnu/libc.so.6
      0x7ffff7f78000     0x7ffff7f7a000     0x2000   0x218000  rw-p   /usr/lib/x86_64-linux-gnu/libc.so.6
      0x7ffff7f7a000     0x7ffff7f87000     0xd000        0x0  rw-p   
      0x7ffff7f87000     0x7ffff7f8a000     0x3000        0x0  r--p   /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
      0x7ffff7f8a000     0x7ffff7fa1000    0x17000     0x3000  r-xp   /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
      0x7ffff7fa1000     0x7ffff7fa5000     0x4000    0x1a000  r--p   /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
      0x7ffff7fa5000     0x7ffff7fa6000     0x1000    0x1d000  r--p   /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
      0x7ffff7fa6000     0x7ffff7fa7000     0x1000    0x1e000  rw-p   /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
      0x7ffff7fb8000     0x7ffff7fb9000     0x1000        0x0  ---p   
      0x7ffff7fb9000     0x7ffff7fbd000     0x4000        0x0  rw-p   
      0x7ffff7fbd000     0x7ffff7fc1000     0x4000        0x0  r--p   [vvar]
      0x7ffff7fc1000     0x7ffff7fc3000     0x2000        0x0  r-xp   [vdso]
      0x7ffff7fc3000     0x7ffff7fc5000     0x2000        0x0  r--p   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
      0x7ffff7fc5000     0x7ffff7fef000    0x2a000     0x2000  r-xp   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
      0x7ffff7fef000     0x7ffff7ffa000     0xb000    0x2c000  r--p   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
      0x7ffff7ffb000     0x7ffff7ffd000     0x2000    0x37000  r--p   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
      0x7ffff7ffd000     0x7ffff7fff000     0x2000    0x39000  rw-p   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
      0x7ffffffde000     0x7ffffffff000    0x21000        0x0  rw-p   [stack]
  0xffffffffff600000 0xffffffffff601000     0x1000        0x0  --xp   [vsyscall]
```

You can see that the head starts at `0x5555555a4000` (included) and ends at `0x5555555c5000` (excluded). That is:
`0x5555555a4000` (included) and `0x5555555c5000 - 0x1 = 0x5555555C4FFF` (included). 

You can see that the stack starts at `0x7ffffffde000` (included) and ends at `0x7ffffffff000` (excluded). That is:
`0x7ffffffde000` (included) and `0x7ffffffff000 - 0x1 = 0x7FFFFFFFEFFF` (included). 


> You may want to read [this article](bc.md) that shows how to use "`bc`" to perform hexadecimal calculations.
