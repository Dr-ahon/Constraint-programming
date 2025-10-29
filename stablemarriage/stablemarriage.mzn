include "alldifferent.mzn";
enum men;
enum women;
array [1..3, men] of women: pref_men;
array [1..3, women] of men: pref_women;

array [men] of var women: couples;

constraint alldifferent(couples);

solve minimize sum(man in men)([x|x in pref_men[x, woman] == man /\ couples[man] == woman])