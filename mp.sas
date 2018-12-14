data mp;
    infile "mp.dat";
    input x1 x2;

proc ttest;
    paired x1*x2;

proc glm;
    model x1 x2 = /nouni;
    repeated time;

run;
