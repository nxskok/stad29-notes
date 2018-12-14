
data one;
  input x y;
 cards;
1 4
2 8
3 9
4 10
5 13
;

proc plot;
 plot y*x;


