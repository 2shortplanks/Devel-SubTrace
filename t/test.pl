#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 1;
use IPC::Open3;
use FindBin;

chdir $FindBin::Bin
  or die "Can't change dir to $FindBin::Bin";

my ($wtr, $rdr, $err);
use Symbol 'gensym'; $err = gensym;
my $pid = open3($wtr, $rdr, $err,
                 $^X, '-I../lib','-d:SubTrace','simple.pl');

close $wtr;
my $got;
$got .= $_ while (<$err>);

waitpid( $pid, 0 );
my $child_exit_status = $? >> 8;

my $expect = <<'EXPECTED';
--> CODE(0x7fad12812458) (simple.pl line 3)
----> strict::import (simple.pl line 3)
------> strict::bits (/Users/mark/perl5/perlbrew/perls/perl-5.16.0/lib/5.16.0/strict.pm line 44)
--> CODE(0x7fad12812398) (simple.pl line 4)
----> warnings::import (simple.pl line 4)
> main::foo (simple.pl line 28)
--> main::bar (simple.pl line 7)
----> main::fred (simple.pl line 13)
------> main::foo (simple.pl line 19)
--------> main::bar (simple.pl line 7)
----------> main::fred (simple.pl line 13)
------------> main::foo (simple.pl line 19)
--------------> main::bar (simple.pl line 7)
----------------> main::fred (simple.pl line 13)
------------------> main::foo (simple.pl line 19)
--------------------> main::bar (simple.pl line 7)
----------------------> main::fred (simple.pl line 13)
------------------------> main::foo (simple.pl line 19)
--------------------------> main::bar (simple.pl line 7)
----------------------------> main::fred (simple.pl line 13)
------------------------------> main::foo (simple.pl line 19)
--------------------------------> main::bar (simple.pl line 7)
----------------------------------> main::fred (simple.pl line 13)
------------------------------------> main::foo (simple.pl line 19)
--------------------------------------> main::bar (simple.pl line 7)
----------------------------------------> main::fred (simple.pl line 13)
------------------------------------------> main::foo (simple.pl line 19)
--------------------------------------------> main::bar (simple.pl line 7)
----------------------------------------------> main::fred (simple.pl line 13)
------------------------------------------------> main::foo (simple.pl line 19)
--------------------------------------------------> main::bar (simple.pl line 7)
----------------------------------------------------> main::fred (simple.pl line 13)
------------------------------------------------------> main::foo (simple.pl line 19)
--------------------------------------------------------> main::bar (simple.pl line 7)
----------------------------------------------------------> main::fred (simple.pl line 13)
--------------------------------------------------------> main::gonzo (simple.pl line 8)
----------------------------------------------------------> main::kermit (simple.pl line 22)
------------------------------------------------------------> main::piggy (simple.pl line 23)
------------------------------------------------------------> main::grover (simple.pl line 23)
--------------------------------------------------------> main::fred (simple.pl line 9)
--------------------------------------------------> main::gonzo (simple.pl line 8)
----------------------------------------------------> main::kermit (simple.pl line 22)
------------------------------------------------------> main::piggy (simple.pl line 23)
------------------------------------------------------> main::grover (simple.pl line 23)
--------------------------------------------------> main::fred (simple.pl line 9)
--------------------------------------------> main::gonzo (simple.pl line 8)
----------------------------------------------> main::kermit (simple.pl line 22)
------------------------------------------------> main::piggy (simple.pl line 23)
------------------------------------------------> main::grover (simple.pl line 23)
--------------------------------------------> main::fred (simple.pl line 9)
--------------------------------------> main::gonzo (simple.pl line 8)
----------------------------------------> main::kermit (simple.pl line 22)
------------------------------------------> main::piggy (simple.pl line 23)
------------------------------------------> main::grover (simple.pl line 23)
--------------------------------------> main::fred (simple.pl line 9)
--------------------------------> main::gonzo (simple.pl line 8)
----------------------------------> main::kermit (simple.pl line 22)
------------------------------------> main::piggy (simple.pl line 23)
------------------------------------> main::grover (simple.pl line 23)
--------------------------------> main::fred (simple.pl line 9)
--------------------------> main::gonzo (simple.pl line 8)
----------------------------> main::kermit (simple.pl line 22)
------------------------------> main::piggy (simple.pl line 23)
------------------------------> main::grover (simple.pl line 23)
--------------------------> main::fred (simple.pl line 9)
--------------------> main::gonzo (simple.pl line 8)
----------------------> main::kermit (simple.pl line 22)
------------------------> main::piggy (simple.pl line 23)
------------------------> main::grover (simple.pl line 23)
--------------------> main::fred (simple.pl line 9)
--------------> main::gonzo (simple.pl line 8)
----------------> main::kermit (simple.pl line 22)
------------------> main::piggy (simple.pl line 23)
------------------> main::grover (simple.pl line 23)
--------------> main::fred (simple.pl line 9)
--------> main::gonzo (simple.pl line 8)
----------> main::kermit (simple.pl line 22)
------------> main::piggy (simple.pl line 23)
------------> main::grover (simple.pl line 23)
--------> main::fred (simple.pl line 9)
--> main::gonzo (simple.pl line 8)
----> main::kermit (simple.pl line 22)
------> main::piggy (simple.pl line 23)
------> main::grover (simple.pl line 23)
--> main::fred (simple.pl line 9)
EXPECTED

# change the code ref addresses to be some placeholder because
# these change on each run
$got    =~ s/CODE\([^)]+\)/CODE-GUBBINS/g;
$expect =~ s/CODE\([^)]+\)/CODE-GUBBINS/g;

# remove the lines pertaining to use strict and use warnings
# since the location and line numbers of these libraries might vary per install
$got    =~ s/\A.*^>/>/ms;
$expect =~ s/\A.*^>/>/ms;

is $got, $expect;

