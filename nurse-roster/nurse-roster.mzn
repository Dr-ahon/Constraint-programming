int: num_nurses;
int: num_days;
int: req_day;
int: req_night;
int: min_night;
enum shifts = {o, n, d};

include "atleast.mzn";

array [1..num_nurses, 1..num_days] of var shifts: schedule;

% nesmi mit 3 nocni po sobe
constraint forall(nurse in 1..num_nurses, day in 1..num_days - 2)(
                  ([schedule[nurse, d] | d in day..day + 2] != [n, n, n]));
    
% nesmi pracovat 4 dny v kuse                                            
constraint forall(nurse in 1..num_nurses, day in 1..num_days - 3)(
                  at_least(1, [schedule[nurse, x] | x in day..(day + 3)], o));                      

% pocet sester pres den
constraint forall(day in 1..num_days)(
                  at_least(req_day, [schedule[n, day]| n in 1..num_nurses], d));
                  
constraint forall(day in 1..num_days)(
                  at_least(req_night, [schedule[n, day]| n in 1..num_nurses], n));                
              
% odpracovani nocnich                      
constraint forall(nurse in 1..num_nurses)(
                  at_least(min_night, [schedule[nurse, d]| d in 1..num_days], n));                    
                  
solve satisfy;

output [ show(schedule[i, j]) ++ if j==num_days then "\n" else " " endif
        | i in 1..num_nurses, j in 1.. num_days]                  