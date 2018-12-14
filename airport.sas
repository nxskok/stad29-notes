options ls=80;

data airline;
  infile "airport.dat";
  input airport $ airline $ status $ freq;

proc catmod;
  weight freq;
  model airport*airline*status=_response_;
  loglin airport|airline|status @ 2;

run;
