use strict; 
use warnings; 

use Win32::Pipe;
use List::Util qw(shuffle);

use sigtrap qw/handler signal_handler normal-signals/;

sub signal_handler {
    die "Caught a signal $!";
}

sub fib {
    
    my $n = $_[0];
    return 0 if $n eq 0;
    return 1 if $n eq 1;
    return $n * fib ($n - 1);
}


my $i = 0;
while (1) {
    my $pipe = new Win32::Pipe("piper");
    $pipe->Connect();
    my $data = $pipe->Read();
    #my $output = join '', shuffle(split //, $data);
    my $output;
    $output = fib($data) if $data and $data ge 0;
    sleep(3);
    $pipe->Write($output);
    $pipe->Disconnect();
    print sprintf ("%08d : Received %s\n" , ++$i, $data);
}
