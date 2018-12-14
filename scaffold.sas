options linesize=70;

data scaffold;
  infile "scaffold.dat";
  input material $ weeks gpi;

proc glm;
  class material weeks;
  model gpi=material|weeks;
  lsmeans material*weeks / adjust=tukey lines;
  lsmeans material / adjust=tukey lines;
  lsmeans weeks / adjust=tukey lines;

      
run;
