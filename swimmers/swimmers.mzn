include "alldifferent.mzn";
enum styles;
enum swimmers;
array [styles, swimmers] of int: times;
array [styles] of var swimmers: team;
constraint alldifferent(team);
solve minimize (sum(i in styles)(times[i, team[i]]));
output[show(sum(i in styles)(times[i, team[i]])), show(team)]
