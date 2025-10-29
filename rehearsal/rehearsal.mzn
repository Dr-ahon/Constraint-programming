include "alldifferent.mzn";
include "disjunctive.mzn";
include "arg_sort.mzn";

% number of players
int: num_players;
% number of songs 
int: num_pieces;
% the biggest possible starting time
int: max_starting_time = sum(duration) - min(duration);
% table which has players on x axis and songs on y axis and contains 0s and 1s. 1 if the player plays in the particular song
array[1..num_players, 1..num_pieces] of 0..1: table;
% an array containing int durations of all played songs
array[1..num_pieces] of int: duration;

% the sum of all times spent by waiting for rehearsal through all players
var int: waiting_time = sum([get_waiting_time(p) | p in 1..num_players]);
% the order of songs to rehearse
array[1..num_pieces] of var 1..num_pieces: schedule;
% an array of starting times of all rehearsed songs
array[1..num_pieces] of var 1..max_starting_time: starting_time;

% an array of times players spend by actively rehearsing
array[1..num_players] of 1..max_starting_time: played_time = [get_played_time(p) | p in 1..num_players];


% returns total time spent by the player at the rehearsals 
function var int: get_present_time(int: player)=(
      get_last_song_starting_time(player) - 
      get_first_song_starting_time(player) + 
      duration[index_of(get_last_song_starting_time(player), starting_time)]
      );

% returns the time the player spends by actively rehearsing
function int: get_played_time(int: player)=
    sum([duration[x] | x in get_his_songs(player)]);

% returns the time the player spends by waiting for rehearsal     
function var int: get_waiting_time(int: player)=(
      get_present_time(player) - played_time[player]);

% returns the time when does the player's last song that day start
function var int: get_last_song_starting_time(int: player) =
      max([starting_time[s] | s in get_his_songs(player)]);

% returns the time when does the player's first song that day start       
function var int: get_first_song_starting_time(int: player) =
      min([starting_time[s] | s in get_his_songs(player)]);

% returns a list of names of songs that a certain player participate in 
function array[int] of int: get_his_songs(int: player)=(
      [i | i in 1..num_pieces
       where table[player, i] == 1]);

% returns an index of an int in an array of ints
function var int: index_of(var int: x, array[int] of var int: arr) = 
   sum([i | i in index_set(arr) where x = arr[i]]);


constraint schedule = arg_sort(starting_time);
   
% songs doesn't intersect        
constraint disjunctive(starting_time, duration);
   

solve minimize waiting_time;
output["for the schedule \(schedule) the total waiting time is \(waiting_time)"];
