use strict;
use DBI;
use Config::Simple;

##
#
##



my $config = new Config::Simple( 'db.ini');

my $DBSERVER = $config->param("DBSERVER");
my $DATABASE = $config->param("DATABASE");
my $USER = $config->param("USER",);
my $PASSWD = $config->param("PASSWD");



my $dbh = DBI->connect( "DBI:ODBC:Driver={SQL Server};Server=$DBSERVER;Database=$DATABASE", $USER, $PASSWD);


my $sql = 'SELECT IFCADT_GUID FROM IFC_HL7ADT';

my $sth = $dbh->prepare($sql);
$sth->execute();
 while (my $row = $sth->fetchrow_hashref) {
    print "IFCADT_GUID = $row->{IFCADT_GUID}\n";
 }
$dbh->disconnect;
