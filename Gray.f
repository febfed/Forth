https://en.wikipedia.org/wiki/Gray_code

The reflected binary code (RBC), also known just as reflected binary (RB) or Gray code ,is an ordering 
of the binary numeral system such that two successive values differ in only one bit (binary digit). 

: bin2gray ( n1 -- n2 ) dup 1 rshift xor ;
: gray2bin ( n1 -- n2 ) 
  dup begin over while swap 1 rshift tuck xor repeat nip ;
