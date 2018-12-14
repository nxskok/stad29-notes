options linesize=75;

data rm;
  infile "rm4.dat";
  input trt $ y1 y2 y3 y4;

proc glm;
  class trt;
  model y1 y2 y3 y4 = trt / nouni;
  repeated time;


