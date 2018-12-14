data manova2;
  infile "manova2.dat";
  input fertilizer $ yield weight;

proc discrim can list out=fred;
  class fertilizer;
  var yield weight;

proc print data=fred;

run;
