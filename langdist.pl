open IN, "languages.dat" or die "Cannot open languages file: $!";

my %f=();
while (<IN>) {
    my @line=split /:/;
    my @first=map { substr $_, 0, 1} @line;
    $f{$line[0]}=[@first];    
}

my @idx=sort keys %f;

for my $i (@idx) {
    print "$i ";
    for my $j (@idx) {
	my $d=distance($i,$j,\%f);
	printf "%3d", $d;
    }
    print "\n";
}

sub distance {

    my ($i,$j,$f)=@_;

    my @fi=@{$f->{$i}};
    my @fj=@{$f->{$j}};

    my $d=10;
    for my $k (1..10) {
	$d-- if $fi[$k] eq $fj[$k];
    }

    return $d;

}
