( ----------------------------------------------------------- )

marker empty1

vocabulary testing
also testing definitions 

( ----------------------------------------------------------- )
\
\ apply, cleave, spread combinators
\

( cleave )
: bi  ( x P Q   -- x P x Q ) >r over >r execute r> r> execute ; 

( apply )
: bi@ ( x y P   -- x P y P ) tuck execute >r execute r> ; 

( spread )
: bi* ( x y P Q -- x P y Q ) >r swap >r execute r> r> execute ;

( ----------------------------------------------------------- )
\
\ Euler problem 2 
\

defer fib

:noname ( n -- x )
	dup 1 = if drop 1 exit then 
	dup 2 = if drop 2 exit then 
	dup 2 - swap 1 - ['] fib dup bi* + ; is fib 

: even ( n -- n f ) dup 1 and ;
: under+ ( z y x -- z+x y ) swap >r + r> ; 

: fibsunder4million1 ( m n n -- n1 ) 
	fib dup 4000000 > if drop drop exit else 
		even if under+ 1+ dup else drop 1+ dup then recurse  
	then ;

: fibsunder4million  ( n -- n1 ) 
	0 1 dup fibsunder4million1 ;   
	
cr cr .( The sum of even fibs below 4,000,000 = ) fibsunder4million u.
cr cr cr 

	
