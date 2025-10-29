% Use this editor as a MiniZinc scratch book
int:  max;

var int: a;
var int: b;
var int: c;

constraint a^2 + b^2 = c^2;
constraint a <= max;
constraint a > 0;
constraint b <= max;
constraint b > 0;
constraint c <= max;
constraint c > 0;

constraint a < b;

output [" a= " ++ show(a), " b= " ++ show(b), " c= " ++ show(c)]
