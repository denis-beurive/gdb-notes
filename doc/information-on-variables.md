# Printing information on variables

## Adresse / reference, type and structure

* **print information**: `p <variable name>` (for `print <variable name>`).
* **type**: `ptype <variable name>` or `whatis <variable name>`
* **explore structure**: `explore <variable name>`. This is pretty useful because you can explore the structure of Rust fat pointers, for example.
* **address / reference**: `p &<variable name>` (for `print &<variable name>`). This is pretty useful because it gives you very detailed declaration.

```bash
(gdb) p s1
$1 = alloc::string::String {vec: alloc::vec::Vec<u8, alloc::alloc::Global> {buf: alloc::raw_vec::RawVec<u8, alloc::alloc::Global> {ptr: core::ptr::unique::Unique<u8> {pointer: 0x5555555a6ba0, _marker: core::marker::PhantomData<u8>}, cap: 3, alloc: alloc::alloc::Global}, len: 3}}
(gdb) ptype s1
type = struct alloc::string::String {
  vec: alloc::vec::Vec<u8, alloc::alloc::Global>,
}
(gdb) ptype &s1
type = *mut alloc::string::String
(gdb) print &s1
$3 = (*mut alloc::string::String) 0x7fffffffdce0
```

## Value

Generic usage: `x /[Length][Format] <Address expression>`

> See [this link](https://visualgdb.com/gdbreference/commands/x) for all formats.

### Example 1: printing characters

`s1` is an instance of `String` (Rust).

Get this address of a variable `s1`:

```bash
(gdb) x/gx &s1
0x7fffffffdce0: 0x00005555555a6ba0
```

> You can use `x/gx` or `x/xg`.

Then get the content of the variable `s1`:

```bash
(gdb) x/3c 0x00005555555a6ba0
0x5555555a6ba0: 49 '1'  48 '0'  48 '0'
```

> Please note that we knew that s1 is a string which contains 3 characters. Thus we used the appropriate formatters.

### Example 2: print integers

```bash
(gdb) p n1
$4 = 10
(gdb) p &n1
$5 = (*mut i32) 0x7fffffffdc48
(gdb) x/wd 0x7fffffffdc48
0x7fffffffdc48: 10
(gdb) x/hd 0x7fffffffdc48
0x7fffffffdc48: 10
(gdb) x/bd 0x7fffffffdc48
0x7fffffffdc48: 10
(gdb) x/bx 0x7fffffffdc48
0x7fffffffdc48: 0x0a
(gdb) x/hx 0x7fffffffdc48
0x7fffffffdc48: 0x000a
(gdb) x/wx 0x7fffffffdc48
0x7fffffffdc48: 0x0000000a
```


