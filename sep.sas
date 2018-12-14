data sep;
  infile "sep.dat";
  input x1 x2 y n;

proc logistic;
  model y/n=x1 x2;
  output out=sep2 pred=pred lower=lcl upper=ucl;

proc print data=sep2;

run;
