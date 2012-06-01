#!/usr/bin/env perl

use strict;
use warnings;

sub foo {
  bar();
  gonzo();
  fred();
}

sub bar {
  fred();
}

sub fred {
  our $x;
  $x++;
  foo() if $x < 10;
}

sub gonzo  { kermit() }
sub kermit { piggy(); grover(); }
sub piggy  { }
sub grover { }


foo();