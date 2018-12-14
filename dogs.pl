open IN, "dogs_orig.dat";

while (<IN>) {
    chomp;
    ($drug,$dep,@y)=split;
    @l=();
    for (@y) {
	push @l, log;
    }
    printf "%-20s %1s %6.2f %6.2f %6.2f %6.2f\n",$drug,$dep,@l;
}
