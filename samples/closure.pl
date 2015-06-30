use strict;
use Data::Dump;
# Use closure for creating a read-only structure

#sub get_rof {

#    my $parameter = shift;

#    return sub {
#        return {
#            para  => $parameter,
#            derived => "Derived from $parameter"
#        }
#    }
#}
#*rof = get_rof( shift );

my $parameter = shift;
*rof = do {
    sub {
        return {
            para  => $parameter,
            derived => "Derived from $parameter",
            func => sub { my $x = shift; return "$x hoch 2"; }
        }
        
    }
};

my $prr = &rof;
Data::Dump::dump( rof() );


print  rof()->{derived}."\n";
$prr->{derived} = 'ANHSI';
print  "$prr->{derived}\n";
print  rof()->{derived}."\n";
print rof()->{func}->( 23 );
