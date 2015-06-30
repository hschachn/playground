use strict;

delegate ( @ARGV );

sub delegate {
    mprint ( @_ );
}

sub mprint {
   
    while ( @_ ) {
        print shift; print "\n";
    }
}
