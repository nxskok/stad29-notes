data rmat(type=corr);
  infile "rex2.dat";
  input _name_ $ para sent word add dots;

proc print;

proc factor scree method=prinit;

proc factor method=prinit rotate=varimax;

run;
