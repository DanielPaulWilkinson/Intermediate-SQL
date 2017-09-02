/*Dropping tables backwards due to relationships*/
DROP TABLE Module_Lecturers;
DROP TABLE Lecturers;
DROP TABLE Module_Assessments;
DROP TABLE Module_Leaders;
DROP TABLE External_Markers;
DROP TABLE Administrators;
DROP TABLE Module;
DROP TABLE Assessments;

/*Creations of table structures*/
CREATE TABLE Assessments
(Assessment_ID Number(6) PRIMARY KEY,
Assessment_Name Varchar2(25),
Assessment_Length Varchar(25),
Assessment_Date Date);

CREATE TABLE Module
(M_ID Number(6) PRIMARY KEY,
M_Name Varchar2(25),
M_Desc Varchar2(255));

CREATE TABLE Administrators
(Admin_ID number(6) PRIMARY KEY,
Admin_Forename Varchar2(25),
Admin_Surname Varchar2(25),
Admin_Address Varchar2(60),
Admin_DOB Date,
Admin_Approvel Char(1),
M_ID number(6) NOT NULL REFERENCES Module(M_ID));

CREATE TABLE External_Markers
(EM_ID number(6) PRIMARY KEY,
EM_Postcode Varchar2(25),
EM_Phoneno Varchar2(25),
EM_Address Varchar2(60),
EM_Company Varchar2(25),
EM_Approvel Char(1),
M_ID number(6) NOT NULL REFERENCES Module(M_ID));


CREATE TABLE Module_Leaders
(ML_ID number(6) PRIMARY KEY,
ML_Forename Varchar2(25),
ML_Surname Varchar2(25),
ML_Address Varchar2(60),
ML_DOB Date,
M_ID Number(6) NOT NULL REFERENCES Module(M_ID));

CREATE TABLE Module_Assessments
(MA_ID Number(6),
Assessment_ID number(6) REFERENCES Assessments(Assessment_ID),
M_ID number(6) REFERENCES Module(M_ID));

CREATE TABLE Lecturers
(L_ID number(6) PRIMARY KEY,
L_Forename Varchar2(25),
L_Surname Varchar2(25),
L_Address Varchar2(60),
L_DOB Date);

CREATE TABLE Module_Lecturers
(MOL_ID number(6) PRIMARY KEY,
L_ID number(6) NOT NULL REFERENCES Lecturers(L_ID),
M_ID number(6) REFERENCES Module(M_ID));

/*Inserting data*/

INSERT INTO Assessments VALUES (000001,'TCT','2 Hours','27-JUL-1996');
INSERT INTO Assessments VALUES (000002,'Presintation','10-30m','27-JUL-1996');
INSERT INTO Assessments VALUES (000003,'Course Work',Null,'27-JUL-1996');

INSERT INTO Module VALUES (000001,'Database','A module focused on the dsign and implimentation of databases.');
INSERT INTO Module VALUES (000002,'Software Engineering','A module focused on dealing with methods on how to drive the development forward..');
INSERT INTO Module VALUES (000003,'Software Development','A module focused on the dsign and implimentation of Software.');

INSERT INTO ADMINISTRATORS VALUES (000001,'Daniel','Wilkinson','440 Lemon Avenue, South End, Mildletown','27-JUL-1996','N',000001);
INSERT INTO ADMINISTRATORS VALUES (000002,'David','Howdy','70 Pie Drive, Grindon, West End','27-JUL-1996','Y',000002);
INSERT INTO ADMINISTRATORS VALUES (000003,'Dede','Lowly','70 lemon Drive, yoey, West south','30-JUL-1996','Y',000003);

INSERT INTO EXTERNAL_MARKERS VALUES(000001,'SR8 LFG','07572134564','311 MiddleMan Lane, Edinburgh, Scotland','Scotish Marking Board','Y',000001);
INSERT INTO EXTERNAL_MARKERS VALUES(000002,'SR4 SDG','05672847564','43 Dovecove Rd, Cardiff, Wales','Welsh Marking Board','N',000002);
INSERT INTO EXTERNAL_MARKERS VALUES(000003,'SR4 SDG','05672847564','43 Dovecove Rd, Cardiff, Wales','Welsh Marking Board','N',000003);

INSERT INTO MODULE_LEADERS VALUES (000001,'Robert','Warrender','70 Oaks Drive, Grindon, Sunderland','27-JUL-1996',000001);
INSERT INTO MODULE_LEADERS VALUES (000002,'Kathy','Clawson','85 lucky Avenue, YoVile, BolobbyTown','27-JUL-1995',000003);
INSERT INTO MODULE_LEADERS VALUES (000003,'Carol','Brown','56 Green Square, Hazard Blvd, missiontown','27-JUL-1997',000002);

/*Primary Key-Module ID-Assesment_ID*/
INSERT INTO MODULE_ASSESSMENTS VALUES(000001,000001,000001);
INSERT INTO MODULE_ASSESSMENTS VALUES(000002,000002,000002);
INSERT INTO MODULE_ASSESSMENTS VALUES(000003,000001,000003);
INSERT INTO MODULE_ASSESSMENTS VALUES(000004,000003,000003);

INSERT INTO LECTURERS VALUES (000001,'Lez','Kingham','46 orange Melon, Endhouse Blvd, DontGoHereViile','27-JUL-1967');
INSERT INTO LECTURERS VALUES (000002,'Liz','Gandy','36 green Melon, LeftWing Drive, GoHereViile','27-JUL-1967');
INSERT INTO LECTURERS VALUES (000003,'Lina','White','26 yellow Melon, YOYOtown, UnkindViile','27-JUL-1967');

/*Primary - Lecturer - Module*/
INSERT INTO MODULE_LECTURERS VALUES(000001,000001,000002);
INSERT INTO MODULE_LECTURERS VALUES(000002,000002,000003);
INSERT INTO MODULE_LECTURERS VALUES(000003,000003,000003);
INSERT INTO MODULE_LECTURERS VALUES(000004,000001,000001);

/*Possible Modules*/
Select * from Module;

/*What module leader is Leader of what Module?*/
Select M.ML_Forename , M.ML_SURNAME, O.M_Name 
from MODULE_LEADERS M, Module O
WHERE M.M_ID = O.M_ID;

/*What lecturers are on which Modules?*/
Select a.MOL_ID ID, b.L_FORENAME First_Name ,b.L_SURNAME Second_Name,c.M_NAME Name_Of_Module
From MODULE_LECTURERS a, LECTURERS b, MODULE c
where a.L_ID = b.L_ID 
And a.M_ID = c.M_ID
Order by a.MOL_ID asc;

/*What assignments are on all module?*/
Select a.MA_ID ID, b.Assessment_Name Test ,c.M_Name On_Module
FROM MODULE_ASSESSMENTS a, ASSESSMENTS b, Module c
Where a.M_ID = c.M_ID 
And a.ASSESSMENT_ID = b.ASSESSMENT_ID
Order by a.MA_ID;

/*Approvel Of Modules by Admin?*/
Select a.M_ID ID,M_NAME Module,c.Admin_Approvel
From Module a, ADMINISTRATORS c
Where a.M_ID = c.M_ID;

/*Approvel Of Modules by External Examiner?*/
Select a.M_ID ID,M_NAME Module,c.EM_Approvel
From Module a, EXTERNAL_MARKERS c
Where a.M_ID = c.M_ID;

/*Both Admin and External*/
Select a.M_ID ID,M_Name Module_Name,b.EM_COMPANY Company,EM_Approvel,c.ADMIN_FORENAME Name,ADMIN_APPROVEL 
From Module a,EXTERNAL_MARKERS b, ADMINISTRATORS c
Where a.M_ID = b.M_ID
And a.M_ID = c.M_ID;



