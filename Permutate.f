0 [if] ================================================================

https://en.wikipedia.org/wiki/Heap%27s_algorithm

Heap's algorithm generates all possible permutations of n objects. 
It was first proposed by B. R. Heap in 1963.[1] The algorithm minimizes 
movement: it generates each permutation from the previous one by 
interchanging a single pair of elements; the other n−2 elements are not 
disturbed.

================================================================= [then]

only forth 

vocabulary test1
also test1 definitions

variable buf1 20 chars allot
s" ABCDE" buf1 place 

\ x & y are indices 0-based
\ z start of array

: exch ( x y z -- )
  tuck + >r + r> 
  2dup c@ swap c@ rot c! swap c! ;


: permute { k buf buflen -- }
  k 1 = if 
    buf buflen type space
  else
    k 1- buf buflen recurse
    k 1- 0 do 
      k 1 and if ( odd )
        0 k 1- buf  exch 
      else ( even )
        i k 1- buf  exch 
      then 
      k 1- buf buflen recurse
    loop 
  then ;

buf1 count tuck permute

