data groups;
  infile 'threegroups.dat';
  input group $ y;

proc print;

proc means;
  class group;
  var y;

run;
