
   +----------------------------------------------------------------+
 0 |                                                                |
 1 |anew numbering                                                  |
 2 |                                                                |
 3 |: char>digit ( c -- n T | F )                                   |
 4 |       dup '0' '9' 1+ within if '0' - true                      |
 5 |  else dup 'a' 'z' 1+ within if 'a' - true                      |
 6 |  else dup 'A' 'Z' 1+ within if 'A' - true                      |
 7 |  else drop false then then then ;                              |
 8 |                                                                |
 9 |: ?digit ( c -- n T| F)                                         |
10 |  char>digit if dup base @ < if true else drop false then       |
11 |  else   false then ;                                           |
12 |                                                                |
13 |                                                                |
14 |-->                                                             |
15 |                                                                |
   +----------------------------------------------------------------+

   +----------------------------------------------------------------+
 0 |                                                                |
 1 |: d* ( ud u -- ut )                                             |
 2 |  tuck um* >r >r um* r> r> rot m+ ;                             |
 3 |                                                                |
 4 |: md*+ ( ud b n -- ut )                                         |
 5 |  >r d* r> -rot 2>r 0 swap m+ 2r> rot m+ ;                      |
 6 |                                                                |
 7 |: (number1) ( d1 a1 u1 -- d2 a2 u2 f1 f2 )                      |
 8 |  ?eol if false dup exit then                                   |
 9 |  rch ?digit if -rot nch 2>r base @ swap md*+ 2r> rot true      |
10 |  else false dup then ;                                         |
11 |                                                                |
12 |: >number1  ( d1 a1 u1 -- d2 a2 u2 f )                          |
13 |  begin (number1) while ?dup if exit then repeat ;              |
14 |                                                                |
15 |                                                                |
   +----------------------------------------------------------------+
   
   
 \ Works just like >number except the extra flag returned . flag 0<> means overflow 
 \ I havent tested it throughly so please use at your own risk 
