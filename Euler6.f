marker empty1

vocabulary testing
also testing definitions

( cleave ) 
: bi ( x P Q -- x P x Q ) 
	>r over >r execute r> r> execute ;

: square ( x -- x^2 ) dup * ; 
: sumofsquares ( m -- n ) 0 swap 1+ 1 do i square + loop ;
: squareofsum ( m -- n )  0 swap 1+ 1 do i + loop square ;

page 
cr cr .( Testing for first 10 natural numbers ) 
cr 10 ' squareofsum ' sumofsquares bi 2dup - 
cr .( Difference = ) . 
cr .( sumofsq = ) . 
cr .( sqofsum = ) . 

cr cr cr 
cr cr .( Solution for first 100 natural numbers ) 
cr 100 ' squareofsum ' sumofsquares bi 2dup - 
cr .( Difference = ) . 
cr .( sumofsq = ) . 
cr .( sqofsum = ) . 

cr cr cr bye 
