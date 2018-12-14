data rohwer;
    infile "Rohwer.dat" firstobs=2;
    input group SES $ SAT PPVT Raven n s ns na ss;
    if SES='Lo';

proc print;

proc reg;
    model SAT PPVT Raven = n s ns na ss;
    mtest;
    n: mtest n;
    s: mtest s;
    ns: mtest ns;
    na: mtest na;
    ss: mtest ss;


proc reg;
    model SAT PPVT Raven = ns na;
    mtest;
    ns2: mtest ns;
    na2: mtest na;

proc reg;
    model SAT PPVT Raven = na;
    na3: mtest;
    
run;

   
