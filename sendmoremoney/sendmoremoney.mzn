include "alldifferent.mzn";

var int: s;
var int: e;
var int: n;
var int: d;
var int: m;
var int: o;
var int: r;
var int: y;

constraint (s + m) * 1000 + (e + o) * 100 + (n + r) * 10 + d + e = m * 10000 + o * 1000 + n * 100 + e * 10 + y;

constraint s > 0;
constraint e >= 0;
constraint n >= 0;
constraint d >= 0;
constraint m > 0;
constraint o >= 0;
constraint r >= 0;
constraint y >= 0;

constraint s < 10;
constraint e < 10;
constraint n < 10;
constraint d < 10;
constraint m < 10;
constraint o < 10;
constraint r < 10;
constraint y < 10;

constraint all_different([s,e,n,d,m,o,r,y]);