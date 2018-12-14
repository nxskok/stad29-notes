options linesize=70;

data punt;
  infile "punting.dat";
  input left right punt fred;

proc reg;
  model punt=left right fred / vif;

proc reg;
  model punt=left right / vif;


run;
