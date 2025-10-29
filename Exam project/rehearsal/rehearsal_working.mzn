include "alldifferent.mzn";
include "disjunctive.mzn";
include "arg_sort.mzn";

int: num_players;
int: num_pieces;
int: max_starting_time = sum(duration);
array[1..num_players, 1..num_pieces] of 0..1: table;
array[1..num_pieces] of int: duration;

array[1..num_pieces] of var 1..num_pieces: schedule;
array[1..num_pieces] of var 1..max_starting_time: starting_time;
% array[1..num_players] of var 1..max_starting_time: waiting_time;
array[1..num_players] of 1..max_starting_time: played_time = [get_played_time(p) | p in 1..num_players];
% array[1..num_players] of var 1..max_starting_time: present_time;

% array[1..num_players] of var 1..num_pieces: first_song;
% array[1..num_players] of var 1..num_pieces: last_song;

% function var int: get_starting_time(var int: song) =
%       %sum([duration[x]| x in [schedule[y] | y in 1..get_rank(song)]]);
%       sum([duration[s] | s in 1..num_pieces where index_of(s, schedule) < index_of(song, schedule)]);
 
function var int: get_present_time(int: player)=(
      get_last_song_starting_time(player) - 
      get_first_song_starting_time(player) + 
      duration[index_of(get_last_song_starting_time(player), starting_time)]
      );

function int: get_played_time(int: player)=
    sum([duration[x] | x in get_his_songs(player)]);
      
function var int: get_waiting_time(int: player)=(
      get_present_time(player) - played_time[player]);

       
% function var int: get_last_song(int: player)=
%       deopt(schedule[(max([index_of(x, schedule) | x in get_his_songs(player)]))]);

function var int: get_last_song_starting_time(int: player) =
      max([starting_time[s] | s in get_his_songs(player)]);
       
% function var int: get_first_song(int: player)=(
%       deopt(schedule[(min([index_of(x, schedule) | x in get_his_songs(player)]))])
%        );
       
function var int: get_first_song_starting_time(int: player) =
      min([starting_time[s] | s in get_his_songs(player)]);
   
function array[int] of int: get_his_songs(int: player)=(
      [i | i in 1..num_pieces
       where table[player, i] == 1]);

function var int: index_of(var int: x, array[int] of var int: arr) = 
   sum([i | i in index_set(arr) where x = arr[i]]);


% constraint alldifferent(schedule); 

% constraint forall(piece in 1..num_pieces)(
%       starting_time[piece] = get_starting_time(piece));

constraint schedule = arg_sort(starting_time);
      
% constraint forall(player in 1..num_players)(
%       first_song[player] = get_first_song(player));
      
% constraint forall(player in 1..num_players)(
%       last_song[player] = get_last_song(player));
           
constraint disjunctive(starting_time, duration);

% constraint forall(player in 1..num_players)(
%      waiting_time[player] = get_waiting_time(player));

% constraint forall(player in 1..num_players)(
%      played_time[player] = get_played_time(player));
  
% constraint forall(player in 1..num_players)(
%      present_time[player] = get_present_time(player));
      
var int: waiting_time = s   um([get_waiting_time(p) | p in 1..num_players]);

solve minimize waiting_time;
output[show(starting_time)];
output[show(schedule)];

output[show(waiting_time)];
%output[show(max_starting_time)]