use strict;

# 'our' is required for localizing
our $std = 27;

print "$std\n";

my $b = do {
    local $std = 'Hansi';
    $std
};

print "b : $b  std : $std \n";


my $b = do {
    $std = 'Peter';
    $std
};
print "b : $b  std : $std \n";
