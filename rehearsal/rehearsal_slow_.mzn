include "alldifferent.mzn";
int: num_players;
int: num_pieces;
array[1..num_players, 1..num_pieces] of 0..1: table;
array[1..num_pieces] of int: duration;

array[1..num_pieces] of var 1..num_pieces: schedule;
array[1..num_players] of var int: waiting_time;
array[1..num_players] of var int: played_time;
array[1..num_players] of var int: present_time;

function var int: get_starting_time(var int: song) =
      %sum([duration[x]| x in [schedule[y] | y in 1..get_rank(song)]]);
      sum([duration[s] | s in 1..num_pieces where index_of(s, schedule) < index_of(song, schedule)]);
      

function var int: get_present_time(int: player)=(
      get_starting_time(get_last_song(player)) - 
      get_starting_time(get_first_song(player)) + 
      duration[get_last_song(player)]    
      );

function var int: get_rank(var int: song)=(
      sum([x | x in 1..num_pieces where schedule[x] == song]));

function var int: get_played_time(int: player)=(
      sum([duration[x] | x in get_his_songs(player)])
      );
      
function var int: get_waiting_time(int: player)=(
      get_present_time(player) - get_played_time(player));

       
function var int: get_last_song(int: player)=
      deopt(schedule[(max([index_of(x, schedule) | x in get_his_songs(player)]))]);
       
function var int: get_first_song(int: player)=(
      deopt(schedule[(min([index_of(x, schedule) | x in get_his_songs(player)]))])
       );
       
   
function array[int] of var int: get_his_songs(int: player)=(
      [i | i in 1..num_pieces
       where table[player, i] == 1]);

function var int: index_of(var int: x, array[int] of var int: arr) = 
   (max([if x = arr[i] 
           then i
           else 0 endif  
          | i in index_set(arr) ]
   ));

constraint alldifferent(schedule); 

constraint forall(player in 1..num_players)(
      waiting_time[player] = get_waiting_time(player));

constraint forall(player in 1..num_players)(
      played_time[player] = get_played_time(player));
  
constraint forall(player in 1..num_players)(
      present_time[player] = get_present_time(player));
  
solve minimize sum(waiting_time);
output[show(schedule)];
output[show(sum(waiting_time))];
