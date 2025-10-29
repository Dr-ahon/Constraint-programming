include "table.mzn";

enum FOOD;
set of FOOD: desserts;
set of FOOD: mains;
set of FOOD: sides;
enum FEATURE = {name, energy, protein, salt, fat, cost};

array [FOOD, FEATURE] of int: dd;

int: min_energy;
int: min_protein;
int: max_salt;
int: max_fat;

var int: budget;
array [FEATURE] of var int: dessert;
array [FEATURE] of var int: main;
array [FEATURE] of var int: side;

constraint table(dessert, dd);
constraint table(main, dd);
constraint table(side, dd);

constraint dessert[name] in desserts;
constraint main[name] in mains;
constraint side[name] in sides;

constraint sum([dessert[fat], main[fat], side[fat]]) <= max_fat;
constraint sum([dessert[salt], main[salt], side[salt]]) <= max_salt;
constraint sum([dessert[energy], main[energy], side[energy]]) >= min_energy;
constraint sum([dessert[protein], main[protein], side[protein]]) >= min_protein;
constraint sum([dessert[cost], main[cost], side[cost]]) = budget;


solve minimize(budget)




