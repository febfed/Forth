\ The original code was by dxforth on comp.lang.forth.
\ Been meaning to write one but why when its there !
\ 
\ Tested on vfxforth and swiftforth
\
\ The code that dxforth gave was supposed to fail on cnt=0 and cnt=1
\ I corrected that and thats whats shown commented out
\
\ I have further updated it so that it wont accept a negative index
\ Wont bother sorting for cnt=0 and cnt=1
\ Keeps a flag on the stack and if there is a successful pass without
\ an updates, will exit loop 
\ 
\ I have also included some tests to show it working but these can 
\ be ignored
\


[defined] vfxforth [if]
  : xx 100 choose ; 
[else] ( swiftforth ) 
  requires rnd.f
  : xx 100 rnd ; 
[then] 

defer precedes
' < is precedes 

: lcount ( a -- a' n ) dup cell+ swap @ ; 

\ : bubble ( adr cnt -- )
\   dup 0 ?do 1-               \ <<
\     2dup cells bounds ?do    \ <<
\       i 2@ precedes if i 2@ swap i 2! then
\     1 cells +loop
\   loop 2drop ; 


: bubble ( a n -- )
  dup 0< abort" Cant have negative index" \ is error 
  dup 2 < if 2drop exit then \ not an error 
  dup 0 do 1- 
    2dup -1 -rot cells bounds ?do 
      i 2@ 2dup precedes if swap i 2! drop false else 2drop then 
    cell +loop
    if leave then 
  loop 2drop ;
  

: pr[] ( a -- ) ." [ "  lcount 0 ?do dup i cells + @ . loop drop ." ]" ;

create a0 0 , -1 , 
create a1 1 , xx , -1 , 
create a2 2 , xx , xx , -1 , 
create a3 3 , xx , xx , xx , -1 , 
create a5 5 , xx , xx , xx , xx , xx , -1 , 
create a7 7 , xx , xx , xx , xx , xx , xx ,  xx , -1 ,  

cr a0 pr[]
a0 lcount bubble 
cr .( sorted = )  a0 pr[] 

cr a1 pr[]
a1 lcount bubble 
cr .( sorted = )  a1 pr[] 

cr a2 pr[]
a2 lcount bubble 
cr .( sorted = )  a2 pr[]  

cr a3 pr[]
a3 lcount bubble 
cr .( sorted = )  a3 pr[] 

cr a5 pr[]
a5 lcount bubble 
cr .( sorted = )  a5 pr[]  

cr a7 pr[]
a5 lcount bubble 
cr .( sorted = )  a7 pr[]  

cr a5 pr[]
a5 lcount bubble 
cr .( sorted = )  a5 pr[]  
