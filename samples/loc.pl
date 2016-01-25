use File::Find;
use Getopt::Long;
use Tie::File;


my %OPTIONS = (
    
    ext     =>  [],     #   file extensions
    path    =>  undef   #   folde to search for
    
);


my $path = shift;

$OPTIONS{ext}  = [ qw (cs xaml) ];


my $options_pattern = join ( '|' , @{$OPTIONS{ext}} );
my $exte_rege = qr/($options_pattern)$/;

my @files;
my $sumloc = 0;
finddepth( 
    {
        wanted =>  sub {
            return if $_ !~ $exte_rege;
            my @lines;
            tie @lines , 'Tie::File', $_ or die "Could not tie $_!";
            my $loc = scalar @lines;
            push @files ,{ file => $_ , loc => $loc };
            $sumloc += $loc;
            print sprintf ("Found %5d %s\n" , $loc , $_ );
        },
    no_chdir => 1
}, ( $path ));

print qq {
    
    Summe : $sumloc LOC

};
