anew testing1

vocabulary read also read definitions

: $. ( a u -- a u ) 2dup type ;

: eol?  ( a u -- a u f ) dup 0= ; 
: -eol? ( a u -- a u f ) dup 0> ;

: rch ( a u -- a u c ) over c@ ; 

: nch {: a1 u1 -- a2 u2 :} a1 1+ u1 1- ; 
: pch {: a1 u1 -- a2 u2 :} a1 1- u1 1+ ;

: bl? ( c -- f ) 
  dup >r 9 = 
  r@ 10 = or
  r@ 13 = or 
  r> bl = or ;

: skipbl ( a1 u1 -- a2 u2 )
  begin -eol? while
  rch bl? while nch  
  repeat then ;

: skipnonbl ( a1 u1 -- a2 u2 )
  begin -eol? while
  rch bl? 0= while 
    nch  
  repeat then ;

: parse-upto ( a1 u1 c -- a2 u2 )
  >r 
  begin -eol? while 
  rch r@ <> while 
    nch
  repeat then r> drop ;

: instr ( a1 u1 c -- a1 u1 f ) 
  scan nip 0> ; 

: extracttok ( a1 u1 a2 u2 -- a2 u2 a3 u3 )
  {: a1 u1 a2 u2 :}
  a2 u2   a1 u1 u2 - ;
(  2dup 2>r nip - 2r> 2swap ; )

: parse-name 
  skipbl -eol? if 2dup skipnonbl extracttok then ;

( takes out the double quotes at either end )
: adjust-string ( a u -- a1 u1 )
  over c@ '"' = if 1 /string then 
  2dup + 1- c@ '"' = if 1- then ;

: rdstr ( a1 u1 a2 u2 -- a3 u3 a4 u4 )
  2dup nch '"' parse-upto 
  -eol? if nch then 
  extracttok adjust-string ;

: has-sign? ( a u -- F|T )
  rch '-' = if nch true else
  rch '+' = if nch false else
    false 
  then then ;

: has-dot? ( a u -- a u T|F )
  2dup '.' instr ;  

: has-e? ( a u -- a u T|F )
  2dup 'e' instr ; 

: d+- ( ud sign -- d ) 0< if dnegate then ;

: >int ( a u -- d T | F ) 
  has-sign? >r
  0 0 2swap >number dup 0= if 2drop r> d+- true 
  else 2drop 2drop r> drop false then ; 

: >longint ( a u -- d T | F) 
  has-sign? >r 
  0 0 2swap >number dup 0= if 2drop r> d+- true 
  else rch '.' = if nch
    >number dup 0= if 2drop r> d+- true 
      else 2drop 2drop r> drop false then 
    else 2drop 2drop r> drop false then 
  then ;   

: nombre ( a u -- d T | F )
  has-dot? if >longint else >int then ; 

( to be used with getnexttok )
: symornum ( a u -- sym|num ) 
  2dup 2>r nombre if 2r> 2drop 9 else 2r> 8 then ;

: rdsym ( a1 u1 a2 u2 -- a3 u3 a4 u4 )
  begin -eol? while 
  rch bl? >r
  rch s" ()[]{}" rot instr r> or 0= while 
    nch 
  repeat then 
  extracttok ; 

( a2 u2 - parsed up to )
( a3 u3 - token read )
: getnexttok ( a1 u1 -- a2 u2 a3 u3 ) 
  skipbl 
  -eol? if 
    rch '(' = if nch 1 else
    rch '[' = if nch 2 else
    rch '{' = if nch 3 else
    rch ')' = if nch 4 else
    rch ']' = if nch 5 else
    rch '}' = if nch 6 else
    rch '"' = if rdstr 7 else 
      2dup rdsym symornum ( returns 8 or 9=double )
    then then then then then then then 
  else 0 then ;


: input ( -- ) 
  pad 256 erase 
  cr ."  >" 
  pad 256 accept
  pad swap 
  cr ."  -- " ;
  
: testrd ( -- ) 
  begin 
    input skipbl
    2dup s" quit" compare 0= if 2drop exit then 
    begin -eol? while cr 
    getnexttok 
    case 
    1 of ." (" endof
    2 of ." [" endof
    3 of ." {" endof
    4 of ." )" endof
    5 of ." ]" endof
    6 of ." }" endof
    7 of ." str: " type endof
    8 of ." sym: " type endof
    9 of ." num: " d.   endof
    endcase
    repeat 2drop 
  again ; 

( -------0-------1-------2-------3-------4-------5-------7-------8 )
( Most parsing is done from left to right. Thats because its how   )
( we read text. I wrote these words if I ever need to read from    )
( right to left...                                                 ) 
( some words are common to both and thus not implemented           )

: rch- ( a u -- a u c ) 2dup + 1- c@ ;

: nch- ( a1 u1 -- a2 u2 ) 1- ;   
: pch- ( a1 u1 -- a2 u2 ) 1+ ;

\ **** In the interests of non-repetition, 
\ **** this is just -trailing
\
\ : skipbl- ( a1 u1 -- a2 u2 )
\   begin -eol? while
\   rch- bl? while nch-  
\   repeat then ;
\
 
: skipnonbl- ( a1 u1 -- a2 u2 )
  begin -eol? while
  rch- bl? 0= while nch-  
  repeat then ;

: parse-upto- ( a1 u1 c -- a2 u2 )
  >r 
  begin -eol? while 
  rch- r@ <> while 
    nch-
  repeat then r> drop ;

: extracttok- ( a1 u1 a2 u2 -- a2 u2 a3 u3 )
  {: a1 u1 a2 u2 :}
   a2 u2   a2 u2 + u1 u2 -  ;
( locals version is simpler to understand    )
(  2dup 2>r tuck + -rot - rot drop 2r> 2swap ) 

: parse-name- 
  -trailing -eol? if 2dup skipnonbl- extracttok- then ;

( -------0-------1-------2-------3-------4-------5-------7-------8 )
\
\
\
\ I had been thinking about this for a while and I typed it in one 
\ evening. You will see a few words in other files as I have written 
\ these before.
\
\ This is a collection of words nothing more !
\
\ type testrd to see it in action..
\
\ At the prompt ' > ' enter a line or a list using any combination
\ of ( ) [ ] { }. 
\ Hopefully the output of testrd will give you the same ideas too.
\
\
\
( -------0-------1-------2-------3-------4-------5-------7-------8 )
