libname sasdata '.';

data factor;
  set sasdata.factor;

ods html;
ods graphics on;

proc factor method=prinit scree;
  
proc factor method=prinit nfactor=5 rotate=varimax out=fred;

symbol1 pointlabel=('#subno');
        
proc gplot data=fred;
  plot Factor2*Factor1;

data fred2;
    set fred;
    if subno=474 or subno=457 or subno=528;

proc print;

    
run;
