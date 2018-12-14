options ls=70;
ods html;
ods graphics on;

data ex;
  infile "exercise.dat";
  input exercise $ pulse1 pulse2 pulse3 diet $;

proc means mean;
  class exercise diet;
  var pulse1--pulse3;

proc glm data=ex;
  class exercise diet;
  model pulse1 pulse2 pulse3 = exercise|diet / nouni;
  repeated intensity;


run;

