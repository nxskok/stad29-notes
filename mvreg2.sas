data mvreg;
    input z1 z2 y1 y2 y3;
    cards;
    0 1 1 5 10
    1 2 4 6 11
    2 3 6 5 13
    3 1 5 4 9
    4 2 8 6 12
    5 3 9 5 14
    6 1 6 6 9
    ;

proc reg;
    model y1 y2 y3 = z1 z2;
    mtest;
    
proc cancorr out=z;
    var y1 y2 y3;
    with z1 z2;

proc print;
    
run;

