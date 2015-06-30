use strict;


my @ARGV_COPY = @ARGV;
{
    local @ARGV = @ARGV_COPY;
    push @ARGV, 'WERT';
    my $ret = do 'einc.pl';

    print "$ret >>> $! $@ \n";
}

map {
    print "$_\n";
} @ARGV;
