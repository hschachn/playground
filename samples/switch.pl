use strict;
use Switch;

print ">> $ARGV[0]\n";
my $res =  my_translate ( $ARGV[0] );
print "$res \n";


sub my_print {
    print shift; }

sub my_translate {
    
    local $_;
    switch ( shift ) {
        case 'A' { $_ = 'Der erste Buchstabe im Alphabet' }
        case 'Z' { $_ = 'The last one'}
        else     { $_ = 'unbekannt'}
    }
    $_
}
