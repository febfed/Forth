marker empty1

vocabulary testing
also testing definitions

2000000 value tblsz
tblsz allocate throw value tbl 

: settoone ( -- ) 
	tblsz 0 do  -1 tbl i + c! loop ; 

: weedoutmultiples1 ( n -- )
	tblsz over dup + do 
		0 tbl i + c!	
	dup +loop drop ;	
   
: weedoutmultiples    
	tblsz 2/ 2/  2 do 
		tbl i + c@ if i weedoutmultiples1 then 
	loop ;

: showprimes ( -- ) 
	tblsz 2 do  tbl i + c@ if i . then   loop ;

: addup ( -- n ) 
	0 tblsz 2 do 
		tbl i + c@ if i + then 
	loop ;

cr cr cr 
settoone weedoutmultiples
.( Total of primes below 2,000,000 = ) addup . 
cr cr cr bye

