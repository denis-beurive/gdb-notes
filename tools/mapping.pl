#!/usr/bin/perl
#
# Usage:
#
#   perl mapping.pl --help
#   perl mapping.pl -- 0x7ffff7fa5000 0x7ffff7d5c000 0x5555555a5000 0x555555554000
#   perl mapping.pl --path=map.txt -- 0x7ffff7f74000 0x55555555a000 0x5555555A9000 0x5555555A8000
#
# The map file must be a copy/paste of the GDB output for the command "info proc map".
# For example:
#
# process 11932
# Mapped address spaces:
#
#           Start Addr           End Addr       Size     Offset  Perms  objfile
#       0x555555554000     0x55555555a000     0x6000        0x0  r--p   /home/denis/Documents/github/tester/src/string_vs_str
#       0x55555555a000     0x555555593000    0x39000     0x6000  r-xp   /home/denis/Documents/github/tester/src/string_vs_str
#       0x555555593000     0x5555555a1000     0xe000    0x3f000  r--p   /home/denis/Documents/github/tester/src/string_vs_str
#       0x5555555a1000     0x5555555a4000     0x3000    0x4c000  r--p   /home/denis/Documents/github/tester/src/string_vs_str
#       0x5555555a4000     0x5555555a5000     0x1000    0x4f000  rw-p   /home/denis/Documents/github/tester/src/string_vs_str
#       0x5555555a5000     0x5555555c6000    0x21000        0x0  rw-p   [heap]
#       0x7ffff7d5c000     0x7ffff7d5f000     0x3000        0x0  rw-p
#       0x7ffff7d5f000     0x7ffff7d87000    0x28000        0x0  r--p   /usr/lib/x86_64-linux-gnu/libc.so.6
#       0x7ffff7d87000     0x7ffff7f1c000   0x195000    0x28000  0x7ffff7f74000r-xp   /usr/lib/x86_64-linux-gnu/libc.so.6
#       0x7ffff7f1c000     0x7ffff7f74000    0x58000   0x1bd000  r--p   /usr/lib/x86_64-linux-gnu/libc.so.6
#       0x7ffff7f74000     0x7ffff7f78000     0x4000   0x214000  r--p   /usr/lib/x86_64-linux-gnu/libc.so.6
#       0x7ffff7f78000     0x7ffff7f7a000     0x2000   0x218000  rw-p   /usr/lib/x86_64-linux-gnu/libc.so.6
#       0x7ffff7f7a000     0x7ffff7f87000     0xd000        0x0  rw-p
#       0x7ffff7f87000     0x7ffff7f8a000     0x3000        0x0  r--p   /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
#       0x7ffff7f8a000     0x7ffff7fa1000    0x17000     0x3000  r-xp   /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
#       0x7ffff7fa1000     0x7ffff7fa5000     0x4000    0x1a000  r--p   /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
#       0x7ffff7fa5000     0x7ffff7fa6000     0x1000    0x1d000  r--p   /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
#       0x7ffff7fa6000     0x7ffff7fa7000     0x1000    0x1e000  rw-p   /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
#       0x7ffff7fb8000     0x7ffff7fb9000     0x1000        0x0  ---p
#       0x7ffff7fb9000     0x7ffff7fbd000     0x4000        0x0  rw-p
#       0x7ffff7fbd000     0x7ffff7fc1000     0x4000        0x0  r--p   [vvar]
#       0x7ffff7fc1000     0x7ffff7fc3000     0x2000        0x0  r-xp   [vdso]
#       0x7ffff7fc3000     0x7ffff7fc5000     0x2000        0x0  r--p   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
#       0x7ffff7fc5000     0x7ffff7fef000    0x2a000     0x2000  r-xp   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
#       0x7ffff7fef000     0x7ffff7ffa000     0xb000    0x2c000  r--p   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
#       0x7ffff7ffb000     0x7ffff7ffd000     0x2000    0x37000  r--p   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
#       0x7ffff7ffd000     0x7ffff7fff000     0x2000    0x39000  rw-p   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
#       0x7ffffffde000     0x7ffffffff000    0x21000        0x0  rw-p   [stack]
#   0xffffffffff600000 0xffffffffff601000     0x1000        0x0  --xp   [vsyscall]

use strict;
use warnings FATAL => 'all';
use Getopt::Long;
use bignum qw/hex/;
use Data::Dumper;
use List::Util qw(max);
use constant SECTIONS_DEFAULT_PATH => 'map.txt';
use constant K_START => 'start';
use constant K_STOP => 'stop';

sub help {
    print("[perl] mapping.pl [--path=<path to map file>] [--verbose] -- <address to look at>\n");
    print("[perl] mapping.pl --help\n\n");
    printf("Default map file: \"%s\"\n", SECTIONS_DEFAULT_PATH);
}

# Parse the command line.
my $cli_mapping_path = SECTIONS_DEFAULT_PATH;
my $cli_verbose = undef;
my $cli_help = undef;
if (! GetOptions (
    'path=s'    => \$cli_mapping_path,
    'help'      => \$cli_help,
    'verbose'   => \$cli_verbose)) {
    print("Invalid command line!\n\n");
    help();
    exit(1);
}
if (defined $cli_help) {
    help();
    exit(0);
}

if (0 == int(@ARGV)) {
    printf("Invalid command line: no addresses given!\n");
    exit(1);
}

# Open map file.
printf("Open map file \"%s\"\n", $cli_mapping_path) if (defined $cli_verbose);
my $mapping_fd;
if (! open($mapping_fd, '<', $cli_mapping_path)) {
    printf("Cannot open the map file \"%s\": %s\n", $cli_mapping_path, $!);
    exit(1);
}

# Parse the map file.
my %locations_data = ();
my @locations = ();
my $uncharted_idx = 1;
while (<$mapping_fd>) {
    chomp;
    if ($_ =~ m/^\s+(0x[0-9a-f]+)\s+(0x[0-9a-f]+)\s+(0x[0-9a-f]+)\s+(0x[0-9a-f]+)\s+([a-z\-]+)\s+(.+)\s*$/) {
        my $start = $1;
        my $stop = $2;
        my $location = $6;
        $location =~ s/(^\[|\]$)//g;
        if ($location =~ m/^\s*$/) { $location = sprintf("unnamed-%s", $uncharted_idx++) }

        if (exists($locations_data{$location})) {
            $locations_data{$location}->{&K_STOP} = hex($stop) - hex("0x1");
            next;
        }
        $locations_data{$location} = {
            &K_START => hex($start),
            &K_STOP  => hex($stop) - hex("0x1")
        };
        push(@locations, $location);
    }
}

my @addresses = sort map { hex $_ } @ARGV;
sub find_location {
    my ($mapping, $address) = @_;
    foreach my $location (@locations) {
        my $start = $mapping->{$location}->{&K_START};
        my $stop = $mapping->{$location}->{&K_STOP};
        if ($address >= $start and $address <= $stop) {
            return($location)
        }
    }
    printf("\n\n");
    return(undef);
}

my %found_locations = ();
foreach my $address (@addresses) {
    my $location = find_location(\%locations_data, $address);
    if (! defined($location)) {
        printf("Cannot find location for address 0x%s\n", $address);
        next;
    }
    $found_locations{$location} = [] unless exists($found_locations{$location});
    push(@{$found_locations{$location}}, $address);
}

my $maximum = max(map { length($_) } @locations);
printf("%s\n", '-' x ($maximum + 60));
foreach my $location (@locations) {
    printf("%${maximum}s: 0x%-25X -> 0x%-25X\n",
        $location,
        $locations_data{$location}->{start},
        $locations_data{$location}->{stop}
    );
    if (exists($found_locations{$location})) {
        foreach my $address (@{$found_locations{$location}}) {
            printf("%${maximum}s  0x%X\n", '', $address);
        }
    }
}
printf("%s\n", '-' x ($maximum + 60));


