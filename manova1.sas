data manova1;
  infile "manova1.dat";
  input fertilizer $ yield weight;
  sum=yield+weight;

proc means;
  var yield weight;
  class fertilizer;

proc glm;
  class fertilizer;
  model yield=fertilizer;

proc glm;
  class fertilizer;
  model weight=fertilizer;

proc gplot;
  plot yield*weight=fertilizer;

proc glm;
  class fertilizer;
  model yield weight=fertilizer;
  manova h=_all_;

proc discrim can out=fred;
  class fertilizer;
  var yield weight;

proc print data=fred;

proc glm;
  class fertilizer;
  model sum=fertilizer;
    
run;
