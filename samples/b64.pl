use MIME::Base64;
use Data::Dump;

my $string = 'PExhYmVscHJpbnQ+PEJhcmNvZGU+NTM4MDAwMDAwMDIyPC9CYXJjb2RlPjxOYW1lPnBhdGllbnQgdGVzdDwvTmFtZT48U2V4PkY8L1NleD48QmlydGhkYXRlPjA4LjAxLjIwMTY8L0JpcnRoZGF0ZT48UmVxdWVzdG9yPjwvUmVxdWVzdG9yPjxNYXRlcmlhbD5TYW1tZWx1cmluIChhbmdlc8OkdWVydCk8L01hdGVyaWFsPjxQcmludGVyPklOSVRfTEFCRUxfUFJJTlRFUjwvUHJpbnRlcj48L0xhYmVscHJpbnQ+';

my $dcstring = decode_base64($string);

print "$dcstring\n";
my $hex = uc unpack ( 'H*' , $dcstring );

my @hxd = $hex =~ /(.{2})/g;


my $i = 1;
my $width = 16;
my $chrline;
foreach my $hx( @hxd ) {
    
    print "$hx ";
    $chrline .= chr(hex( "0x$hx" ));
    if (not $i % $width) {
        print " $chrline\n";
        $chrline = "";
    }

    $i++;
}
