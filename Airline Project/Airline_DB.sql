--/*************************IF TABLES EXIST ALREADY**************************/
--
--DROP TABLE states CASCADE CONSTRAINTS;
--DROP TABLE aircraftspecs CASCADE CONSTRAINTS;
--DROP TABLE flightstatus CASCADE CONSTRAINTS;
--DROP TABLE airplane CASCADE CONSTRAINTS;
--DROP TABLE city CASCADE CONSTRAINTS;
--DROP TABLE airport CASCADE CONSTRAINTS;
--DROP TABLE flightroute CASCADE CONSTRAINTS;
--DROP TABLE flightschedule CASCADE CONSTRAINTS;
--
--COMMIT;

/*************************CREATION OF TABLES STARTED**************************/
/**************************States Table*****************************************/
--  Create the States table to hold information of airport's state.

CREATE TABLE States
(
stateAbbr VARCHAR(2) NOT NULL,
stateName VARCHAR(20) NOT NULL,

CONSTRAINT States_PK PRIMARY KEY(stateAbbr)
);


/**************************AircraftSpecs Table**********************************/
--  Create the AircraftSpecs table to hold information of airplane specification.

CREATE TABLE AircraftSpecs
(
aircraftTypeID CHAR(8) NOT NULL,
aircraftVersion VARCHAR(10) NOT NULL,
cabinNumOfSeats INT,
fuelCapacity INT NOT NULL,
CONSTRAINT AircraftSpecs_PK PRIMARY KEY(aircraftTypeID)
);


/*************************FlightStatus Table***********************************/
--  Create the FlightStatus table to hold information of flight status.

CREATE TABLE FlightStatus
(
statusID CHAR(1) NOT NULL CHECK(statusID IN('O','D','C')),
description VARCHAR(20) NOT NULL,
CONSTRAINT FlightStatus_PK PRIMARY KEY(statusID)
);


/*************************Airplane Table**************************************/
--  Create the Airplane table to hold information of airplane.

CREATE TABLE Airplane
(
airplaneID CHAR(8) NOT NULL,
aircraftTypeID CHAR(8) NOT NULL,
purchaseDate DATE DEFAULT '01-OCT-2019' NOT NULL ,
CONSTRAINT Airplane_PK PRIMARY KEY(airplaneID),
CONSTRAINT Airplane_FK FOREIGN KEY(aircraftTypeID) REFERENCES AircraftSpecs(aircraftTypeID)
);


/************************City Table*******************************************/
--  Create the City table to hold information of airport's city.

CREATE TABLE City
(
cityID CHAR(8) NOT NULL,
cityName VARCHAR(25) NOT NULL,
stateAbbr VARCHAR(2) NOT NULL,
CONSTRAINT City_PK PRIMARY KEY(cityID),
CONSTRAINT City_FK FOREIGN KEY(stateAbbr) REFERENCES States(stateAbbr)
);


/*************************Airport Table**************************************/
--  Create the Airport table to hold information of airport.

CREATE TABLE Airport
(
airportID CHAR(3) NOT NULL,
airportName VARCHAR(45) NOT NULL UNIQUE,
cityID CHAR(8) NOT NULL,
CONSTRAINT Airport_PK PRIMARY KEY(airportID),
CONSTRAINT Airport_FK FOREIGN KEY(cityID) REFERENCES City(cityID)
);


/*************************FlightRoute Table*********************************/
--  Create the FlightRoute table to hold information of the flight route.

CREATE TABLE FlightRoute
(
flightNumber VARCHAR(6) NOT NULL,
departAirport CHAR(3) NOT NULL,
arriveAirport CHAR(3) NOT NULL,
distance Number NOT NULL,

CONSTRAINT FlightRoute_PK PRIMARY KEY(flightNumber),
CONSTRAINT FlightRoute_FK_depart FOREIGN KEY(departAirport) REFERENCES Airport(airportID),
CONSTRAINT FlightRoute_FK_arrive FOREIGN KEY(arriveAirport) REFERENCES Airport(airportID)
);


/**********************FlightSchedule Table ********************************/
-- Create the FlightSchedule table to hold information of the Flight Schedule.
--  Since the primary key uses IDENTITY, we don't specify a value for that column 
-- (It will be unique start with 1 and auto increment by default).


CREATE TABLE FlightSchedule
(
scheduleID NUMBER  GENERATED AS IDENTITY,
flightNumber VARCHAR(6) NOT NULL,
departDateTime TIMESTAMP,
arrivalDateTime TIMESTAMP,
statusID CHAR(1) NOT NULL CHECK(statusID IN('O','D','C')),
airplaneID CHAR(8) NOT NULL,
delayDepartTime TIMESTAMP,
delayArrivalTime TIMESTAMP,
CONSTRAINT FlightSchedule_PK PRIMARY KEY(scheduleID),
CONSTRAINT FlightSchedule_FK_flightNumber FOREIGN KEY(flightNumber) REFERENCES FlightRoute(flightNumber),
CONSTRAINT FlightSchedule_FK_statusID FOREIGN KEY(statusID) REFERENCES FlightStatus(statusID),
CONSTRAINT FlightSchedule_FK_airplaneID FOREIGN KEY(airplaneID) REFERENCES Airplane(airplaneID),
CONSTRAINT DateTimeArrive_ck CHECK (arrivalDateTime > departDateTime)
);

/*=============================== CREATION OF TABLES COMPLETED ===================================================/



/*========================================INSERTION OF DATA ======================================================/

/*************************States Table***********************************/
--  Populate the States table.

INSERT INTO States(stateAbbr,stateName) VALUES('CA','California');
INSERT INTO States(stateAbbr,stateName) VALUES('DC','Washington, D.C.');
INSERT INTO States(stateAbbr,stateName) VALUES('FL','Florida');
INSERT INTO States(stateAbbr,stateName) VALUES('IL','Illinois');
INSERT INTO States(stateAbbr,stateName) VALUES('MA','Massachusetts');
INSERT INTO States(stateAbbr,stateName) VALUES('NY','New York');
INSERT INTO States(stateAbbr,stateName) VALUES('TX','Texas');
INSERT INTO States(stateAbbr,stateName) VALUES('IN','Indiana');


/*************************City Table***********************************/
--  Populate the City table.

INSERT INTO City(cityID,cityName,stateAbbr) VALUES('C001','Los Angeles','CA');
INSERT INTO City(cityID,cityName,stateAbbr) VALUES('C002','San Francisco','CA');
INSERT INTO City(cityID,cityName,stateAbbr) VALUES('C003','Washington, D.C.','DC');
INSERT INTO City(cityID,cityName,stateAbbr) VALUES('C004','Miami','FL');
INSERT INTO City(cityID,cityName,stateAbbr) VALUES('C005','Orlando','FL');
INSERT INTO City(cityID,cityName,stateAbbr) VALUES('C006','Chicago','IL');
INSERT INTO City(cityID,cityName,stateAbbr) VALUES('C007','Boston','MA');
INSERT INTO City(cityID,cityName,stateAbbr) VALUES('C008','New York','NY');
INSERT INTO City(cityID,cityName,stateAbbr) VALUES('C009','Syracuse','NY');
INSERT INTO City(cityID,cityName,stateAbbr) VALUES('C010','Indianapolis','IN');


/*************************Airport Table***********************************/
--  Populate the Airport table.

INSERT INTO Airport(airportID,airportName,cityID) VALUES('BOS','Boston Logan International Airport','C007');
INSERT INTO Airport(airportID,airportName,cityID) VALUES('DCA','Ronald Regan National Airport','C003');
INSERT INTO Airport(airportID,airportName,cityID) VALUES('IAD','Washington Dulles International Airport','C003');
INSERT INTO Airport(airportID,airportName,cityID) VALUES('JFK','John F. Kennedy International Airport','C008');
INSERT INTO Airport(airportID,airportName,cityID) VALUES('LAX','Los Angeles International Airport','C001');
INSERT INTO Airport(airportID,airportName,cityID) VALUES('LGA','LaGuardia Airport','C008');
INSERT INTO Airport(airportID,airportName,cityID) VALUES('MCO','Orlando International Airport','C005');
INSERT INTO Airport(airportID,airportName,cityID) VALUES('MDW','Chicago Midway International Airport','C006');
INSERT INTO Airport(airportID,airportName,cityID) VALUES('MIA','Miami International Airport','C004');
INSERT INTO Airport(airportID,airportName,cityID) VALUES('ORD','Chicago OHare International Airport','C006');
INSERT INTO Airport(airportID,airportName,cityID) VALUES('SFO','San Francisco International Airport','C002');
INSERT INTO Airport(airportID,airportName,cityID) VALUES('SYR','Syracuse Hancock International Airport','C009');
INSERT INTO Airport(airportID,airportName,cityID) VALUES('IND','Indianapolis International Airport','C010');

/*************************AircraftSpecs Table***********************************/
--  Populate the AircraftSpecs table.

INSERT INTO AircraftSpecs(aircraftTypeID,aircraftVersion,cabinNumOfSeats,fuelCapacity) VALUES('AIR1','321-200',220,7930);
INSERT INTO AircraftSpecs(aircraftTypeID,aircraftVersion,cabinNumOfSeats,fuelCapacity) VALUES('AIR2','737-600',132,6875);
INSERT INTO AircraftSpecs(aircraftTypeID,aircraftVersion,cabinNumOfSeats,fuelCapacity) VALUES('BOE1','747-400',416,63705);
INSERT INTO AircraftSpecs(aircraftTypeID,aircraftVersion,cabinNumOfSeats,fuelCapacity) VALUES('BOE2','767-300',350,23980);
INSERT INTO AircraftSpecs(aircraftTypeID,aircraftVersion,cabinNumOfSeats,fuelCapacity) VALUES('BOE3','737-600',132,6875);
INSERT INTO AircraftSpecs(aircraftTypeID,aircraftVersion,cabinNumOfSeats,fuelCapacity) VALUES('BOE4','737-900',167,10707);


/*************************Airplane Table***********************************/
--  Populate the Airplane table.

INSERT INTO Airplane(airplaneID,aircraftTypeID,purchaseDate) VALUES('AP098640','AIR2','01-MAR-13');
INSERT INTO Airplane(airplaneID,aircraftTypeID,purchaseDate) VALUES('AP239471','AIR1','10-JUN-15');
INSERT INTO Airplane(airplaneID,aircraftTypeID,purchaseDate) VALUES('AP309814','BOE2','15-MAY-15');
INSERT INTO Airplane(airplaneID,aircraftTypeID,purchaseDate) VALUES('AP629342','BOE1','20-OCT-13');
INSERT INTO Airplane(airplaneID,aircraftTypeID,purchaseDate) VALUES('AP872139','BOE3','02-SEP-18');
INSERT INTO Airplane(airplaneID,aircraftTypeID,purchaseDate) VALUES('AP998911','BOE2','01-OCT-09');
INSERT INTO Airplane(airplaneID,aircraftTypeID,purchaseDate) VALUES('AP998981','BOE4','01-NOV-15');

/*************************FlightRoute Table***********************************/
--  Populate the FlightRoute table.

INSERT INTO FlightRoute(flightNumber,departAirport,arriveAirport,distance) VALUES('3310','SYR','JFK', 209);
INSERT INTO FlightRoute(flightNumber,departAirport,arriveAirport,distance) VALUES('3312','JFK','SYR', 209);
INSERT INTO FlightRoute(flightNumber,departAirport,arriveAirport,distance) VALUES('3426','LAX','ORD', 1745);
INSERT INTO FlightRoute(flightNumber,departAirport,arriveAirport,distance) VALUES('5063','BOS','MCO', 1121);
INSERT INTO FlightRoute(flightNumber,departAirport,arriveAirport,distance) VALUES('5099','BOS','ORD', 867);


/*************************FlightStatus Table***********************************/
--  Populate the FlightStatus table.

INSERT INTO FlightStatus(statusID,description) VALUES('C','Cancelled');
INSERT INTO FlightStatus(statusID,description) VALUES('D','Delay');
INSERT INTO FlightStatus(statusID,description) VALUES('O','On Time');


/*************************FlightSchedule Table***********************************/
--  Populate the FlightSchedule table.

INSERT INTO FlightSchedule(flightNumber,departDateTime, arrivalDateTime, statusID,airplaneID) 
 VALUES('3310','01-OCT-21 08:00:00 AM', '01-OCT-21 09:02:00 AM', 'O','AP872139');
INSERT INTO FlightSchedule(flightNumber,departDateTime, arrivalDateTime, statusID,airplaneID)  
 VALUES('3310','05-OCT-21 08:00:00 AM', '05-OCT-21 09:02:00 AM', 'O','AP309814');
 INSERT INTO FlightSchedule(flightNumber,departDateTime, arrivalDateTime, statusID,airplaneID)  
 VALUES('3310','02-OCT-21 08:00:00 AM', '02-OCT-21 09:02:00 AM', 'O','AP998911');
INSERT INTO FlightSchedule(flightNumber,departDateTime, arrivalDateTime, statusID,airplaneID) 
 VALUES('3312','03-OCT-21 12:20:00 PM', '03-OCT-21 01:30:00 PM', 'C','AP872139');
INSERT INTO FlightSchedule(flightNumber,departDateTime, arrivalDateTime, statusID,airplaneID)  
 VALUES('3426','04-OCT-21 11:15:00 AM', '04-OCT-21 02:05:00 PM', 'O','AP239471');
INSERT INTO FlightSchedule(flightNumber,departDateTime, arrivalDateTime, statusID,airplaneID, delayDepartTime, delayArrivalTime)
 VALUES('5063','16-OCT-21 02:30:00 PM', '16-OCT-21 06:45:00 PM', 'D','AP998911', '16-OCT-21 03:00:00 PM','16-OCT-21 07:25:00 PM');
 INSERT INTO FlightSchedule(flightNumber,departDateTime, arrivalDateTime, statusID,airplaneID, delayDepartTime, delayArrivalTime)
 VALUES('5063','18-OCT-21 02:30:00 PM', '18-OCT-21 06:45:00 PM', 'D','AP239471', '18-OCT-21 03:00:00 PM','18-OCT-21 07:25:00 PM');
INSERT INTO FlightSchedule(flightNumber,departDateTime, arrivalDateTime, statusID,airplaneID, delayDepartTime, delayArrivalTime)  
 VALUES('5099','19-OCT-21 07:30:00 AM', '19-OCT-21 09:27:00 AM', 'D','AP998911', '19-OCT-21 07:50:00 AM','19-OCT-21 09:52:00 AM');
 INSERT INTO FlightSchedule(flightNumber,departDateTime, arrivalDateTime, statusID,airplaneID)  
 VALUES('3426','27-OCT-21 11:15:00 AM', '27-OCT-21 02:05:00 PM', 'O','AP239471');

--------COMMIT The Changes-------
COMMIT;