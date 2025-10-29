include "alldifferent.mzn";
int: n;

array[1..n] of var 1..n: queens;

constraint alldifferent(queens);

constraint forall(i, j in 1..n where i < j)(abs(i - j) != abs(queens[i] - queens[j]));

solve satisfy;

output [if fix(queens[j] == i) then
          if j == n then " Q \n" else " Q " endif
        else
          if j == n then " - \n" else " - " endif
        endif | i in 1..n, j in 1..n] ++
        ["\n Queens: \(queens)"];
