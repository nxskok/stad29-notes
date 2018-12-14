$fname=shift;

system "cp $fname.dat $fname-dos.dat";

open IN, "$fname-dos.dat";
open my $out, ">", "$fname.dat";
while (<IN>) {
  s/[\r\n]//g;
  print $out "$_\n";
}
close $out;

