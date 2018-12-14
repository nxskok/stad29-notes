options ls=70;

data ma1;
  infile "ma1.dat";
  input x;
  time=_n_;

/* symbol1 i=l;

proc gplot;
  plot x*time;

proc arima;
  identify var=x esacf scan
    stationarity=(adf=(0,1,2));

*/

proc arima;
  identify var=x;
  estimate p=0 q=1;
  forecast;

proc arima;
  identify var=x;
  estimate p=0 q=2 plot;


