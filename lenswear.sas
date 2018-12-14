data lens;
infile "lenswear.dat";
input sex $ lenswear $ frequency;

proc catmod;
weight frequency;
model sex*lenswear=_response_;
loglin sex lenswear sex*lenswear;

proc catmod;
  weight frequency;
  model sex*lenswear=_response_;
  loglin sex lenswear;









