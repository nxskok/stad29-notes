options ls=70;

data recife;
  infile "recife.dat" termstr=crlf;
  input x @@;

proc arima;
  identify var=x(12);
  estimate q=(1 12);
  forecast printall;

run;

