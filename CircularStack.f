( ----------------------------------------------------------- )

marker empty1

vocabulary stack 
also stack definitions 

include random.fs 

( ----------------------------------------------------------- )

\
\ Circular stack 
\

: stack ( n -- a ) 
	dup 3 + cells allocate throw ( -- n a )
	dup >r
		3 cells + swap cells bounds dup 
		r@ ! r@ cell+ ! r@ 2 cells + !    
	r> ; 

: ps ( s -- ) ." [ " cell+ 2@ ?do i @ . cell +loop ." ]" ;

( ----------------------------------------------------------- )

: push ( n s -- ) 
	dup @ over cell+ 2@ swap 
	within 0= if dup cell+ 2@ nip over ! then 
	tuck @ ! cell swap +! ;

: pop  ( s -- n ) 
	cell negate over +! 
	dup @ over cell+ 2@ swap 
	within 0= if dup cell+ 2@ drop cell - over ! then 
	@ @ ;

( ----------------------------------------------------------- )

8 stack value p 

: >p ( n -- ) p push ;
: p> ( -- n ) p pop ;
: p@ ( -- n ) p> dup >p ;
: p. ( -- )   p ps ;


( ----------------------------------------------------------- )	
		
8 stack value q

: >q ( n -- ) q push ;
: q> ( -- n ) q pop ;
: q@ ( -- n ) q> dup >q ;
: q. ( -- )   q ps ;

( ----------------------------------------------------------- )

: test1 ( -- ) 
	cr cr cr ." Pushes "
	20 1 do 
		cr i . i >p p.
	loop 
	cr cr cr ." Pops "
	20 1 do 
		cr p> . p. 
	loop ; test1


( ----------------------------------------------------------- )


