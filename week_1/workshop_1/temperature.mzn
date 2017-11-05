% parameters
array[int] of int: readings;
int: start;
enum ACTIONS = {heat, strongly_heat, cool, strongly_cool, do_nothing};
array[ACTIONS] of int: result = [+1, +4, -2, -5, 0];
array[ACTIONS] of int: cost = [1, 5, 3, 9, 0];

% variables
array[0..length(readings)] of var int: temp_nd;
array[0..length(readings)] of var 25..30: temp;
array[1..length(readings)] of var ACTIONS: action_taken;
array[1..length(readings)] of var int: action_cost;
var int: total_cost;

% constraints
constraint temp_nd[0] = start;
constraint forall(i in 1..length(readings))(
  temp_nd[i] = (temp_nd[i-1] + readings[i]) div 2
);

constraint temp[0] = start;
constraint forall(i in 1..length(readings))(
  temp[i] = (temp[i-1] + readings[i]) div 2 + result[action_taken[i]]
);

constraint action_cost = [cost[action_taken[i]] | i in 1..length(readings)];
constraint total_cost = sum(i in 1..length(readings))(cost[action_taken[i]]);

% solver
solve minimize total_cost;

% output
output [
  show(start), " + ", 
  show(readings), "->\n", 
  show(temp_nd), "->\n", 
  show(action_taken), "->\n", 
  show(temp), "->\n", 
  show(action_cost), "->\n", 
  show(total_cost)];