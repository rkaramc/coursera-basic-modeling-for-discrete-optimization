% data
int: nSpots = 10;
int: size = 3;
set of int: SPOT = 1..nSpots;
array[SPOT] of int: damage = [10, 8, 4, 2, 6, 9, 5, 3, 8, 10];

enum SYMB = { BG1, BG2, BG3, BG4, BG5, BG6, BG7, BG8 };
array[SYMB] of set of SPOT: group = [{1,4,6}, {1,2,6,7}, {1,3,6,8}, {1,2,3}, {2,9,10}, {5,6,8,10}, {7,8,10}, {1,3,5}];

% model
% var set of SPOT: attacks;
array[1..size] of var SPOT: attacks;
% constraint forall(i, j in 1..size where i < j)(attacks[i] != attacks[j]); % ensure all different
constraint forall(i in 1..size-1)(attacks[i] < attacks[i+1]); % ensure ordered, unequal and different

constraint forall(s in SYMB)(sum(i in 1..size)(attacks[i] in group[s]) <= 1);

var int: totalDamages = sum(i in 1..size)(damage[attacks[i]]);

solve maximize totalDamages;

output ["attacks = ", show(attacks), " damage = ", show(totalDamages)];