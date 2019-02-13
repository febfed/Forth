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

( spread)
: bi* ( x y P Q -- x P y Q ) >r swap >r execute r> r> execute ;

( ----------------------------------------------------------- )
\ euler problem 1 adapted to show use of apply combinator.
\
\ 

: t1 ( n -- f ) 3 mod 0=  ; 
: t2 ( n -- f ) 5 mod 0=  ;

: t3 ( n -- f ) ['] t1 ['] t2 bi or ; 

: test1  0 10   1 do i t3 if i dup . + then loop ." = " . ;
: test2  0 100  1 do i t3 if i dup . + then loop ." = " . ;
: test3  0 1000 1 do i t3 if i dup . + then loop ." = " . ;

page 
cr cr test1
cr cr test2
cr cr test3
cr cr cr 

( ----------------------------------------------------------- )

( ----------------------------------------------------------- )

