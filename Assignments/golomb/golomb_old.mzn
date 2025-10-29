include "alldifferent.mzn";
include "increasing.mzn";

int: n = 9;
int: max_length = 1000;
var int: length = max(marks);

array [1..n] of var 0..max_length: marks;

constraint alldifferent([x - y | x, y in marks where x < y]);

solve minimize length;

