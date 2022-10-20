# Using Perl for hexadecimal calculation

You can use the "bignum" module.

```perl
#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';
use bignum qw/hex/;

my $v1 = hex('0x01');
my $v2 = hex('0x02');
printf("0x%X + 0x%X = 0x%X\n", $v1, $v2, $v1 + $v2);
printf("0x%X * 0x%X = 0x%X\n", $v1, $v2, $v1 * $v2);

$v1 = hex('0xAAAAA');
$v2 = hex('0xBBBBB');
printf("(0x%X * 0x%X) %% 0xFFFFF = 0x%X\n", $v1, $v2, ($v1 * $v2 % hex('0xFFFFF')));
printf("(%d * %d) %% %d = %d\n", $v1, $v2, hex('0xFFFFF'), ($v1 * $v2 % hex('0xFFFFF')));
```

Result:

```bash
$ perl ex.pl 
0x1 + 0x2 = 0x3
0x1 * 0x2 = 0x2
(0xAAAAA * 0xBBBBB) % 0xFFFFF = 0xAAAAA
(699050 * 768955) % 1048575 = 699050
```

> Please note:
>
> ```bash
> $ echo 'obase=10; ibase=16; AAAAA' | bc
> 699050
> $ echo 'obase=10; ibase=16; BBBBB' | bc
> 768955
> $ echo 'obase=10; ibase=16; FFFFF' | bc
> 1048575
> $ echo 'obase=10; ibase=16; scale=0; (AAAAA * BBBBB) % FFFFF' | bc
> 699050
> ```
>
> Other example: [here](../tools/mapping.pl)
