   +----------------------------------------------------------------+
 0 |( cn cn@ -cn hd tl !hd !tl list1  )                             |
 1 | anew list                                                      |
 2 |                                                                |
 3 |: cn ( x y -- p ) 2 cells allocate throw dup >r 2! r> ;         |
 4 |: cn@ ( p -- x y ) 2@ ;                                         |
 5 |: -cn ( p -- ) free throw ;                                     |
 6 |                                                                |
 7 |: hd ( p -- x ) cn@ drop ;                                      |
 8 |: tl ( p -- y ) cn@ nip ;                                       |
 9 |: !hd ( x p -- ) dup >r cn@ nip r> 2! ;                         |
10 |: !tl ( y p -- ) dup >r cn@ drop swap r> 2! ;                   |
11 |                                                                |
12 |: list1 ( x -- [x] ) 0 cn ;                                     |
13 |: list2 ( x y -- [x y] ) list1 cn ;                             |
14 |-->                                                             |
15 |                                                                |
   +----------------------------------------------------------------+
