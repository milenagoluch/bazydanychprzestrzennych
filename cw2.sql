--3)
CREATE EXTENSION postgis;

--4)
CREATE TABLE budynki(id INTEGER, geometria GEOMETRY, nazwa VARCHAR);
CREATE TABLE drogi(id INTEGER, geometria GEOMETRY, nazwa VARCHAR);
CREATE TABLE punkty_informacyjne(id INTEGER, geometria GEOMETRY, nazwa VARCHAR);

--5)
INSERT INTO budynki VALUES (1, ST_GeomFromText('POLYGON((8 4, 10.5 4, 10.5 1.5, 8 1.5, 8 4))', 0), 'BuildingA');
INSERT INTO budynki VALUES (2, ST_GeomFromText('POLYGON((4 7, 6 7, 6 5, 4 5, 4 7))', 0), 'BuildingB');
INSERT INTO budynki VALUES (3, ST_GeomFromText('POLYGON((3 8, 5 8, 5 6, 3 6, 3 8))', 0), 'BuildingC');
INSERT INTO budynki VALUES (4, ST_GeomFromText('POLYGON((9 9, 10 9, 10 8, 9 8, 9 9))', 0), 'BuildingD');
INSERT INTO budynki VALUES (5, ST_GeomFromText('POLYGON((1 2, 2 2, 2 1, 1 1, 1 2))', 0), 'BuildingF');

INSERT INTO drogi VALUES (1, ST_GeomFromText('LINESTRING(0 4.5, 12 4.5)', 0), 'RoadY');
INSERT INTO drogi VALUES (2, ST_GeomFromText('LINESTRING(7.5 10.5, 7.5 0)', 0), 'RoadX');

INSERT INTO punkty_informacyjne VALUES (1, ST_GeomFromText('POINT(1 3.5)', 0), 'G');
INSERT INTO punkty_informacyjne VALUES (2, ST_GeomFromText('POINT(5.5 1.5)', 0), 'H');
INSERT INTO punkty_informacyjne VALUES (3, ST_GeomFromText('POINT(9.5 6)', 0), 'I');
INSERT INTO punkty_informacyjne VALUES (4, ST_GeomFromText('POINT(6.5 6)', 0), 'J');
INSERT INTO punkty_informacyjne VALUES (5, ST_GeomFromText('POINT(6 9.5)', 0), 'K');

--6a)
SELECT SUM (ST_Length(drogi.geometria)) AS Dlugosc FROM drogi;
--6b)
SELECT ST_AsText(budynki.geometria) AS WKT, ST_Area(budynki.geometria) AS Pole, ST_Perimeter(budynki.geometria) AS Obwod FROM budynki WHERE budynki.nazwa= 'BuildingA';
--6c)
SELECT nazwa, ST_Area(budynki.geometria) AS Pole FROM budynki ORDER BY nazwa;
--6d)
SELECT nazwa, ST_Area(budynki.geometria) AS Pole FROM budynki ORDER BY nazwa LIMIT 2;
--6e)
SELECT ST_Distance(budynki.geometria, punkty_informacyjne.geometria) AS Odleglosc FROM budynki, punkty_informacyjne WHERE budynki.nazwa='BuildingC' AND punkty_informacyjne.nazwa='G';
--6f)
CREATE TABLE B_buffer_05 AS
SELECT ST_Buffer(budynki.geometria, 0.5) AS Bufor FROM budynki WHERE budynki.nazwa='BuildingB';
CREATE TABLE C_geom AS
SELECT budynki.geometria from budynki WHERE budynki.nazwa='BuildingC';

SELECT ST_Area(ST_Difference(geometria, Bufor)) AS Pole FROM C_geom, B_Buffer_05;
--6g)
SELECT budynki.nazwa FROM budynki, drogi WHERE ST_Y(ST_Centroid(budynki.geometria)) > ST_Y(ST_PointN(drogi.geometria,1));
--6h)
CREATE TABLE d1 AS
SELECT ST_Difference(geometria, ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))',0)) FROM C_geom;
CREATE TABLE d2 AS
SELECT ST_Difference(ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))',0), geometria) FROM C_geom;

SELECT ST_Area(ST_Union(d1.st_difference,d2.st_difference)) FROM d1,d2;
