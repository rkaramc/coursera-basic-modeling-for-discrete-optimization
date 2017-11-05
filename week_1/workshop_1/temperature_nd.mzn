% parameters
array[int] of int: readings;
int: start;

int: l = length(readings);
set of int: TIME = 0..l;

% variables
array[TIME] of var int: temp;

% constraints
constraint temp[0] = start;
constraint forall(i in 1..l)(
  temp[i] = (temp[i-1] + readings[i]) div 2
);

% solver
solve satisfy;

% output
output [show(readings), "->", show(temp)];