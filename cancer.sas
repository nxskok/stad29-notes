	data cancer;
	  infile "cancer.dat";
	  input stage $ operation $ xray $ survival $ count;

proc catmod;
  weight count;
  model stage*operation*xray*survival=_response_;
  loglin stage|operation|xray|survival;

proc catmod;
  weight count;
  model stage*operation*xray*survival=_response_;
  loglin stage|operation|xray|survival @ 2;

proc catmod;
  weight count;
  model stage*operation*xray*survival=_response_;
  loglin stage operation xray survival stage*survival;

run;
