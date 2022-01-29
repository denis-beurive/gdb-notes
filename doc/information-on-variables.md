## Printing information On variables

* **type**: `ptype <variable name>` or `whatis <variable name>`
* **explore structure**: `explore <variable name>`. This is pretty useful because you can explore the structure of Rust fat pointers, for example.
* **address / reference**: `print &<variable name>`. This is pretty useful because it gives you very detailed declaration.

```bash
(gdb) ptype s1
type = struct alloc::string::String {
  vec: alloc::vec::Vec<u8, alloc::alloc::Global>,
}
(gdb) ptype &s1
type = *mut alloc::string::String
(gdb) print &s1
$3 = (*mut alloc::string::String) 0x7fffffffdce0
```