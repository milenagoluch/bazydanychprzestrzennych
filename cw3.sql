CREATE EXTENSION postgis;
--4)
CREATE TABLE tableB AS
SELECT COUNT (DISTINCT p.gid) FROM majrivers mjr, popp p WHERE ST_Intersects (ST_Buffer(mjr.geom,100000),p.geom) AND p.f_codedesc ='Building';
SELECT * FROM tableB;
--5)
SELECT * FROM airportsNew;
SELECT name, geom, elev INTO airportsNew FROM airports;
--5a)
--wschód
SELECT aN.name, ST_X(aN.geom) AS Wspolrzedna_X FROM airportsNew aN ORDER BY Wspolrzedna_X DESC LIMIT 1;
--zachód
SELECT aN.name, ST_X(aN.geom) AS Wspolrzedna_X FROM airportsNew aN ORDER BY Wspolrzedna_X ASC LIMIT 1;
--5b
INSERT INTO airportsNew VALUES ('airportB', (SELECT ST_Centroid (ST_ShortestLine((SELECT geom FROM airportsNew WHERE name ='ANNETTE ISLAND'), (SELECT geom FROM airportsNew WHERE name='ATKA')))), 74);
SELECT * FROM airportsNew WHERE name ='ANNETTE ISLAND' OR name ='ATKA' OR name='airportB';
--6)
SELECT * FROM lakes;
SELECT * FROM airports;
SELECT ST_Area(ST_Buffer(ST_ShortestLine(l.geom, a.geom),1000)) AS Pole FROM lakes l, airports a WHERE l.names ='Iliamna Lake'AND a.name= 'AMBLER';
--7)
SELECT * FROM trees;
SELECT * FROM tundra;
SELECT SUM(DISTINCT tr.area_km2) AS Sumaryczne_pole_powierzchni, vegdesc FROM trees tr, tundra t, swamp s WHERE ST_Contains(t.geom, tr.geom) OR ST_Contains(s.geom, tr.geom) GROUP BY vegdesc;

