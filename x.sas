data xy;
    input x y;
    cards;
    1 4
    2 7
    3 6
    4 8
        ;

proc reg;
    model y=x;
    plot y*x;
    plot r.*p.;



run;


