options linesize=70;

data yc(type=corr);
  infile "ycorr.dat";
  input x1 x2 x3;

proc print;

proc princomp;

