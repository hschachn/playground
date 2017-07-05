use strict;
no strict 'refs';


my $f = shift @ARGV;
$f->(@ARGV) or die "Unknown function\n";


sub call {
    print "Called a function with parameters:\n";
    map { print "$_\n" } @_; 
}
