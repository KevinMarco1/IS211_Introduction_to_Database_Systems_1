/* TABLES :
    J indicate to project
    P indicate to part
    S indicate to Supplier
*/


/* QUESTION 1  : Get all supplier-number/part-number/project-number triples such that the indicated supplier,
 part, and project are all collocated.*/ 
SELECT S# , P# , J# FROM SPJ;


/*QUESTION 2 : */
SELECT S.S# ,P.P# , J.J# 
FROM J CROSS JOIN P CROSS JOIN S
EXCEPT 
SELECT S# , P# , J# 
FROM SPJ;


/*QUESTION 4 : */
SELECT DISTINCT SPJ.P# 
FROM SPJ , P , S
WHERE SPJ.P# = P.P# AND SPJ.S# = S.S# AND S.CITY = 'London';

/*QUESTION 5 : */

SELECT DISTINCT SPJ.P# 
FROM SPJ , P , S , J
WHERE SPJ.J# = J.J# AND SPJ.P# = P.P# AND SPJ.S# = S.S# AND S.CITY = 'London' AND J.CITY = 'London';

/*QUESTION 6 : */

SELECT DISTINCT S.City , J.City 
FROM SPJ , S , J 
WHERE SPJ.S# = S.S# AND SPJ.J# = J.J# ; 

/*QUESTION 7 : */

SELECT DISTINCT SPJ.P# 
FROM SPJ , P , S , J
WHERE SPJ.J# = J.J# AND 
	  SPJ.P# = P.P# AND 
	  SPJ.S# = S.S# AND 
	  S.CITY = J.CITY ;

/*QUESTION 8 : */

SELECT DISTINCT SPJ.J#
FROM SPJ , S ,J 
WHERE SPJ.S# = S.S# AND SPJ.J# = J.J# AND J.CITY <> S.CITY ; 

/*QUESTION 9 : */

SELECT distinct a.P# , b.p#
FROM  ( SELECT S# , P#  FROM SPJ ) AS a , ( SELECT S# , P#  FROM SPJ ) AS b
where a.S# = b.S# and a.p# <> b.p# ;

/*QUESTION 10 :*/

SELECT count(*) as total_number_of_projects 
FROM SPJ 
WHERE SPJ.S# = 'S1' ;

/*QUESTION 11 :*/

select SUM( spj.qty ) as total_quantity 
from spj 
where spj.s# = 's1' and spj.p# = 'p1' ;


/*QUESTION 12 : MS2LA RAY2A */
SELECT P# AS PRODUCT_NUMBER ,  J# AS PROJECT_NUMBER , SUM( QTY ) AS total_quantity
FROM SPJ
GROUP BY P# , J# ;

/* QUESTION 13 :  */


SELECT P# AS PRODUCT_NUMBER ,  AVG ( SPJ.QTY ) AS average
FROM SPJ
GROUP BY P#
HAVING AVG ( SPJ.QTY ) > 320 ; 


SELECT P# AS PRODUCT_NUMBER ,  J# AS PROJECT_NUMBER , AVG ( SPJ.QTY ) AS average
FROM SPJ
GROUP BY J# , P# 
HAVING AVG ( SPJ.QTY ) > 320 ; 


/* QUESTION 14 :  */
SELECT * FROM SPJ WHERE QTY IS NOT NULL ;


/* QUESTION 15 :  */

SELECT J# , City 
FROM J 
WHERE City Like '_O%' ; 

/* QUESTION 16 :  */

SELECT DISTINCT P.PName
FROM SPJ , P 
WHERE SPJ.S# = 'S1' AND SPJ.P# = P.P# ;

/* QUESTION 17 :  */

SELECT DISTINCT P.Color
FROM SPJ , P 
WHERE SPJ.S# = 'S1' AND SPJ.P# = P.P# ;

/* QUESTION 18 :  */

SELECT SPJ.P#
FROM SPJ , J 
WHERE SPJ.J# = J.J# AND  J.City = 'London' ;


/* USING EXIST */

SELECT SPJ.P#
FROM SPJ 
WHERE EXISTS (
	SELECT City 
	From J 
	WHERE SPJ.J# = J.J#  and J.City = 'London' 
);


/* QUESTION 19 :  */

SELECT DISTINCT SPJ.J#
FROM SPJ 
WHERE SPJ.S# = 'S1' ;

/* using exist */

SELECT DISTINCT SPJ.J#
FROM SPJ 
WHERE EXISTS (
	SELECT SPJ.J# 
	WHERE SPJ.S# = 'S1' 
)

SELECT DISTINCT SPJ.J#
FROM SPJ 
WHERE EXISTS (
	SELECT 1
	WHERE SPJ.S# = 'S1' 
)

SELECT *
FROM SPJ ; 


/* QUESTION 20 :  */

/*
	S#

	suppliers supply on of those 
	all parts whose suppliers in 
	all supplier sup red part 

*/






SELECT DISTINCT S#
FROM SPJ 
WHERE P# IN ( 
	SELECT P#
	FROM SPJ 
	WHERE SPJ.S# IN ( 
		SELECT S#
		FROM SPJ , P 
		WHERE SPJ.P# = P.P#  AND  P.color = 'Red' 
	)
);

SELECT * FROM S ; 
SELECT * FROM P ; 
SELECT * FROM J ; 
SELECT * FROM SPJ ; 



SELECT DISTINCT SHIPMENT.S#
FROM SPJ as SHIPMENT
WHERE SHIPMENT.P# IN
(
	SELECT SHIPMENT2.P#
	FROM SPJ as SHIPMENT2

	WHERE SHIPMENT2.S# IN ( 
		SELECT SHIPMENT3.S#
		FROM SPJ as SHIPMENT3

		WHERE SHIPMENT3.P# IN (
			SELECT PROJECT.P#
			FROM P as PROJECT
			WHERE PROJECT.COLOR = 'Red'
		)

	)
);
