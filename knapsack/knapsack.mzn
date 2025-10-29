enum Items;
array [Items] of int: weights;
array [Items] of int: prices;


array [Items] of var 0..1: sack;
array [Items] of var int: priced_sack;
array [Items] of var int: weighted_sack = [ weights[i] * sack[i]| i in Items];


constraint forall(i in Items)(prices[i] * sack[i] == priced_sack[i]);

constraint sum([ weights[i] * sack[i]| i in Items]) <= 23;
var int: sum = sum(priced_sack);
solve maximize sum;
  output[show(sum), " ", show(sum(weighted_sack))]