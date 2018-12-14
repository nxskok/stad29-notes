
options linesize=70;

data test;
    infile "test23.dat";
    input score1 score2 score3;

proc gplot;
    plot score2*score3;
    
proc princomp out=fred;
   var score2 score3;

proc print;
