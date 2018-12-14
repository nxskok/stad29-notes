options linesize=70;

data dancers;
  infile "survival1.dat";
  input months dancing treatment age;

proc print;
 
data mypred;
  input treatment age;
  datalines;
  0 25 
  0 45 
  1 25 
  1 45 
;

proc phreg data=dancers;
  model months*dancing(0) = age treatment;
  baseline out=fred covariates=mypred survival=s / nomean;

/*

goptions reset=all;
  
proc gplot;
  plot s*months;

proc gplot;
    plot s*months=age;

*/

data fred2;
  set fred;
  agetrt=cat(age,"-",treatment);  
  
proc print;

goptions reset=all;
symbol1 c=blue v=triangle i=l;
symbol2 c=cyan v=circle i=l;
symbol3 c=red v=diamond i=l;
symbol4 c=black v=plus i=l;

proc gplot;
  plot s*months=agetrt;  

run;

