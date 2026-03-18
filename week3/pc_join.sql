-- Напишете заявка, която извежда производителя и честотата на тези лаптопи с
-- размер на диска поне 9 GB
SELECT P.MAKER, L.SPEED
FROM PRODUCT P
JOIN LAPTOP L ON P.MODEL = L.MODEL
WHERE  L.HD >= 9;

-- Напишете заявка, която извежда номер на модел и цена на всички продукти,
-- произведени от производител с име ‘B’
SELECT P.MODEL, COALESCE(L.PRICE, PC.PRICE, PR.PRICE) AS PRICE
FROM PRODUCT P
LEFT JOIN LAPTOP L ON P.MODEL = L.MODEL
LEFT JOIN PC ON P.MODEL = PC.MODEL
LEFT JOIN PRINTER PR ON P.MODEL = PR.MODEL
WHERE P.MAKER = 'B';

-- Напишете заявка, която извежда размерите на тези дискове, които се предлагат в
-- повече от два компютъра
SELECT DISTINCT P1.CD
FROM PC P1
JOIN PC P2 ON P1.CODE <> P2.CODE AND P1.CD = P2.CD
JOIN PC P3 ON P1.CODE <> P3.CODE AND P2.CODE <> P3.CODE AND P1.CD = P3.CD;

-- Напишете заявка, която извежда всички двойки модели на компютри, които
-- имат еднаква честота и памет. Двойките трябва да се показват само по веднъж,
-- например само (i, j), но не и (j, i)
SELECT P1.MODEL, P2.MODEL
FROM PC P1
JOIN PC P2 ON P1.SPEED = P2.SPEED AND P1.RAM = P2.RAM AND P1.CODE < P2.CODE;

-- Напишете заявка, която извежда производителите на поне два различни
-- компютъра с честота поне 400.
SELECT P.MAKER
FROM PRODUCT P
JOIN PC ON P.MODEL = PC.MODEL
WHERE PC.SPEED >= 400
GROUP BY P.MAKER
HAVING COUNT(*) >=2;
