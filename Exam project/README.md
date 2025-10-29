# Rehearsal Scheduling Problem

## Problem Description

The rehearsal scheduling problem is about finding an optimal ordering of pieces for an orchestra rehearsal.  
In the file `rehearsal_data.mzn`, we have:

- `table` – a schedule showing which musician plays in which piece.
- `duration` – an array specifying the duration of each piece.

The goal of the program is to find an ordering of pieces that **minimizes the total waiting time** for musicians between their pieces, under the assumption that there is **only one rehearsal room**, so pieces cannot overlap.

---

## Approach

My first solution (`rehearsal_slow.mzn`) seemed promising – the generated schedules were correctly evaluated – but it did not reach the optimal solution even after two hours of computation.

Then I:

1. Removed unnecessary variables and functions.
2. Added a **global `disjunctive` constraint**.
3. Shifted the solver’s focus from `schedule` to `starting_times`.

The result of this optimization is in `rehearsal_19.mzn`, which significantly sped up computation. However, it still stalled just before reaching the optimum.

---

### Final Version

To fix this issue, I:

- Redesigned the computation of the `waiting_time` variable.
- Moved it from a special constraint directly into the variable declaration.
- Stored the **sum** of waiting times instead of a list of integers, which is what the solver minimizes.

The final version of the program is `rehearsal_final.mzn`.

An interesting observation:

- The solver Gecode’s runtime depends on which variables are printed.
- Printing `schedule`, `waiting_time`, and `starting_time` ran correctly.
- Removing the output of `starting_time` caused the computation to slow down dramatically.

---

## Results

The program `rehearsal_final.mzn`:

- Finds the optimal solution based on the provided data (`rehearsal_data.mzn`).
- Optimal order of pieces: `[3, 8, 2, 7, 1, 6, 5, 4, 9]`.
- Total waiting time: `17`.
- Using the **Chuffed** solver, it takes approximately **16 seconds**.
