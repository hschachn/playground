use strict;
use warnings;

sub pretty_print {
    
    my %params = @_;

    foreach (keys %params) {
        print "$_ : $params{$_}\n";
    }

}


pretty_print( val1 => "hansi" , wert => 47 );
pretty_print( peter => "meier" );
