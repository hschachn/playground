#
#   Read a list of URLs from input file.
#   Non-reachable ULRs are written to <filename>.fail,
#   the rest to <filename>.ok
#
use strict;
use LWP::Simple;

my $filename = shift;

open FH, "<" , $filename or die $!;
open GOOD, ">$filename.ok" or die $!;
open BAD, ">$filename.fail" or die $!;
my $line;
while ( $line = <FH> ){
    chomp $line;
    if (head($line)) {
        print "OK   $line\n";
        print GOOD "$line\n";
        next;
    }
    print "FAIL $line\n";
    print BAD "$line\n";
}

close GOOD;
close BAD;
close FH;
