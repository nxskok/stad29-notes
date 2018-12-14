data birthrate;
  infile "birthrate.dat";
  input birth death infant country $ @@;

proc cluster method=average ccc standard;
  id country;

proc standard mean=0 std=1;

proc fastclus maxclusters=6 out=clust;
    id country;

proc sort data=clust;
    by cluster;

proc print data=clust;
    by cluster;


run;


