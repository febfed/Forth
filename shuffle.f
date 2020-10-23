\
\ another one courtesy of dxforth :¬) 
\ tested on vfxforth and swiftforth
\ if I ever need it I wont need to write one from scratch.
\


[defined] test1 [if] test1 [then] 
marker test1 

[defined] vfxforth [if]
  : xx 100 choose ; 
  : random choose ; 
[else] 
  requires rnd.f
  : xx 100 rnd ;
  : random rnd ;  
[then] 

: lcount ( a -- a' n ) dup cell+ swap @ ; 

 : shuffle ( adr cnt -- )
  0 swap ?do
  dup i random cells + ( a1 a2 ) 
  2dup @ swap @ rot ! over ! cell+
  -1 +loop drop ; 

: pr[] ( a -- ) ." [ "  lcount 0 ?do dup i cells + @ . loop drop ." ]" ;


create a0 0 , xx , 
create a1 1 , xx , xx , 
create a2 2 , xx , xx , 
create a3 3 , xx , xx , xx , 
create a5 5 , xx , xx , xx , xx , xx , xx , 

cr a0 pr[]
a0 lcount shuffle 
cr .( shuffled = )  a0 pr[] 
cr

cr a1 pr[]
a1 lcount shuffle 
cr .( shuffled = )  a1 pr[] 
cr

cr a2 pr[]
a2 lcount shuffle 
cr .( shuffled = )  a2 pr[]  
cr

cr a3 pr[]
a3 lcount shuffle  
cr .( shuffled = )  a3 pr[] 
cr

cr a5 pr[]
a5 lcount shuffle 
cr .( shuffled = )  a5 pr[]  
cr
