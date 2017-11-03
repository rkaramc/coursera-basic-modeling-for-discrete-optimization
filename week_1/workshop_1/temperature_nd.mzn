array[int] of int: readings;
int: start;
array[int] of int: temp;
constraint temp = readings;
solve satisfy;

output [show(readings), "->", show(temp)];