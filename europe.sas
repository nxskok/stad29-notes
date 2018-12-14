options linesize=70 pagesize=30;
goptions reset=all;

data euro(type=distance);
  infile "europe.dat" delimiter=",";
  input city $ Amsterdam Athens 
    Barcelona Berlin Cologne Copenhagen Edinburgh Geneva London 
    Madrid Marseille Munich Paris Prague Rome Vienna;

proc mds level=absolute out=y outres=z;

proc print data=y;

proc sort data=z;
  by residual;

proc print data=z;
  var _row_ _col_ residual;

symbol1 pointlabel=('#_label_');

  
proc gplot data=y;
  plot dim1 * dim2;

  
proc gplot data=y;
  plot dim2*dim1;

run;




