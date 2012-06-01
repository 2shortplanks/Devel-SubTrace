package Devel::TraceSub;

use 5.006;  # require non prehistoric perl!

use strict;
use warnings;

our $VERSION = "1.00";

# must be declared, even if does nothing
sub DB::DB {};

sub DB::sub {

    # where were we called from?
    my ($package, $filename, $line) = caller(-1);

    # how many frames?
    my $frames=0;
    $frames++ while caller($frames);

    # print out the arguments
    print {*STDERR} "--"x$frames ."> ";
    print {*STDERR} "$DB::sub ($filename line $line)\n";

    # then jump to the right place without altering the stack
    goto &{$DB::sub}
}

1;

__END__

=head1 NAME

Devel::TraceSub - simple debugger that just prints out sub calls

=head1 SYNOPSIS

  perl -d:TraceSub synopsis.pl 
  > main::foo (t/synopsis.pl line 3)
  --> main::bar (t/synopsis.pl line 6)
  ----> main::baz (t/synopsis.pl line 11)
  --> main::baz (t/synopsis.pl line 7)

  cat synopsis.pl
  #!/usr/bin/perl

  foo();
  
  sub foo {
    bar();
    baz();
  }
  
  sub bar {
     baz();
  }
  
  sub baz {}

=head1 DESCRIPTION

Simple 'debugger' that prints out each subroutine name when it's called (and
the file and line it was called from) to STDERR.

=head1 AUTHOR

Written by Mark Fowler <mark@twoshortplanks.com>

=head1 COPYRIGHT

Copyright OmniTI 2012.  All Rights Rerserved.

This program is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=head1 BUGS

Bugs should be reported via this distribution's
CPAN RT queue.  This can be found at
L<https://rt.cpan.org/Dist/Display.html?Devel-TraceSub>

You can also address issues by forking this distribution
on github and sending pull requests.  It can be found at
L<http://github.com/2shortplanks/Devel-TraceSub>

=head1 SEE ALSO

L<Devel::Trace> - print every line that is executed

L<Devel::SubTrace> - hook all subs in a namespace with lexwrap and add
debugging when executed

=cut