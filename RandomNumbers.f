( Random Numbers)

anew -randomnumbers

defer Randomize
defer Random

false constant RAND1
false constant RAND2
false constant RAND3
false constant RAND4
true  constant RAND5
false constant RAND6
false constant RAND7

\ -------------------------------------------
( Andreas  / Mark )

RAND1 [if]

VARIABLE (RND)
2463534242 (rnd) ! \ seed

: rnd ( -- n)
    (rnd) @ dup 13 lshift xor
    dup 17 rshift xor
    dup DUP 5 lshift xor (rnd) ! ;

:noname ( -- ) ms@ ms@ d2/ d2/ d2/ d2/ d2/ d2/ d2/ drop (rnd) ! ; is Randomize
:noname ( -- ) rnd swap mod ; is Random

[then]

\ -------------------------------------------


( Charles Montgomery )
\ On an EIGHT-bit system, you can run four 8-bit generators, all
\ with different multipliers; with multipliers 65FF 56FF 68FF and 317F
\ the 32-bit values should have a period of about 2^57.5 (~2x10^17).
\ Good multiplier values are important, although for the 32-bit
\ version just about any 30-bit multiplier is apt to give a period
\ of 2^50 or so.

RAND2 [if]

HEX

1 CELLS  2 = [IF]  65E8 [ELSE]  7A3FFD4B  [THEN]

CONSTANT  rmult

\ other good multipliers for 16-bit systems are 61BF 62DC 6594 6363 5E9B
\ for 32-bits  7549D83B  70DCB7DC  6A364C22  62AFDC7A

2VARIABLE rloc    3 1   rloc 2!         \ any seed values should be ok

: rndm  ( -- u )   \ returns one cell full of random bits
    rloc 2@ rmult UM* ROT 0 D+ OVER rloc 2! ;

\ That was pretty easy, wasn't it!  ;-)
\ a few related words that might be useful:

\ random integer from 0 to n-1
: random ( n -- 0..n-1 )  rndm UM* NIP ;

\ floating point value uniformly distributed in [0-1)
0 1 D>F FCONSTANT f2^max
: frand  ( -- f )  rndm 0 D>F f2^max F/ ;

\ reseed randomly by exercising rndm a few times
: randomize  ( -- )  TIME&DATE 2DROP    ( sec min hr day )
    + + +  0 DO  rndm DROP  LOOP
    rndm rndm  rloc 2! ;

DECIMAL

[then]

\ -------------------------------------------


RAND3 [if]

( Rick VanNorman )

\ ---------- RANDOM NUMBERS IN FORTH

\  D. H. Lehmers Parametric multiplicative linear congruential
\  random number generator is implemented as outlined in the
\  October 1988 Communications of the ACM ( V 31 N 10 page 1192)

     16807 CONSTANT A
2147483647 CONSTANT M
    127773 CONSTANT Q   \ m a /
      2836 CONSTANT R   \ m a mod

CREATE SEED  123475689 ,

\ Returns a full cycle random number
: RAND ( -- rand )  \ 0 <= rand < 4,294,967,295
   SEED @ Q /MOD ( lo high)
   R * SWAP A * 2DUP > IF  - ELSE  - M +  THEN  DUP SEED ! ;

\ Returns single random number less than n
: RND ( n -- rnd )  \ 0 <= rnd < n
   RAND SWAP MOD ;

[then]

\ -------------------------------------------

( Wil Baden )

RAND4 [if]

    CREATE Rand-X 1 , ms@ , \  COUNTER counts milliseconds.

    : RAND-NEXT  ( -- 0...4294967295 )
       Rand-X @
          48271  2147483647  */MOD DROP
          DUP Rand-X !
       Rand-X CELL+ @
          3141592621 * 1+
          DUP Rand-X CELL+ !
       - ;
	: RANDOM ( n1 -- n2 ) rand-next swap mod ;
[then]

\ -------------------------------------------

( Wil Baden )

RAND5  [if]

DECIMAL

\  Off the shelf tools.  Comment out redundancy.

    : NOT ( x -- flag )  0= ;
    : TH  ( a i -- a' )  CELLS + ;
    : H#  ( "xxx" -- n )  \  Simplified for easy porting.
        BASE @ >R  HEX
        0 0 BL WORD COUNT >NUMBER ABORT" Not Hex " 2DROP
        STATE @ IF  POSTPONE LITERAL  THEN
        R> BASE ! ; IMMEDIATE

\  Period parameters

624 CONSTANT N
397 CONSTANT M

H# 9908B0DF CONSTANT MATRIX-A    \  Constant vector A
H# 80000000 CONSTANT UPPER-MASK  \  Most significant w-r bits
H# 7FFFFFFF CONSTANT LOWER-MASK  \  Least significant r bits

\  Tempering parameters

H# 9D2C5680 CONSTANT TEMPERING-MASK-B
H# EFC60000 CONSTANT TEMPERING-MASK-C

: TEMPERING-SHIFT-U  11 RSHIFT ;
: TEMPERING-SHIFT-S   7 LSHIFT ;
: TEMPERING-SHIFT-T  15 LSHIFT ;
: TEMPERING-SHIFT-L  18 RSHIFT ;

CREATE MT  N CELLS ALLOT  \  The array for the state vector.
CREATE MTI  -1 ,  \  Unsigned MTI > N means MT[...] is not initialized.

\  Initializing the array with a seed.

: SGENRAND  ( seed -- )
    N 0 DO
        DUP H# FFFF0000 AND  MT I TH !
        69069 * 1+
        DUP H# FFFF0000 AND 16 RSHIFT  MT I TH @ OR  MT I TH !
        69069 * 1+
    LOOP DROP  ( )
    N MTI ! ;


: LSGENRAND  ( &seed-array -- )
    \  The length of seed-array[] must be at least N cells.
    N 0 DO
        DUP I TH @  MT I TH !
    LOOP DROP ( )
    N MTI ! ;

: GENRAND  ( -- u )

    MTI @  N U< NOT IF  \  Generate N words at one time.

        MTI @ N = NOT IF   \  If SGENRAND has not been called,
            4357 SGENRAND  \  a default initial seed is used.
        THEN

        N M - 0 DO
            MT I TH @ UPPER-MASK AND
                MT I 1+ TH @ LOWER-MASK AND  OR   ( y)
            DUP 1 RSHIFT SWAP                     ( x y)
            1 AND IF  MATRIX-A XOR  THEN          ( x)
            MT I M + TH @  XOR
            MT I TH !                             ( )
        LOOP

        N 1-  N M -  DO
            MT I TH @ UPPER-MASK AND
                MT I 1+ TH @ LOWER-MASK AND  OR   ( y)
            DUP 1 RSHIFT SWAP                     ( x y)
            1 AND IF  MATRIX-A XOR  THEN          ( x)
            MT I M + N - TH @  XOR
            MT I TH !                             ( )
        LOOP

        MT N 1- TH @ UPPER-MASK AND
            MT @ LOWER-MASK AND  OR               ( y)
        DUP 1 RSHIFT SWAP                         ( x y)
        1 AND IF  MATRIX-A XOR  THEN              ( x)
        MT M 1- TH @  XOR
        MT N 1- TH !                              ( )

        0 MTI !
    THEN

    MT MTI @ TH @  1 MTI +!                       ( y)
    DUP TEMPERING-SHIFT-U  XOR
    DUP TEMPERING-SHIFT-S  TEMPERING-MASK-B AND  XOR
    DUP TEMPERING-SHIFT-T  TEMPERING-MASK-C AND  XOR
    DUP TEMPERING-SHIFT-L  XOR ;

: Randomize ( -- )   ms@ ms@ d2/ d2/ d2/ d2/ d2/ d2/ d2/ drop  sgenrand ;
: Random    ( n -- ) genrand swap mod ;

[then]

\ -------------------------------------------

( Albert van der Horst )

RAND6 [if]


1 CELLS 4 = [IF]
-178  CONSTANT multiplier  \ 4,294,967,118 32 bits
[ELSE]   \ Ignoring 16 bits.
-742  CONSTANT multiplier   \ 18,446,744,073,709,550,874
[then]

CREATE SEED   1 , 1 ,

: RAND SEED 2@   >R multiplier UM*  R> 0 D+ SWAP OVER SEED 2! ;

: RANDOMIZE SEED 2! ; ms@ dup randomize

[then]

\ ------------------------------------------------------

RAND7 [if]




[then]


\ ------------------------------------------------------
