set of int: right = 1..5;
set of int: left = {-x | x in right};
set of int: places = left union right;
enum boys = {A, B, C};
array [boys] of int: weights = [36, 32, 16];

array [boys] of var places: seats;

constraint seats[A] in left; 
constraint sum(b in boys)(weights[b] * seats[b]) = 0;
constraint forall(i, j in boys where i != j)(seats[i] - seats[j] > 2 \/ seats[j] - seats[i] > 2);

