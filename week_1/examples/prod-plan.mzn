% products
enum PRODUCT;
% profit per unit for each product
array[PRODUCT] of float: profit;

% resources
enum RESOURCE;
% amount of each resource available
array[RESOURCE] of float: capacity;

% units of each resource required to produce 1 unit of product
array[PRODUCT, RESOURCE] of float: consumption;

% variables: how much should we make of each product
array[PRODUCT] of var int: produce;

% must produce a non-negative amount
constraint forall(p in PRODUCT)(produce[p] >= 0);

% production can only use available resources
constraint forall(r in RESOURCE)(
  sum(p in PRODUCT)(
    consumption[p, r] * produce[p]) <= capacity[r]);

% maximize profit
solve maximize sum(p in PRODUCT)(
  profit[p]*produce[p]);

output ["\(p): \(produce[p])\n" | p in PRODUCT];
output ["PROFIT: ", show(sum(p in PRODUCT)(profit[p]*produce[p])), "\n"];
