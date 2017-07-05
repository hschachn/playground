use File::Find;
use Getopt::Long;
use Tie::File;


my %OPTIONS = (
    
    ext     =>  [],     #   file extensions
    path    =>  undef,  #   folder to search for
    xcl     =>  []      #   patterns to be excluded 
);



my @classification = (

[ 'AssemblyInfo.cs' , sub { "AssemblyInfo" } ],
[ 'Designer.cs' ,  sub { "Designer" } ]


);

sub classify {

    my $file = shift;
    my @classes;
    
    foreach my $c(@classification) {
        next if $file !~ qr/$c->[0]/;
        push @classes, $c->[1]->( $file );
    }

    return \@classes;
}


my $path = shift;

$OPTIONS{ext}  = [ qw (.cs .aspx) ];
$OPTIONS{xcl}  = [ "branches","/bin/", "/obj/" ];


my $extensions_pattern = join ( '|' , @{$OPTIONS{ext}} );
my $ext_regex = qr/($extensions_pattern)$/;

my $exclude_pattern = join ( '|' , @{$OPTIONS{xcl}} );
my $exclude_regex = qr/($exclude_pattern)/;

my @files;
my $sumloc = 0;
finddepth( 
    {
        wanted =>  sub {

            return if $_ =~ /^[.]{0,2}$/;
            return if $_ !~ $ext_regex;
            return if $File::Find::name =~ $exclude_regex;
            my @lines;
            tie @lines , 'Tie::File', $_ or return;
            my $loc = scalar @lines;
            untie @lines;
            my $ff = { file => $_ , loc => $loc , class => classify ($File::Find::name )};
            push @files , $ff;
            printFile( $ff );
            $sumloc += $loc;
        },
    no_chdir => 1
}, ( $path ));

sub printFile {
    my $file = shift;
    print sprintf "%d;%s;%s\n" , $file->{loc} , $file->{file}, (join '|', @{$file->{class}} );
}


print qq {
    
    Summe : $sumloc LOC

};
