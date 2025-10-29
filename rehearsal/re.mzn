include "alldifferent.mzn";
include "regular.mzn";
int: num_players;
int: num_pieces;
array[1..num_players, 1..num_pieces] of 0..1: table;
array[1..num_pieces] of int: duration;

array[1..num_pieces] of var 1..num_pieces: schedule;
array[1..num_players] of var int: waiting_time;
array[1..num_players] of var int: played_time;



   
constraint forall(player in 1..num_players)( played_time[player] == sum([duration[song] | song in [table[player, z]| z in 1..num_pieces]]));
constraint alldifferent(schedule);

output[show(played_time)]