options linesize=75;

data dogs;
    infile "dogs2.dat";
    input Drug $ x $ lh1 lh2 lh3 lh4;
    avg=(lh1+lh2+lh3+lh4)/4;
    
proc glm;
    class Drug;
    model lh1 lh2 lh3 lh4 = Drug / nouni;
    repeated Time;
    lsmeans Drug;
    
proc glm;
    class Drug;
    model avg=Drug;
    lsmeans Drug;


run;
