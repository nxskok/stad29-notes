data scaffold;
  infile "scaffold2.dat";
  input material $ weeks gpi;

proc print;

proc glm;
  class material weeks;
  model gpi=weeks|material;

proc glm;
  class material weeks;
  model gpi=weeks material;
  lsmeans material weeks / adjust=tukey lines;
  
run;
