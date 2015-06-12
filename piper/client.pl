use Win32::Pipe;

my $pipe = new Win32::Pipe("\\\\.\\pipe\\piper");
my $text = join (' ' , @ARGV);

$pipe->Write($text);

my $res = $pipe->Read();
$pipe->Close();
print "$res\n";

