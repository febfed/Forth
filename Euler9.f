marker empty1

vocabulary testing
also testing definitions

( cleave ) 
: bi ( x P Q -- x P x Q ) 
	>r over >r execute r> r> execute ;

( spread )
: bi* ( x y P Q -- x P y Q ) 
	>r swap >r execute r> r> execute ;

( apply ) 
: bi@ ( x y P -- x P y P ) 
	tuck execute >r execute r> ; 

: dupd ( b a -- b b a ) >r dup r> ;
: sq ( n -- n^2 ) dup * ;

: pred1 ( c b a -- f ) dupd > >r > r> and ;
: pred2 ( c b a -- f ) ['] sq bi@ + >r sq r> = ;
: pred3 ( c b a -- f ) + + 1000 = ;

cr cr cr .( Solving euler problem 9 )
cr .( Patience ...)
: test 
	996 3 do
		998 i 1+ do 
			1000 i 1+ do
				i j k pred1 if 
				i j k pred3 if 
				i j k pred2 if cr ." a = " k . ." b = " j . ." c = " i . 
				then then then   
			loop 
		loop  
	loop ; test 	

cr cr cr .( Done ) 
cr bye
