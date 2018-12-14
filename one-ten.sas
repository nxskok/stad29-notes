data lang(type=distance);
	infile "one-ten.dat";
	input lang $ en no dk nl de fr es it pt hu sf;

proc print;

proc cluster method=single outtree=tree;
  id lang;

proc tree horizontal;
  id lang;

proc cluster data=lang method=ward outtree=tree2;
  id lang;

proc tree horizontal data=tree2;
  id lang;


run;

