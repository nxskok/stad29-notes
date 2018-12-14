options linesize=70;

data x;
  infile "sepsis.dat";
  input death shock malnut alcohol age bowelinf;

proc logistic;
  model death=shock malnut alcohol age bowelinf;
  test malnut=0, bowelinf=0;

proc logistic;
  model death=shock alcohol age bowelinf;
  output out=z pred=p;

proc print data=z;
