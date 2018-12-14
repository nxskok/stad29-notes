
options linesize=70;

data test;
    infile "test12.dat";
    input score1 score2;

proc gplot;
    plot score2*score3;
    
proc princomp out=fred;

proc print;
