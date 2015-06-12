use Win32::Pipe;


while (1) {

    print '> ';
    my $text = <STDIN>;
    
    chomp $text;
    my $pipe = new Win32::Pipe("\\\\.\\pipe\\piper");
    die "Cannot connect server!\n" if not $pipe;
    $pipe->Write($text);

    my $res = $pipe->Read();
    $pipe->Close();
    print "> $res\n";

}
