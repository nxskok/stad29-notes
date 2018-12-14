data lang(type=distance);
	infile "one-ten.dat";
	input lang $ en no dk nl de fr es it pl hu sf;

proc mds level=ordinal out=coords outres=dist;
    id lang;

proc print data=dist;
   var _row_ _col_ data distance residual;

proc print data=coords;

symbol1 pointlabel=('#lang');

proc gplot data=coords;
    plot dim2 * dim1;

run;
