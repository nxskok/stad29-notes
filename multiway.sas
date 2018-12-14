options ls=75;

data small;
  infile "multiway.dat";
  input profession $ sex $ readtype $ freq;

proc catmod;
  weight freq;
  model profession*sex*readtype=_response_;
  loglin profession sex readtype 
     profession*sex;

run;

