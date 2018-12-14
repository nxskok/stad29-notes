data ts;
  infile "trend.dat" termstr=crlf;
  input x; 	

proc arima;
  identify var=x scan esacf stationarity=(adf=(0,1,2));

proc arima;
  identify var=x(1) scan esacf stationarity=(adf=(0,1,2));

proc arima;
  identify var=x(1);
  estimate p=0 q=2;
  forecast;

proc arima;
  identify var=x(1);
  estimate p=2 q=2;
  forecast;

run;
