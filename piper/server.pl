use Win32::Pipe;

my $pipe = new Win32::Pipe("piper");

my $i = 0;
while (1) {
    $pipe->Connect();
    my $data = $pipe->Read();
    $pipe->Write('ACK');
    $pipe->Disconnect();
    print sprintf ("%08d : Received: %s\n" , ++$i, $data);
}
