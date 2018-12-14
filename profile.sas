options linesize=80;

data profile;
  infile "profile.dat";
  input group $ read dance tv ski;

proc means;

proc glm;
  class group;
  model read dance tv ski = group / nouni;
  repeated activity 4 profile;
  lsmeans group;

run;
