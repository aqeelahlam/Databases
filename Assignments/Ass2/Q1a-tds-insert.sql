--****PLEASE ENTER YOUR DETAILS BELOW****
--Q1a-tds-insert.sql
--Student ID: 29262674
--Student Name: Aqeel Ahlam
--Tutorial No: 5
SET SERVEROUTPUT ON;

/* Comments for your marker:


*/

TRUNCATE TABLE offence;
TRUNCATE TABLE suspension;
/*
1(a) Load selected tables with your own additional test data
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE

--
--OFFENCES FOR 2016
--

--NEW YEAR DRINK AND DRIVE OFFENCES

--ANNMARIE, AUDI Q8
INSERT INTO OFFENCE VALUES (001, TO_DATE('01/01/2016 00:23', 'DD/MM/YYYY hh24:mi'), 'Fulton Drive, Arthurs Creek, 3099', 100, 10000007, '100007', 'WAUZZZF1XKD037356');
--PERKIN, MITSUBISHI LANCER
INSERT INTO OFFENCE VALUES (002, TO_DATE('01/01/2016 00:28', 'DD/MM/YYYY HH24:MI'), 'Scoville Alley, Melbourne, 3000', 100, 10000001, '100008', 'JA3AJ16E05U031516');
--EARLE, BMW 3 SERIES: PENDING SUSPENSION - 4 DEMERITS
INSERT INTO OFFENCE VALUES (003, TO_DATE('01/01/2016 00:40', 'DD/MM/YYYY HH24:MI'), 'Messerschmidt Drive, Melbourne, 3000', 100, 10000005, '100101', 'WBAAM333XYKC67114');
--ODELINDA, BENZ C-CLASS: PENDING SUSPENSION - 4 DEMERITS
INSERT INTO OFFENCE VALUES (004, TO_DATE('01/01/2016 00:45', 'DD/MM/YYYY HH24:MI'), '7th Avenue, Melbourne, 3000', 100, 10000001, '100036', 'WDDGF4HB8CR234192');
--JOANNE, TOYOTA HILUX
INSERT INTO OFFENCE VALUES (005, TO_DATE('01/01/2016 00:46', 'DD/MM/YYYY HH24:MI'), 'Forest Run Way, Arthurs Creek, 3099', 100, 10000007, '100399', 'JT4RN55D1J7027072');
--THORPE, KIA SORENTO
INSERT INTO OFFENCE VALUES (006, TO_DATE('01/01/2016 00:50', 'DD/MM/YYYY HH24:MI'), 'Sutherland Alley ,Pakenham, 3810', 100, 10000002, '100046', '5XYKWDA70EG526849');
--TYMOTHY, FERRARI 348
INSERT INTO OFFENCE VALUES (007, TO_DATE('01/01/2016 00:56', 'DD/MM/YYYY HH24:MI'), 'Mitchell Alley, Berwick, 3806', 100, 10000003, '100098', 'ZFFRG43A0R0096189');
--ALEX, VW GOLF
INSERT INTO OFFENCE VALUES (008, TO_DATE('01/01/2016 01:20', 'DD/MM/YYYY HH24:MI'), 'Birchwood Terrace, Lysterfield, 3156', 100, 10000016, '100127', 'WVWDA7AJ4EW010470');
--BESSY, TESLA MODEL S
INSERT INTO OFFENCE VALUES (009, TO_DATE('01/01/2016 03:20', 'DD/MM/YYYY HH24:MI'), 'Larry Place, Melbourne, 3000', 100, 10000015, '100143', '5YJSA3H10EFP46509');

COMMIT;    

--MISC OFFENCES

--ODELINDA, BENZ C-CLASS: PENDING SUSPENSION - 8 DEMERITS
INSERT INTO OFFENCE VALUES (010, TO_DATE('05/01/2016 12:30', 'DD/MM/YYYY HH24:MI'), 'Dexter Terrace, Melbourne, 3000', 102, 10000005, '100036', 'WDDGF4HB8CR234192');
--ODELINDA, BENZ C-CLASS: PENDING SUSPENSION - 12 DEMERITS OBTAINED WITHIN THREE YEARS- SUSPENSION
INSERT INTO OFFENCE VALUES (011, TO_DATE('29/01/2016 15:45', 'DD/MM/YYYY HH24:MI'), 'Messerschmidt Drive, Melbourne, 3000', 102, 10000001, '100036', 'WDDGF4HB8CR234192');
--LICENCSE SUSPENDED FOR 6 MONTHS
INSERT INTO SUSPENSION VALUES ('100036', TO_DATE('29/01/2016', 'DD/MM/YYYY'), TO_DATE('29/07/2016', 'DD/MM/YYYY'));
--RAYNARD, LAMBORGHINI HURACAN: PENDING SUSPENSION - 4 DEMERITS
INSERT INTO OFFENCE VALUES (012, TO_DATE('29/01/2016 12:43', 'DD/MM/YYYY HH24:MI'), 'Village Center, Clayton, 3168', 99, 10000004, '100136', 'ZHWEF4ZF2LLA13803');
--CATERINA, VW BEETLE
INSERT INTO OFFENCE VALUES (013, TO_DATE('06/02/2016 15:20', 'DD/MM/YYYY HH24:MI'), 'Gale Trail, Belgrave, 3160', 118, 10000011, '100107', '3VWRR31C56M424400');
--ROBIN, HYUNDAI SONATA
INSERT INTO OFFENCE VALUES (014, TO_DATE('04/06/2016 13:42', 'DD/MM/YYYY HH24:MI'), 'Richmond, 3121', 110, 10000013, '100057', 'KMHWF25H44A010707');
--HOLLIE, BMW M3
INSERT INTO OFFENCE VALUES (015, TO_DATE('23/08/2016 18:33', 'DD/MM/YYYY HH24:MI'), '7th Avenue, Melbourne, 3000', 127, 10000001, '100261', 'WBSWL93539P528903');
--DANIT, TOYOTA CAMRY
INSERT INTO OFFENCE VALUES (016, TO_DATE('15/10/2016 22:42', 'DD/MM/YYYY HH24:MI'), 'Badeau Center, Lysterfield, 3156', 118, 10000016, '100238', '4T1BD1FK5EU109805');
--ROLFE, MITSUBISHI RAIDER
INSERT INTO OFFENCE VALUES (017, TO_DATE('31/12/2016 23:50', 'DD/MM/YYYY HH24:MI'), 'Scoville Alley, Melbourne, 3000', 118, 10000015, '100288', '1Z7HT38N070010439');

COMMIT; 

--
-- OFFENCES FOR 2017
--

--NEW YEAR DRINK AND DRIVE OFFENCES

--EARLE, BMW 3 SERIES: PENDING SUSPENSION - 8 DEMERITS
INSERT INTO OFFENCE VALUES (018, TO_DATE('01/01/2017 00:10', 'DD/MM/YYYY HH24:MI'), 'Larry Place, Melbourne, 3000', 100, 10000001, '100101', 'WBAAM333XYKC67114');
--FRAZIER, MINI COOPER
INSERT INTO OFFENCE VALUES (019, TO_DATE('01/01/2017 00:21', 'DD/MM/YYYY HH24:MI'), 'Fallview Alley, Leongatha, 3953', 100, 10000006, '100327', 'WMWMF73509TV39579');
--ISIDORA, MITSUBISHI ECLIPSE SPYDER
INSERT INTO OFFENCE VALUES (020, TO_DATE('01/01/2017 00:45', 'DD/MM/YYYY HH24:MI'), 'Mallory Court, Attwood, 3049', 100, 10000012, '100359', '4A3AX55F0TE411509');
--KENNEDY, VOLVO VHD
INSERT INTO OFFENCE VALUES (021, TO_DATE('01/01/2017 00:21', 'DD/MM/YYYY HH24:MI'), 'Hoard Alley, Berwick, 3806', 100, 10000010 , '100033', '4V5KC9GF38N491144');


--MISC OFFENCES

--BARTY, FERRARI 360
INSERT INTO OFFENCE VALUES (022, TO_DATE('06/02/2017 13:20', 'DD/MM/YYYY HH24:MI'), 'Muir Street, Belgrave, 3160', 102, 10000011, '100151', 'ZFFYT53A020127749');
--PERRI, BMW X5
INSERT INTO OFFENCE VALUES (023, TO_DATE('12/03/2017 14:12', 'DD/MM/YYYY HH24:MI'), 'Elka Junction, Clayton South, 3169', 107, 10000008, '100012', '5UXZW0C50C0B88196');
--EARLE, BMW 3 SERIES: PENDING SUSPENSION - 12 DEMERITS OBTAINED WITHIN THREE YEARS- SUSPENSION
INSERT INTO OFFENCE VALUES (024, TO_DATE('03/04/2017 21:39', 'DD/MM/YYYY HH24:MI'), 'School Court, Melbourne, 3000', 102, 10000005, '100101', 'WBAAM333XYKC67114');
--LICENCSE SUSPENDED FOR 6 MONTHS
INSERT INTO SUSPENSION VALUES ('100101', TO_DATE('03/04/2017', 'DD/MM/YYYY'), TO_DATE('03/10/2017', 'DD/MM/YYYY'));
--BRITA, BMW 7 SERIES: PENDING SUSPENSION - 4 DEMERITS
INSERT INTO OFFENCE VALUES (025, TO_DATE('12/04/2017 13:32', 'DD/MM/YYYY HH24:MI'), 'Larry Place, Melbourne, 3000', 106, 10000005, '100158', 'WBANB53577C716503');
--PHILLIE, HYUNDAI TUCSON: PENDING SUSPENSION - 4 DEMERITS
INSERT INTO OFFENCE VALUES (026, TO_DATE('15/05/2017 21:43', 'DD/MM/YYYY HH24:MI'), 'Talmadge Crossing, Manning, 6152', 124, 10000009, '100125', 'KMHJM81B09U044783');
--LUCITA, HYUNDAI GENESIS
INSERT INTO OFFENCE VALUES (027, TO_DATE('31/05/2017 12:45', 'DD/MM/YYYY HH24:MI'), 'Haas Crossing, Melbourne, 3000', 127, 10000001, '100333', 'KMHGC41D5DU232392');
--BRITA, BMW 7 SERIES: PENDING SUSPENSION - 8 DEMERITS
INSERT INTO OFFENCE VALUES (028, TO_DATE('12/06/2017 19:32', 'DD/MM/YYYY HH24:MI'), 'Badeau Center, Lysterfield, 3156', 102, 10000016, '100158', 'WBANB53577C716503');
--RAYNARD, LAMBORGHINI HURACAN : PENDING SUSPENSION - 8 DEMERITS
INSERT INTO OFFENCE VALUES (029, TO_DATE('03/07/2017 12:43', 'DD/MM/YYYY HH24:MI'), 'Ridge Oak Pass, Clayton South, 3169', 99, 10000008, '100136', 'ZHWEF4ZF2LLA13803');
--BRITA, BMW 7 SERIES: PENDING SUSPENSION - 12 DEMERITS OBTAINED WITHIN THREE YEARS- SUSPENSION
INSERT INTO OFFENCE VALUES (030, TO_DATE('12/12/2017 19:32', 'DD/MM/YYYY HH24:MI'), 'Cordelia Court, Melbourne, 3000', 99, 10000005, '100158', 'WBANB53577C716503');
--LICENCSE SUSPENDED FOR 6 MONTHS
INSERT INTO SUSPENSION VALUES ('100158', TO_DATE('12/12/2017', 'DD/MM/YYYY'), TO_DATE('12/06/2018', 'DD/MM/YYYY'));

COMMIT;

--
-- OFFENCES FOR 2018
--

--PHILLIE, HYUNDAI TUCSON: PENDING SUSPENSION - 8 DEMERITS
INSERT INTO OFFENCE VALUES (031, TO_DATE('03/01/2018 21:43', 'DD/MM/YYYY HH24:MI'), 'Kenwood Trail, Manning, 6152', 101, 10000009, '100125', 'KMHJM81B09U044783');
--PHILLIE, HYUNDAI TUCSON: PENDING SUSPENSION - 12 DEMERITS OBTAINED WITHIN THREE YEARS- SUSPENSION
INSERT INTO OFFENCE VALUES (032, TO_DATE('21/01/2018 11:22', 'DD/MM/YYYY HH24:MI'), 'Scott Place, Manning, 6152', 101, 10000009, '100125', 'KMHJM81B09U044783');
--LICENCSE SUSPENDED FOR 6 MONTHS
INSERT INTO SUSPENSION VALUES ('100125', TO_DATE('21/01/2018', 'DD/MM/YYYY'), TO_DATE('21/07/2018', 'DD/MM/YYYY'));
--RIP, LAND ROVER DEFENDER
INSERT INTO OFFENCE VALUES (033, TO_DATE('12/03/2018 21:43', 'DD/MM/YYYY HH24:MI'), 'Rigney Road, Lysterfield, 3156', 118, 10000016, '100270', 'SALDV328XSA855785');
--BOBBI, HUMMER H1 ALPHA
INSERT INTO OFFENCE VALUES (034, TO_DATE('15/05/2018 12:13', 'DD/MM/YYYY HH24:MI'), '1st Plaza, Belgrave, 3160', 122, 10000011, '100280', '137PH90366E221476');
--RAYMOND, LAMBORGHINI HURACAN PERFORMANTE
INSERT INTO OFFENCE VALUES (035, TO_DATE('24/08/2018 00:15', 'DD/MM/YYYY HH24:MI'), 'Shopko Point, Melbourne, 3000', 99, 10000005, '100078', 'ZHWES4ZF8KLA12259');
--RAYNARD, LAMBORGHINI HURACAN : PENDING SUSPENSION - 12 DEMERITS OBTAINED WITHIN THREE YEARS- SUSPENSION
INSERT INTO OFFENCE VALUES (036, TO_DATE('23/12/2018 15:43', 'DD/MM/YYYY HH24:MI'), 'Moose Way, Clayton South, 3169', 99, 10000004, '100136', 'ZHWEF4ZF2LLA13803');
--LICENCSE SUSPENDED FOR 6 MONTHS-- CHECK DATE 
INSERT INTO SUSPENSION VALUES ('100136', TO_DATE('23/12/2018', 'DD/MM/YYYY'), TO_DATE('23/06/2019', 'DD/MM/YYYY'));
COMMIT;

--
-- OFFENCES FOR 2019
--

--NED, NISSAN D21
INSERT INTO OFFENCE VALUES (037, TO_DATE('23/02/2019 13:21', 'DD/MM/YYYY HH24:MI'), 'Utah Trail, Melbourne, 3000', 123, 10000005, '100321', '1N6ND12Y1HC385546');
--CONSTANTIA, NISSAN MURANO
INSERT INTO OFFENCE VALUES (038, TO_DATE('15/03/2019 15:43', 'DD/MM/YYYY HH24:MI'), 'Monterey Parkway, Belgrave, 3160', 125, 10000011, '100213', 'JN8AZ08W77W77W642');
--MAHALA, FORD EXPEDITION
INSERT INTO OFFENCE VALUES (039, TO_DATE('04/05/2019 04:13', 'DD/MM/YYYY HH24:MI'), 'Badeau Street, Manning, 6152', 102, 10000009, '100251', '1FMEU15N6TLB18475');
--CAR, LEXUS RX
INSERT INTO OFFENCE VALUES (040, TO_DATE('21/05/2019 23:54', 'DD/MM/YYYY HH24:MI'), 'Oxford Trail, Attwood, 3049', 130, 10000012, '100231', '2T2BK1BA8BC089027');
--RIP, LAND ROVER DEFENDER
INSERT INTO OFFENCE VALUES (041, TO_DATE('12/06/2019 13:12', 'DD/MM/YYYY HH24:MI'), 'Truax Terrace, Lysterfield, 3156', 102, 10000014, '100270', 'SALDV328XSA855785');
--VINA, RANGER ROVER
INSERT INTO OFFENCE VALUES (042, TO_DATE('14/06/2019 02:12', 'DD/MM/YYYY HH24:MI'), 'Gale Trail, Belgrave, 3160', 102, 10000011, '100094', 'SALSF2D42BA702925');
--VINA, RANGE ROVER
INSERT INTO OFFENCE VALUES (043, TO_DATE('20/06/2019 15:34', 'DD/MM/YYYY HH24:MI'), 'Gale Trail, Belgrave, 3160', 102, 10000011, '100094', 'SALSF2D42BA702925');
COMMIT;




SELECT * FROM DEMERIT;
