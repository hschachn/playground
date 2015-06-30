use strict;

map {
    print "> $_\n";    
} @ARGV; 

# Value returned by the last statment is 
# returned if file is included through 'do' statement
scalar @ARGV;
