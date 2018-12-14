data crops;
    infile "remote-sensing.dat";
    input Crop $ x1-x4 label $;
    
proc discrim can list pool=test out=zz crosslist;
    class Crop;
    var x1-x4;

goptions reset=all;
symbol1 c=blue v=triangle;
symbol2 c=cyan v=circle;
symbol3 c=red v=diamond;
symbol4 c=black v=plus;
symbol5 c=green v=x;

proc gplot;
plot Can1 * Can2 = Crop;
run;
