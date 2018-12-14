options ls=70;

/* ods html;
   ods graphics on;
*/

data ex;
  infile "exercise.dat";
  input exercise $ pulse1 pulse2 pulse3 diet $;
  gp=cat(diet,"-",exercise);
  one=pulse1/pulse1;

proc discrim can list out=fred;
  class gp;
  var pulse1--pulse3;

proc print;
    var gp pulse1 pulse2 pulse3 can1 _into_;

proc print;
    var gp meat_____racquetb meat_____stairs meat_____weights
           veg______racquetb veg______stairs veg______weights;

goptions reset=all;
symbol1 c=red v=x;
symbol2 c=blue v=o;
symbol3 c=green v=triangle;
symbol4 c=black v=diamond;
symbol5 c=purple v=plus;
symbol6 c=cyan v=square;
    
proc gplot;
    plot can2*can1=gp;

proc discrim data=ex can out=ginger;
    class diet;
    var pulse1--pulse3;

proc print;
    var diet pulse1 pulse2 pulse3 can1 meat veg _into_;

proc gplot;
    plot one*can1=diet;

run;

