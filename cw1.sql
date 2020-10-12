--1)
CREATE DATABASE s304166;
--2)
CREATE SCHEMA firma;
--3)
CREATE ROLE ksiegowosc;
GRANT CONNECT ON DATABASE s304166 TO ksiegowosc;
GRANT USAGE ON SCHEMA firma TO ksiegowosc;  
GRANT SELECT ON ALL TABLES IN SCHEMA firma TO ksiegowosc; 
--4)
CREATE TABLE firma.pracownicy (Id_pracownika VARCHAR(4) NOT NULL, imie VARCHAR(50), nazwisko VARCHAR(50), adres VARCHAR(50), telefon VARCHAR(12));
CREATE TABLE firma.godziny (Id_godziny VARCHAR(4) NOT NULL, data DATE, liczba_godzin INT, Id_pracownika VARCHAR(4) NOT NULL);
CREATE TABLE firma.pensja_stanowisko (Id_pensji VARCHAR(4) NOT NULL, stanowisko VARCHAR(50), kwota MONEY);
CREATE TABLE firma.premia (Id_premii VARCHAR(4) NOT NULL, rodzaj VARCHAR(50), kwota MONEY);
CREATE TABLE firma.wynagrodzenie (Id_wynagrodzenia VARCHAR(4) NOT NULL, data DATE, Id_pracownika VARCHAR(4) NOT NULL, Id_godziny VARCHAR(4) NOT NULL, Id_pensji VARCHAR(4) NOT NULL, Id_premii VARCHAR(4) NOT NULL);
--4b)
ALTER TABLE firma.pracownicy ADD PRIMARY KEY (Id_pracownika);
ALTER TABLE firma.godziny ADD PRIMARY KEY (Id_godziny);
ALTER TABLE firma.pensja_stanowisko ADD PRIMARY KEY (Id_pensji);
ALTER TABLE firma.premia ADD PRIMARY KEY (Id_premii);
ALTER TABLE firma.wynagrodzenie ADD PRIMARY KEY (Id_wynagrodzenia);
--4c)
ALTER TABLE firma.godziny ADD FOREIGN KEY (Id_pracownika) REFERENCES firma.pracownicy (Id_pracownika);
ALTER TABLE firma.wynagrodzenie ADD FOREIGN KEY (Id_pracownika) REFERENCES firma.pracownicy (Id_pracownika);
ALTER TABLE firma.wynagrodzenie ADD FOREIGN KEY (Id_godziny) REFERENCES firma.godziny (Id_godziny);
ALTER TABLE firma.wynagrodzenie ADD FOREIGN KEY (Id_pensji) REFERENCES firma.pensja_stanowisko (Id_pensji);
ALTER TABLE firma.wynagrodzenie ADD FOREIGN KEY (Id_premii) REFERENCES firma.premia (Id_premii);
--4e)
COMMENT ON TABLE firma.pracownicy
IS 'Tabela zawierająca dane pracowników firmy';
COMMENT ON TABLE firma.godziny
IS 'Tabela zawierająca ilość przepracowanych godzin dla każdego pracownika';
COMMENT ON TABLE firma.pensja_stanowisko
IS 'Tabela zawierająca poszczególne stanowiska wraz z ich płacami';
COMMENT ON TABLE firma.premia
IS 'Tabela zawierająca rodzaje premii wraz z ich kwotami';
COMMENT ON TABLE firma.wynagrodzenie
IS 'Tabela zawierająca zestawienie wynagrodzeń dla pracowników';
--5)
--5a)
ALTER TABLE firma.godziny ADD miesiac INT;
ALTER TABLE firma.godziny ADD tydzien INT;
--5b)
ALTER TABLE firma.wynagrodzenie ALTER COLUMN data SET DATA TYPE VARCHAR(30);
--5c)

INSERT INTO firma.pracownicy VALUES(1, 'Maria', 'Zawadzińska', 'Lipowa 33', '123456789');
INSERT INTO firma.pracownicy VALUES(2, 'Jan', 'Zawadziński', 'Lipowa 33', '123456788');
INSERT INTO firma.pracownicy VALUES(3, 'Joanna', 'Mrożonka', 'Rana 2', '123456777');
INSERT INTO firma.pracownicy VALUES(4, 'Tomasz', 'Zielonka', 'Nowa 4A', '123412344');
INSERT INTO firma.pracownicy VALUES(5, 'Marek', 'Czarnecki', 'Leśna 14', '987654321');
INSERT INTO firma.pracownicy VALUES(6, 'Karolina', 'Biała', 'Leśna 3', '345234765');
INSERT INTO firma.pracownicy VALUES(7, 'Jakub', 'Krzak', 'Zielona 12', '123432444');
INSERT INTO firma.pracownicy VALUES(8, 'Stanisław', 'Dąb', 'Sosnowa 13', '888765676');
INSERT INTO firma.pracownicy VALUES(9, 'Maria', 'Kapusta', 'Królowej Jadwigi 11', '965735455');
INSERT INTO firma.pracownicy VALUES(10, 'Piotr', 'Molenda', 'Mickiewicza 4', '119845732');

INSERT INTO firma.godziny VALUES('G1', '2020-01-17', 160, 1, (SELECT DATE_PART ('month', TIMESTAMP '2020-01-17')), (SELECT DATE_PART ('week', TIMESTAMP '2020-01-17')));
INSERT INTO firma.godziny VALUES('G2', '2020-01-17', 160, 2, (SELECT DATE_PART ('month', TIMESTAMP '2020-01-17')), (SELECT DATE_PART ('week', TIMESTAMP '2020-01-17')));
INSERT INTO firma.godziny VALUES('G3', '2020-01-17', 170, 3, (SELECT DATE_PART ('month', TIMESTAMP '2020-01-17')), (SELECT DATE_PART ('week', TIMESTAMP '2020-01-17')));
INSERT INTO firma.godziny VALUES('G4', '2020-01-17', 163, 4, (SELECT DATE_PART ('month', TIMESTAMP '2020-01-17')), (SELECT DATE_PART ('week', TIMESTAMP '2020-01-17')));
INSERT INTO firma.godziny VALUES('G5', '2020-01-17', 160, 5, (SELECT DATE_PART ('month', TIMESTAMP '2020-01-17')), (SELECT DATE_PART ('week', TIMESTAMP '2020-01-17')));
INSERT INTO firma.godziny VALUES('G6', '2020-01-17', 160, 6, (SELECT DATE_PART ('month', TIMESTAMP '2020-01-17')), (SELECT DATE_PART ('week', TIMESTAMP '2020-01-17')));
INSERT INTO firma.godziny VALUES('G7', '2020-01-17', 160, 7, (SELECT DATE_PART ('month', TIMESTAMP '2020-01-17')), (SELECT DATE_PART ('week', TIMESTAMP '2020-01-17')));
INSERT INTO firma.godziny VALUES('G8', '2020-01-17', 165, 8, (SELECT DATE_PART ('month', TIMESTAMP '2020-01-17')), (SELECT DATE_PART ('week', TIMESTAMP '2020-01-17')));
INSERT INTO firma.godziny VALUES('G9', '2020-01-17', 160, 9, (SELECT DATE_PART ('month', TIMESTAMP '2020-01-17')), (SELECT DATE_PART ('week', TIMESTAMP '2020-01-17')));
INSERT INTO firma.godziny VALUES('G10', '2020-01-17', 160, 10, (SELECT DATE_PART ('month', TIMESTAMP '2020-01-17')), (SELECT DATE_PART ('week', TIMESTAMP '2020-01-17')));

INSERT INTO firma.pensja_stanowisko VALUES('S1', 'Dyrektor departamentu administracji', 5000.00);
INSERT INTO firma.pensja_stanowisko VALUES('S2', 'Wiceprezes', 7000.00);
INSERT INTO firma.pensja_stanowisko VALUES('S3', 'Dyrektor ds. Rachunkowości', 5000.00);
INSERT INTO firma.pensja_stanowisko VALUES('S4', 'Ankieter', 1500.00);
INSERT INTO firma.pensja_stanowisko VALUES('S5', 'Dziennikarz', 2700.00);
INSERT INTO firma.pensja_stanowisko VALUES('S6', 'Kierownik biura reklamy', 4000.00);
INSERT INTO firma.pensja_stanowisko VALUES('S7', 'Młodszy specjalista ds. marketingu', 3500.00);
INSERT INTO firma.pensja_stanowisko VALUES('S8', 'Dziennikarz', 2900.00);
INSERT INTO firma.pensja_stanowisko VALUES('S9', 'Młodszy kierownik ds. marki ', 3200.00);
INSERT INTO firma.pensja_stanowisko VALUES('S10', 'Ankieter', 1400.00);

INSERT INTO firma.premia VALUES('Pu1', 'Premia uznaniowa', 500.00);
INSERT INTO firma.premia VALUES('Pdr2', 'Dodatkowe wynagrodzenie roczne', 2500.00);
INSERT INTO firma.premia VALUES('Pm3', 'Premia motywacyjna', 500.00);
INSERT INTO firma.premia VALUES('Pr4', 'Premia regulaminowa', 300.00);
INSERT INTO firma.premia VALUES('Pr5', 'Premia regulaminowa', 200.00);
INSERT INTO firma.premia VALUES('Pz6', 'Premia zespołowa', 600.00);
INSERT INTO firma.premia VALUES('Pdr7', 'Dodatkowe wynagrodzenie roczne', 1500.00);
INSERT INTO firma.premia VALUES('Pk8', 'Premia kwartalna', 650.00);
INSERT INTO firma.premia VALUES('Pr9', 'Premia regulaminowa', 400.00);
INSERT INTO firma.premia VALUES('Pb10', 'Brak', 0.00);

INSERT INTO firma.wynagrodzenie VALUES('W1', '2020-01-30', 1, 'G1', 'S8', 'Pb10');
INSERT INTO firma.wynagrodzenie VALUES('W2', '2020-01-30', 2, 'G3', 'S10', 'Pk8');
INSERT INTO firma.wynagrodzenie VALUES('W3', '2020-01-30', 3, 'G8', 'S5', 'Pb10');
INSERT INTO firma.wynagrodzenie VALUES('W4', '2020-01-30', 4, 'G2', 'S9', 'Pz6');
INSERT INTO firma.wynagrodzenie VALUES('W5', '2020-01-30', 5, 'G10', 'S7', 'Pu1');
INSERT INTO firma.wynagrodzenie VALUES('W6', '2020-01-30', 6, 'G4', 'S4', 'Pr4');
INSERT INTO firma.wynagrodzenie VALUES('W7', '2020-01-30', 7, 'G7', 'S6', 'Pdr2');
INSERT INTO firma.wynagrodzenie VALUES('W8', '2020-01-30', 8, 'G5', 'S1', 'Pu1');
INSERT INTO firma.wynagrodzenie VALUES('W9', '2020-01-30', 9, 'G9', 'S2', 'Pm3');
INSERT INTO firma.wynagrodzenie VALUES('W10', '2020-01-30', 10, 'G6', 'S3', 'Pr9');

--6a)
SELECT id_pracownika, nazwisko 
FROM firma.pracownicy;
--6b)
SELECT id_pracownika, kwota 
FROM firma.wynagrodzenie, firma.pensja_stanowisko
WHERE firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji 
AND firma.pensja_stanowisko.kwota > '1000';
--6c)
SELECT id_pracownika 
FROM firma.wynagrodzenie, firma.pensja_stanowisko, firma.premia 
WHERE firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji 
AND firma.wynagrodzenie.id_premii = firma.premia.id_premii 
AND firma.pensja_stanowisko.kwota > '2000' 
AND firma.premia.kwota = '0';
--6d)
SELECT * FROM firma.pracownicy 
WHERE imie LIKE 'J%';
--6e)
SELECT * FROM firma.pracownicy 
WHERE imie LIKE '%a' 
AND nazwisko LIKE '%n%';
--6f)
SELECT imie, nazwisko, liczba_godzin-160 AS nadgodziny 
FROM firma.pracownicy, firma.godziny 
WHERE firma.pracownicy.id_pracownika = firma.godziny.id_pracownika 
AND firma.godziny.liczba_godzin >160;
--6g)
SELECT imie, nazwisko 
FROM firma.pracownicy, firma.pensja_stanowisko, firma.wynagrodzenie 
WHERE firma.pracownicy.id_pracownika = firma.wynagrodzenie.id_pracownika 
AND firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji 
AND firma.pensja_stanowisko.kwota >= '1500' 
AND firma.pensja_stanowisko.kwota <= '3000';
--6h)
SELECT imie, nazwisko 
FROM firma.pracownicy, firma.godziny, firma.premia, firma.wynagrodzenie 
WHERE firma.pracownicy.id_pracownika = firma.godziny.id_pracownika 
AND firma.godziny.id_godziny = firma.wynagrodzenie.id_godziny 
AND firma.godziny.liczba_godzin > 160 
AND firma.premia.id_premii = 'Pb10';

--7a)
SELECT imie, nazwisko, kwota AS pensja 
FROM firma.pracownicy, firma.wynagrodzenie, firma.pensja_stanowisko 
WHERE firma.wynagrodzenie.id_pracownika = firma.pracownicy.id_pracownika 
AND firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji 
ORDER BY firma.pensja_stanowisko.kwota;
--7b)
SELECT imie, nazwisko, pensja.kwota AS pensja, premia.kwota AS PREMIA 
FROM firma.pracownicy, firma.wynagrodzenie, firma.pensja_stanowisko, firma.premia 
WHERE firma.wynagrodzenie.id_pracownika = firma.pracownicy.id_pracownika 
AND firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji 
AND firma.wynagrodzenie.id_premii = firma.premia.id_premii 
ORDER BY firma.pensja_stanowisko.kwota DESC, firma.premia.kwota DESC;
--7c)
SELECT COUNT (stanowisko) AS stanowisko_ilosc, stanowisko 
FROM firma.pensja_stanowisko, firma.wynagrodzenie
WHERE firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji
GROUP BY firma.pensja_stanowisko.stanowisko;
--7d)
SELECT AVG(kwota::money::numeric::float8) AS srednia_placa, MIN(kwota::numeric), MAX(kwota::numeric) 
FROM firma.pensja_stanowisko 
WHERE firma.pensja_stanowisko.stanowisko = 'Ankieter';
--7e)
SELECT SUM(pensja_stanowisko.kwota::numeric)+SUM(premia.kwota::numeric) AS suma_wynagrodzen 
FROM firma.pensja_stanowisko, firma.premia, firma.wynagrodzenie
WHERE firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji
AND firma.wynagrodzenie.id_premii = firma.premia.id_premii;
--7f)
SELECT stanowisko, SUM(pensja_stanowisko.kwota::numeric)+SUM(premia.kwota::numeric) AS wynagrodzenie 
FROM firma.pensja_stanowisko, firma.premia, firma.wynagrodzenie
WHERE firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji
AND firma.wynagrodzenie.id_premii = firma.premia.id_premii
GROUP BY firma.pensja_stanowisko.stanowisko;
--7g)
SELECT COUNT(rodzaj) AS liczba_premii, stanowisko
FROM firma.premia, firma.wynagrodzenie, firma.pensja_stanowisko
WHERE premia.id_premii = wynagrodzenie.id_premii
AND pensja_stanowisko.id_pensji = wynagrodzenie.id_pensji
GROUP BY firma.pensja_stanowisko.stanowisko;
--7h)
DELETE FROM firma.pracownicy 
USING firma.wynagrodzenie, firma.pensja_stanowisko 
WHERE firma.wynagrodzenie.id_pracownika = firma.pracownicy.id_pracownika 
AND firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji
AND firma.pensja_stanowisko.kwota < '1200';

---8a)
ALTER TABLE firma.pracownicy ALTER COLUMN telefon TYPE VARCHAR(20);
UPDATE firma.pracownicy SET telefon = '(+48)' || telefon;
--8b)
UPDATE firma.pracownicy 
SET	telefon = SUBSTRING(firma.pracownicy.telefon, 1, 8)||'-'||SUBSTRING(firma.pracownicy.telefon, 9, 3)||'-'||SUBSTRING(firma.pracownicy.telefon, 12, 3);
--8c)
SELECT UPPER(nazwisko) AS nazwisko FROM firma.pracownicy
WHERE LENGTH(firma.pracownicy.nazwisko) = (SELECT MAX(LENGTH(firma.pracownicy.nazwisko)) FROM firma.pracownicy);
--8d)
SELECT firma.pracownicy.*, MD5('kwota') AS pensja 
FROM firma.pracownicy, firma.wynagrodzenie, firma.pensja_stanowisko 
WHERE firma.pracownicy.id_pracownika = firma.wynagrodzenie.id_pracownika
AND firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji;

--9)
SELECT CONCAT('Pracownik ', firma.pracownicy.imie,' ', firma.pracownicy.nazwisko,', w dniu ',
firma.wynagrodzenie.data,' otrzymał pensję całkowitą na kwotę ', (firma.pensja_stanowisko.kwota + firma.premia.kwota),
', gdzie wynagrodzenie zasadnicze wynosiło: ', firma.pensja_stanowisko.kwota,
', premia: ', firma.premia.kwota,', nadgodziny: ', (firma.godziny.liczba_godzin-160)) 
AS Raport
FROM firma.wynagrodzenie, firma.pracownicy, firma.pensja_stanowisko, firma.premia, firma.godziny
WHERE firma.wynagrodzenie.id_pracownika = firma.pracownicy.id_pracownika
AND firma.godziny.id_pracownika = firma.pracownicy.id_pracownika
AND firma.wynagrodzenie.id_premii = firma.premia.id_premii 
AND firma.wynagrodzenie.id_pensji = firma.pensja_stanowisko.id_pensji;
