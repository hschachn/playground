use strict;
use Getopt::Long;
use File::Find;

# Checks source code in a given folder for pre-defined patterns

my $folder = '.';

GetOptions( 'folder=s' => \$folder );



# result of first function is used as input for second one
sub chain  { my ( $f1, $f2 ) = @_; return sub { return $f2->( $f1->(@_)); }}

my $action1 = sub {
    my $in = shift;
     print "STATIC : $in->{file} \@$in->{lc}: $in->{line}\n" if $in->{line} =~ /^\s*(protected|private|public)?\s+static\s+.+=.+;/ ;
    return $in;
};

my $action2 = sub {
    my $in = shift;
    #print "DICT   : $in->{file} \@$in->{lc}: $in->{line}\n" if ( $in->{line} =~ /^\s*(Dictionary)/ );
    return $in;
};

my $analyzer = chain ( $action1, $action2 );

sub analyze {
    my $file = shift;

    my $content = sub {
        open my $fh, '<', $file or die "$! : <$file>";
        local $/;
        <$fh>
    }->();
    
    my @lines = split /\n/, $content;

    my $lc = 0;
    foreach my $line(@lines){
        $analyzer->( { line => $line , file => $file , lc => ++$lc });
    }
}


finddepth ( { 
    wanted => sub {
        return if $File::Find::name !~ /\.cs(html)?$/i;
        # print "Checking $File::Find::name\n";
        analyze( $File::Find::name );
    }, no_chdir => 1
} , ( $folder ) );
