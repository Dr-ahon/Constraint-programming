include "alldifferent.mzn";
include "increasing.mzn";

int: n = 9;
int: max_length = 1000;
var int: length = max(marks);
%var set of int: marks;
array [1..n] of var 0..max_length: marks;
array[1..n, 1..n] of var 0..max_length: dist;

%constraint card(marks) = n;
%constraint alldifferent(marks);
constraint marks[1] = 0;
constraint forall(i, j in 1..n where i<j)(dist[i, j] == abs(marks[i]-marks[j]));
constraint alldifferent(i, j in 1..n where i<j)(dist[i, j]);
constraint increasing(marks);
%constraint alldifferent(marks);
%constraint marks subset 1..length;

solve minimize length;
output["length: \(length), marks: " ++ show(marks)];