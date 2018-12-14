data rohwer;
  infile "Rohwer.dat" firstobs=2;
  input group SES $ SAT PPVT Raven n s ns na ss;
  if SES='Lo';

proc reg;
  model SAT PPVT Raven = na ns;
  mtest;


