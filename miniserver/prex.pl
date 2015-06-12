my $string = shift;

my @result = $string =~ m#^((?:/)?(\w+))+#;

print join(',', map {qq|'$_'|} @result );
