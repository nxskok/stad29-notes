data drugs;
  infile "ancova.dat";
  input drug $ before after;
  diff=after-before;

proc means;
  class drug;

proc glm;
  class drug;
  model after=drug before;
  lsmeans drug;

proc ttest;
  class drug;
  var diff;

run;

