-- Напишете заявка, която извежда имената на актьорите мъже участвали в ‘Terms of Endearment’
SELECT MOVIESTAR.NAME
FROM MOVIESTAR
JOIN STARSIN
ON MOVIESTAR.NAME = STARSIN.STARNAME
WHERE MOVIESTAR.GENDER = 'M'
AND STARSIN.MOVIETITLE = 'Terms of Endearment';

-- Напишете заявка, която извежда имената на актьорите участвали във филми
-- продуцирани от ‘MGM’през 1995 г.
SELECT STARSIN.STARNAME
FROM STARSIN
JOIN MOVIE
ON STARSIN.MOVIETITLE = MOVIE.TITLE AND STARSIN.MOVIEYEAR = MOVIE.YEAR
WHERE MOVIE.STUDIONAME = 'MGM' AND MOVIE.YEAR = 1995;

-- Напишете заявка, която извежда името на президента на ‘MGM’
SELECT DISTINCT S.NAME, ME.NAME
FROM STUDIO S
JOIN MOVIE M ON S.NAME = M.STUDIONAME
JOIN MOVIEEXEC ME ON ME.CERT# = M.PRODUCERC#;

-- Напишете заявка, която извежда имената на всички филми с дължина по-голяма
-- от дължината на филма ‘Gone With the Wind’
SELECT M2.TITLE
FROM MOVIE M1
JOIN MOVIE M2 ON M2.LENGTH > M1.LENGTH
WHERE M1.TITLE = 'Gone With the Wind';