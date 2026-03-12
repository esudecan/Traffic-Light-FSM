Hacettepe University ELE432 Advanced Digital Design 03/2026 
Assignment 1: Warm-Up – Traffic Light Controller FSM (with Delay) 

The project implements a 4-state Finite State Machine (FSM) to manage traffic lights at an intersection (Street A and Street B).
It features a dynamic timer that manages 5-second delays for yellow light transitions.

FSM States:
S0 (Green-Red): Street A is Green, Street B is Red. Stays here while TAORB is true.
S1 (Yellow-Red): Street A transitions to Yellow for 5 time units.
S2 (Red-Green): Street A is Red, Street B is Green. Stays here while TAORB is false.
S3 (Red-Yellow): Street B transitions to Yellow for 5 time units.
