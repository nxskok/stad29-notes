data wells;
    infile "welldump.dat";
    input x y z;

proc gcontour;
    plot y*x=z;

run;
