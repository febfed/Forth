\ from a post by brian fox on comp.lang.forth circa aug 2020
\ I might delete this in the future
\ it was written as an example and I cannot see any possible use.

marker test1 

\ Search the string specified by a1 u1 for 
\ the string specified by a2 u2
\ flag = true match found a3 u3 
\ flag = false no match return a1 u1 
\

: 4dup 2over 2over ;
: thirdelem 2over nip ;
: (s=) ( a1 u1 a2 u2 -- f ) drop over compare 0= ;

: srch ( a1 u1 a2 u2 -- a3 u3 f ) 
  thirdelem over < if 2drop false exit then 
  2over begin thirdelem over <= while 
    4dup (s=) if 2>r 2drop 2drop 2r> true exit then 
    1 /string repeat 
  2drop 2drop false ;

 
cr s" hello world" s" zebra" srch [if] .( True ) type [else] .( False ) type [then] 
cr s" hello world" s" worl" srch [if] .( True ) type [else] .( False ) type [then]
cr s" hello world" s" rld" srch [if] .( True ) type [else] .( False ) type [then]
cr s" hello world" s" hell" srch [if] .( True ) type [else] .( False ) type [then]
cr s" hello" s" hello world" srch [if] .( True ) type [else] .( False ) type [then]

: s1 S" abcdefghijklmnopqrstuvwxyz" ; 
: s2 S" abc"   ;
: s3 S" jklmn" ; 
: s4 S" z"     ; 
: s5 S" mnoq"  ; 
: s6 S" 12345" ;
: s7 S" "      ; 

cr s1 s2 srch [if] .( True  ) type [else] .( False ) type [then]
cr s1 s3 srch [if] .( True  ) type [else] .( False ) type [then]
cr s1 s4 srch [if] .( True  ) type [else] .( False ) type [then]
cr s1 s5 srch [if] .( True  ) type [else] .( False ) type [then]
cr s1 s6 srch [if] .( True  ) type [else] .( False ) type [then]
cr s1 s7 srch [if] .( True  ) type [else] .( False ) type [then]
