#!/usr/bin/env perl

foo();

sub foo {
	bar();
	baz();
}

sub bar {
   baz();
}

sub baz {}

