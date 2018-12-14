#!/usr/bin/perl
use strict;

my $fname=shift;

# check for existence of files in current directory and copy them from
# SAS directory if needed

system "cp /home/ken/stad29/sas/$fname.sas ." unless -e "$fname.sas";
system "cp /home/ken/stad29/sas/$fname.dat ." unless -e "$fname.dat";

# de-dos .dat file

system "perl dedos.pl $fname";

# create swv file

# headings (here doc check)

open my $out, ">", "$fname.swv";
print $out <<E1;
\\documentclass{article}
\\title{The $fname data}
\\usepackage{graphicx}
\\begin{document}
\\maketitle
\\SASweaveOpts{prompt=""}
\\weaveOpts{newlang = SASwide:SAS}
\\SASwideweaveOpts{outfmt = "fontsize=\\scriptsize", prompt = ""}
The data:
E1

# print out the data in verbatim environment

print $out <<E2;
\\begin{verbatim}
E2

open my $in, "<", "/home/ken/stad29/notes/$fname.dat" or die "$!";
while (<$in>) {
  print $out $_;
}
print $out <<E3;
\\end{verbatim}
E3

# get SAS code

print $out <<E4;
The SAS code and output:
\\begin{SAScode}
E4

open my $in, "<", "/home/ken/stad29/notes/$fname.sas" or die "$!";
while (<$in>) {
  print $out $_;
}

print $out <<E5;
\\end{SAScode}
E5


print $out "\\end{document}\n";
close $out;

system "statweave $fname.swv";

system "evince $fname.pdf &";

