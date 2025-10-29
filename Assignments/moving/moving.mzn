include "cumulative.mzn";
enum items;
int: max_people;
int: max_trolleys;
int: max_time = sum(durations);
array [items] of int: durations;
array [items] of int: people;
array [items] of int: trolleys;

array [items] of var 0..max_time: schedule;
array [0..max_time] of var 0..max_people: people_needed;
array [0..max_time] of var 0..max_trolleys: trolleys_needed;

constraint forall(n in people_needed)(n <= max_people);
constraint forall(k in 0..max_time)(people_needed[k] = sum(i in items where schedule[i] <= k /\ k < schedule[i] + durations[i])(people[i]));

constraint forall(n in trolleys_needed)(n <= max_trolleys);
constraint forall(k in 0..max_time)(trolleys_needed[k] = sum(i in items where schedule[i] <= k /\ k < schedule[i] + durations[i])(trolleys[i]));


constraint cumulative(schedule, durations, people, max_people);
constraint cumulative(schedule, durations, trolleys, max_trolleys);

solve minimize max(i in items)(schedule[i] + durations[i]);
output[show(max(i in items)(schedule[i] + durations[i]))]