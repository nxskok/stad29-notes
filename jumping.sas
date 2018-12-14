data jumping;
  infile "jumping.dat" delimiter='09'x;
  input group $ g density;

options linesize=70;

proc glm;
  class group;
  model density=group;
  lsmeans group / adjust=tukey lines;
  lsmeans group / adjust=bon lines;

run;
