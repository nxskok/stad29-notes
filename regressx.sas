options linesize=70;

data regr;
  infile "regressx.dat" firstobs=2;
  input subject timedrs phyheal menheal stress;

proc reg;
  model timedrs = phyheal menheal stress;
  output out=z1 p=pred1 r=res1;
  model timedrs = menheal;

proc plot vpercent=50 data=z1;
  plot res1 * pred1;

proc univariate plot;
  var res1;


data reg2;
  infile "regressx.dat" firstobs=2;
  input subject timedrs phyheal menheal stress;
  lgtime=log(timedrs+1);

proc reg;
  model lgtime=phyheal menheal stress;
  test menheal=0, phyheal=0;
  test menheal=0.02, phyheal=0.2;
  output out=z2 p=pred2 r=res2;

proc plot vpercent=50;
  plot res2*pred2;


