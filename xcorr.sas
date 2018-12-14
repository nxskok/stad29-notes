options linesize=70;

data xc;
  infile "xcorr.dat";
  input x1 x2 x3;

proc princomp out=fredd;

proc print;

proc corr data=xc out=fred;

proc print;


