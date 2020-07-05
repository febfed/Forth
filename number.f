
   +----------------------------------------------------------------+
 0 |  anew number1                                                  |
 1 |                                                                |
 2 |: d* ( ud u -- ut )                                             |
 3 |  tuck m* 2>r m* 2r> rot m+ ;                                   |
 4 |                                                                |
 5 |: md*+ ( ud b n -- ud*b+n )                                     |
 6 |  >r d* r> -rot 2>r 0 swap m+ 2r> rot m+ ;                      |
 7 |                                                                |
 8 |: ?digit ( c -- n T | F )                                       |
 9 |       dup '0' '9' 1+ within if '0' - true                      |
10 |  else dup 'A' 'Z' 1+ within if 'A' - 10 + true                 |
11 |  else dup 'a' 'z' 1+ within if 'A' - 10 + true                 |
12 |  else drop false then then then                                |
13 |  if dup base @ < if true else drop false then                  |
14 |  else false then ;                                             |
15 |-->                                                             |
   +----------------------------------------------------------------+

  +----------------------------------------------------------------+
 0 |                                                                |
 1 |: (>number1) ( ud1 a1 u1 -- ud2 a2 u2 f1 f2 )                   |
 2 |  dup 0= if false dup exit then                                 |
 3 |  over c@ ?digit if -rot 1 /string 2>r base @ swap md*+ 2r>     |
 4 |  rot true else false dup then ;                                |
 5 |                                                                |
 6 |: >number1  ( ud1 a1 u1 -- ud2 a2 u2 f )                        |
 7 |  begin (>number1) while ?dup if exit then repeat ;             |
 8 |                                                                |
 9 |                                                                |
10 |                                                                |
11 |                                                                |
12 |                                                                |
13 |                                                                |
14 |                                                                |
15 |                                                                |
   +----------------------------------------------------------------+
   
 \ Works just like >number except the extra flag returned . flag 0<> means overflow 
 \ I havent tested it throughly so please use at your own risk 

\  A mistake was found in digit so I just rewrote it all.
\  More testing
