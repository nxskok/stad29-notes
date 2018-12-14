options linesize=70 pagesize=25;

data cube(type=distance);
  infile "cube.dat";
  input corner $ a b c d e f g h;

proc mds level=absolute out=coords outres=res;

proc print data=res;

symbol1 pointlabel=('#_label_');

proc gplot data=coords;
  plot dim2*dim1;

proc mds data=cube dim=3 level=absolute outres=res;

proc print data=res;


