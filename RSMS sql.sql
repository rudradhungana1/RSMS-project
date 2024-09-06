--Drop Types 
DROP TYPE AddressType FORCE;
DROP TYPE NestedAddressType FORCE;
DROP TYPE OwnerType FORCE;
DROP TYPE AgentType FORCE;
DROP TYPE ClientType FORCE;
DROP TYPE SellType FORCE;
DROP TYPE ResidentialType FORCE;
DROP TYPE CommercialType FORCE;
DROP TYPE RentalInfoType FORCE;
DROP TYPE PropertyType FORCE;



--Drop Tables
DROP TABLE PropertyTable CASCADE CONSTRAINTS;
DROP TABLE OwnerTable CASCADE CONSTRAINTS;
DROP TABLE AgentTable  CASCADE CONSTRAINTS;
DROP TABLE SellTable CASCADE CONSTRAINTS;
DROP TABLE ClientTable CASCADE CONSTRAINTS;
DROP TABLE RentalInfoTable CASCADE CONSTRAINTS;


---------------------------------Creating Type------------
CREATE TYPE AddressType AS OBJECT (
    state       VARCHAR2(20),
    district    VARCHAR2(20),
    municipality VARCHAR2(20),
     ward_no     VARCHAR2(5),
    MEMBER FUNCTION get_full_address RETURN VARCHAR2
);
/
commit;
CREATE  TYPE BODY AddressType AS
	MEMBER FUNCTION get_full_address RETURN VARCHAR2 IS
	BEGIN
		RETURN state||' '||district||' '||municipality||' '||ward_no;
	END;
END;
/

CREATE TYPE NestedAddressType AS TABLE OF AddressType;

CREATE TYPE OwnerType AS OBJECT (
    owner_id    NUMBER,
     owner_name       VARCHAR2(50),
    owner_address     NestedAddressType,
    phone_number VARCHAR2(20),
    email       VARCHAR2(100)
)NOT FINAL;

CREATE TYPE PropertyType AS OBJECT (
    property_id NUMBER,
    property_address     NestedAddressType,
    area        VARCHAR2(10),
    price       NUMBER(10,2),
    status      VARCHAR2(10),
    property_description VARCHAR2(500),
    property_category   VARCHAR2(20),
     owner_id      NUMBER
    ) NOT FINAL;
    
CREATE TYPE AgentType AS OBJECT (
    agent_id    NUMBER,
     agent_name      VARCHAR2(50),
    agent_address     NestedAddressType,
    phone_number VARCHAR2(20),
    email       VARCHAR2(50),
   property_sold Number
)NOT FINAL;

CREATE TYPE ResidentialType UNDER PropertyType (
    num_bedroom NUMBER(2),
    num_bathroom NUMBER(2),
    pool CHAR(3),
    yard CHAR(3)
);

CREATE TYPE CommercialType UNDER PropertyType (
    square_feet NUMBER(7,2)
);

CREATE TYPE ClientType AS OBJECT (
    client_id   NUMBER,
     Client_name       VARCHAR2(50),
    client_address     NestedAddressType,
    phone_number    VARCHAR2(20),
    email       VARCHAR2(50)
    )NOT FINAL;
    
CREATE TYPE SellType AS OBJECT (
    sell_id     NUMBER,
    price       NUMBER(10),
    sell_date        TIMESTAMP,
    client_id      NUMBER,
    property_id    NUMBER,
    agent_id       NUMBER
);

CREATE TYPE RentalInfoType AS OBJECT (
    rent_id     NUMBER,
    price       NUMBER(10,2),
    start_date  TIMESTAMP,
    end_date    TIMESTAMP,
    property_id  NUMBER,
     client_id      NUMBER,
    renting_agent_id  NUMBER
)NOT FINAL;


-----Create Table
CREATE TABLE OwnerTable OF OwnerType (
    owner_id    PRIMARY KEY
  ) NESTED TABLE owner_address STORE AS NestedAddressTable;
  
   
CREATE TABLE PropertyTable OF PropertyType (
    property_id NOT NULL PRIMARY KEY,  
    area        NOT NULL,
    price       NOT NULL,
    status      NOT NULL,
    property_description NOT NULL,
    property_category NOT NULL,
    CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES OwnerTable(owner_id))
    
    NESTED TABLE property_address STORE AS NestedPropertyAddressTable;
        
        
  CREATE TABLE AgentTable OF AgentType(
    agent_id    NOT NULL PRIMARY KEY,
    agent_name   NOT NULL,
    phone_number NOT NULL,
    email       NOT NULL UNIQUE,
    CONSTRAINT fk_propertydetail FOREIGN KEY (property_sold) REFERENCES PropertyTable(property_id)
)NESTED TABLE agent_address STORE AS NestedAgentAddressTable;

        
CREATE TABLE ClientTable OF ClientType(
    client_id   NOT NULL PRIMARY KEY,
    client_name   NOT NULL,
    phone_number NOT NULL,
    email       NOT NULL UNIQUE
)NESTED TABLE client_address STORE AS NestedclientAddressTable;


CREATE TABLE SellTable OF SellType (
    sell_id         NOT NULL PRIMARY KEY,
    price           NOT NULL,
    sell_date       NOT NULL,
     client_id      NOT NULL,
    property_id    NOT NULL,
    agent_id       NOT NULL,
     CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES PropertyTable(property_id),
    CONSTRAINT fk_agent FOREIGN KEY (agent_id)  REFERENCES AgentTable(agent_id),
      CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES ClientTable(client_id));


CREATE TABLE RentalInfoTable OF RentalInfoType (
    rent_id         NOT NULL PRIMARY KEY,
    price           NOT NULL,
    start_date      NOT NULL,
    end_date        NOT NULL,
    property_id  NOT NULL,
     client_id     NOT NULL,
    renting_agent_id NOT NULL,
    CONSTRAINT fk_rented_property FOREIGN KEY (property_id) REFERENCES PropertyTable(property_id),
    CONSTRAINT fk_rentting_agent FOREIGN KEY (renting_agent_id)  REFERENCES AgentTable(agent_id),
      CONSTRAINT fk_renting_client FOREIGN KEY (client_id) REFERENCES ClientTable(client_id));

--- Creating timestamp Trigger for rentaltable
CREATE TRIGGER RentalStartTrigger
  BEFORE INSERT ON RentalInfoTable
  FOR EACH ROW
BEGIN
  :new.start_date := SYSTIMESTAMP;
END;


------------------Inserting Values into the Tables

--Inserting values into Owner Table
INSERT INTO OwnerTable(owner_id,owner_name,owner_address,phone_number,email) VALUES (1,'Ramesh Thakur',NestedAddressType
(),'9845891234','rameshth@gmail.com');
INSERT INTO TABLE(SELECT o.owner_address FROM OwnerTable o WHERE o.owner_id = 1) VALUES ('Bagmati','kathmandu','Kirtipur','08');
INSERT INTO TABLE(SELECT o.owner_address FROM OwnerTable o WHERE o.owner_id = 1) VALUES ('Bagmati','Kathmandu','kathmandu','09');

INSERT INTO OwnerTable(owner_id,owner_name,owner_address,phone_number,email) VALUES (2,'Rudra Dhungana',NestedAddressType
(),'98453366441','rudradhungana@gmail.com');
INSERT INTO TABLE(SELECT o.owner_address FROM OwnerTable o WHERE o.owner_id = 2) VALUES ('Bagmati','Kathmandu','Kageshowri','03');
INSERT INTO TABLE(SELECT o.owner_address FROM OwnerTable o WHERE o.owner_id = 2) VALUES ('Bagmati','Kathmandu','Kirtipur','07');

INSERT INTO OwnerTable(owner_id,owner_name,owner_address,phone_number,email) VALUES (3,'Rudra Thapa',NestedAddressType
(),'9845398451','thaparudra@gmail.com');
INSERT INTO TABLE(SELECT o.owner_address FROM OwnerTable o WHERE o.owner_id = 3) VALUES ('Bagmati','Lalitpur','Godawari','07');
INSERT INTO TABLE(SELECT o.owner_address FROM OwnerTable o WHERE o.owner_id = 3) VALUES ('Bagmati','Lalitpur','Mahalaxmi','04');

INSERT INTO OwnerTable(owner_id,owner_name,owner_address,phone_number,email) VALUES (4,'Soniya Magar',NestedAddressType
(),'9789145261','soniyamagar15@gmail.com');
INSERT INTO TABLE(SELECT o.owner_address FROM OwnerTable o WHERE o.owner_id = 4) VALUES ('Bagmati','Chitwan','Bharatpur','19');
INSERT INTO TABLE(SELECT o.owner_address FROM OwnerTable o WHERE o.owner_id = 4) VALUES ('Bagmati','Lalitpur','Mahalaxmi','04');

INSERT INTO OwnerTable(owner_id,owner_name,owner_address,phone_number,email) VALUES (5,'Soni Magar',NestedAddressType
(),'9789145278','sonimagar15@gmail.com');
INSERT INTO TABLE(SELECT o.owner_address FROM OwnerTable o WHERE o.owner_id = 5) VALUES ('Bagmati','Bhaktapur', 'Suryabinayak','8');
INSERT INTO TABLE(SELECT o.owner_address FROM OwnerTable o WHERE o.owner_id = 5) VALUES ('Bagmati','Bhaktapur', 'Suryabinayak','7');

INSERT INTO OwnerTable(owner_id,owner_name,owner_address,phone_number,email) VALUES (6,'Sonita Marasini',NestedAddressType
(),'9789149978','sonita85@gmail.com');
INSERT INTO TABLE(SELECT o.owner_address FROM OwnerTable o WHERE o.owner_id = 6) VALUES ('Bagmati','Dhading', 'Galchi','7');
INSERT INTO TABLE(SELECT o.owner_address FROM OwnerTable o WHERE o.owner_id = 6) VALUES ('Bagmati','Kathmandu', 'Kageshowri','9');


SELECT * FROM OwnerTable;

---------Inserting Values into Property Table----

INSERT INTO PropertyTable Values(ResidentialType(1001,NestedAddressType(),'2000 sqft',15000000,'Available',
'A luxurious apartment with a view of Central Park','Apartment',1,3,2,'YES','NO'));
INSERT INTO TABLE (SELECT p.property_address FROM PropertyTable p WHERE p.property_id=1001) VALUES ('Gandaki','Tanahu', 'Byas','21');

INSERT INTO PropertyTable Values(ResidentialType(1002,NestedAddressType(),'1800 sqft',1500000,'Sold',
'A luxurious apartment with a view River and park','Apartment',2,3,2,'NO','NO'));
INSERT INTO TABLE (SELECT p.property_address FROM PropertyTable p WHERE p.property_id=1002) VALUES ('Bagmati','Kathmandu', 'Kathmandu','07');
    
INSERT INTO PropertyTable Values(CommercialType(1003,NestedAddressType(),'1000 sqft',150000,'Sold',
'Peaceful work environment','Office',4,1000));
INSERT INTO TABLE (SELECT p.property_address FROM PropertyTable p WHERE p.property_id=1003) VALUES ('Bagmati','Kathmandu', 'Kageshowri','17');  

INSERT INTO PropertyTable Values(CommercialType(1004,NestedAddressType(),'800 sqft',128000,'Available',
'Parking space available','Office',3,800));
INSERT INTO TABLE (SELECT p.property_address FROM PropertyTable p WHERE p.property_id=1004) VALUES ('Bagmati','Bhaktapur', 'Suryabinayak','14');  

INSERT INTO PropertyTable Values(CommercialType(1005,NestedAddressType(),'1111 sqft',12000000,'Sold',
'Parking space available','Building',5,1111));
INSERT INTO TABLE (SELECT p.property_address FROM PropertyTable p WHERE p.property_id=1005) VALUES ('Bagmati','Bhaktapur', 'Suryabinayak','8');

INSERT INTO PropertyTable Values(ResidentialType(1006,NestedAddressType(),'1350 sqft',13000000,'Available',
'A luxurious apartment with gym','Apartment',3,3,2,'YES','NO'));
INSERT INTO TABLE (SELECT p.property_address FROM PropertyTable p WHERE p.property_id=1006) VALUES ('Gandaki','Kaski', 'Pokhara','19');

INSERT INTO PropertyTable Values(ResidentialType(1007,NestedAddressType(),'1400 sqft',13900000,'Sold',
'A luxurious apartment with gym','Apartment',4,3,2,'YES','NO'));
INSERT INTO TABLE (SELECT p.property_address FROM PropertyTable p WHERE p.property_id=1007) VALUES ('Bagmati','Lalitpur', 'Godawari','19');

INSERT INTO PropertyTable Values(ResidentialType(1008,NestedAddressType(),'1355 sqft',2410000,'Sold',
'A luxurious apartment with a view River and park','Apartment',3,3,2,'Yes','Yes'));
INSERT INTO TABLE (SELECT p.property_address FROM PropertyTable p WHERE p.property_id=1008) VALUES ('Bagmati','Kathmandu', 'Kathmandu','07');



SELECT * FROM PropertyTable;

--Inserting Values into Agent Table

INSERT INTO AgentTable (agent_id, agent_name,agent_address,phone_number,email,property_sold) VALUES(1, 'Samantha Lama', NestedAddressType(), '9845658912', 'samantha.lama@example.com', NULL);
    INSERT INTO TABLE (SELECT a.agent_address FROM AgentTable a WHERE a.agent_id=1) VALUES ('Bagmati', 'Sindupalchowk', 'Sangagadi', '13');
 INSERT INTO TABLE (SELECT a.agent_address FROM AgentTable a WHERE a.agent_id=1) VALUES ('Bagmati', 'Kathmandu', 'Kathmandu', '03');

INSERT INTO AgentTable (agent_id, agent_name,agent_address,phone_number,email,property_sold) VALUES(2, 'Sanjog Bhandari', NestedAddressType(), '9850356214', 'sanjogbhandari98@gmail.com', 1002);
    INSERT INTO TABLE (SELECT a.agent_address FROM AgentTable a WHERE a.agent_id=2) VALUES ('Gandaki', 'Kaski', 'Pokhara', '19');
    INSERT INTO TABLE (SELECT a.agent_address FROM AgentTable a WHERE a.agent_id=2) VALUES ('Bagmati','Bhaktapur', 'Suryabinayak','07');


INSERT INTO AgentTable (agent_id, agent_name,agent_address,phone_number,email,property_sold) VALUES(3, 'Sangita ghimire', NestedAddressType(), '9850359654', 'sangeetame@gmail.com', 1004);
    INSERT INTO TABLE (SELECT a.agent_address FROM AgentTable a WHERE a.agent_id=3) VALUES ('Bagmati', 'Dhulikhel', 'Kavre', '08');
     INSERT INTO TABLE (SELECT a.agent_address FROM AgentTable a WHERE a.agent_id=3)  VALUES ('Bagmati','Bhaktapur', 'Suryabinayak','05');
     
INSERT INTO AgentTable (agent_id, agent_name,agent_address,phone_number,email,property_sold) VALUES(4, 'Sannani ghimire', NestedAddressType(), '98685520156', 'sannani1986@gmail.com', 1005);
    INSERT INTO TABLE (SELECT a.agent_address FROM AgentTable a WHERE a.agent_id=4) VALUES ('Bagmati', 'Sindupalchowk', 'Barhabise', '02');
    INSERT INTO TABLE (SELECT a.agent_address FROM AgentTable a WHERE a.agent_id=4) VALUES ('Bagmati','Lalitpur','Mahalaxmi','03');
    
    SELECT * FROM AgentTable;
    
    
--------Inserting Data into Cllient Table---

INSERT INTO ClientTable(client_id,client_name,client_address,phone_number,email) VALUES (101,'Ram Babu Thakur',NestedAddressType
(),'9802361400','baburam@gmail.com');
INSERT INTO TABLE(SELECT c.client_address FROM ClientTable c WHERE c.client_id = 101) VALUES ('Bagmati','Kathmandu','Kirtipur','08');
INSERT INTO TABLE(SELECT c.client_address FROM ClientTable c WHERE c.client_id = 101) VALUES ('Bagmati','Kathmandu','kathmandu','09');

INSERT INTO ClientTable(client_id,client_name,client_address,phone_number,email) VALUES (102,'Kushma Dhungana',NestedAddressType
(),'9898563211','kushmadhungana67@gmail.com');
INSERT INTO TABLE(SELECT c.client_address FROM ClientTable c WHERE c.client_id = 102) VALUES ('Koshi','Dharan','Dharan','05');
INSERT INTO TABLE(SELECT c.client_address FROM ClientTable c WHERE c.client_id = 102) VALUES ('Bagmati','Kathmandu','kathmandu','07');

INSERT INTO ClientTable(client_id,client_name,client_address,phone_number,email) VALUES (103,'Anil Acharya',NestedAddressType
(),'9789632481','acharyaanil2@gmail.com');
INSERT INTO TABLE(SELECT c.client_address FROM ClientTable c WHERE c.client_id = 103) VALUES ('Bagmati','chitwan','manakamana','23');
INSERT INTO TABLE(SELECT c.client_address FROM ClientTable c WHERE c.client_id = 103)  VALUES ('Bagmati','Lalitpur','Mahalaxmi','03');

INSERT INTO ClientTable(client_id,client_name,client_address,phone_number,email) VALUES (104,'Ananta Yadav',NestedAddressType
(),'9845215658','yadavananta183@gmail.com');
INSERT INTO TABLE(SELECT c.client_address FROM ClientTable c WHERE c.client_id = 104) VALUES ('Bagmati','chitwan','Ratna Nagar','20');
INSERT INTO TABLE(SELECT c.client_address FROM ClientTable c WHERE c.client_id = 104) VALUES ('Bagmati','Bhaktapur','Thimi','09');

SELECT * FROM ClientTable;

----------------Inserting Data into Sell Table---

INSERT INTO SellTable (sell_id, price, sell_date, client_id, property_id, agent_id) 
VALUES (1, 1200000, '15-Feb-2023 10:30:00', 101, 1005,4 );

INSERT INTO SellTable (sell_id, price, sell_date, client_id, property_id, agent_id) 
VALUES (2, 1280000, '2-Jan-2023 10:30:00', 102, 1004,3 );

INSERT INTO SellTable (sell_id, price, sell_date, client_id, property_id, agent_id) 
VALUES (3, 1500000, '18-feb-2023 10:30:00', 102, 1002,2 );

INSERT INTO SellTable (sell_id, price, sell_date, client_id, property_id, agent_id) 
VALUES (4, 13900000, '1-jan-2023 10:30:00', 103, 1007,2 );

INSERT INTO SellTable (sell_id, price, sell_date, client_id, property_id, agent_id) 
VALUES (5, 2410000, '15-march-2023 10:30:00', 104, 1008,3 );

SELECT * FROM SellTable;

--------Inserting Data Into Rentalinfo Table----

INSERT INTO RentalInfoTable (rent_id, price, start_date, end_date, property_id, client_id, renting_agent_id)
VALUES (1, 1700000, '15-march-2023 10:30:00', '16-march-2024 10:30:00', 1002, 103, 1);

INSERT INTO RentalInfoTable (rent_id, price, start_date, end_date, property_id, client_id, renting_agent_id)
VALUES (2, 150000, '15-march-2023 10:30:00', '16-Oct-2024 10:30:00', 1001, 104, 1);


INSERT INTO RentalInfoTable (rent_id, price, start_date, end_date, property_id, client_id, renting_agent_id)
VALUES (3, 130000, '15-march-2023 10:30:00', '16-Oct-2024 10:30:00', 1003, 104, 2);

SELECT * FROM RentalInfoTable;


-----------Join------------------------------

SELECT p.property_id, p.property_category, p.price, s.sell_date, c.client_name, o.owner_name, a.agent_name
FROM PropertyTable p
INNER JOIN SellTable s ON p.property_id = s.property_id
INNER JOIN ClientTable c ON s.client_id = c.client_id
INNER JOIN OwnerTable o ON p.owner_id = o.owner_id
INNER JOIN AgentTable a ON s.agent_id = a.agent_id
WHERE a.agent_name = 'Sangita ghimire';

--------------Union---------------

SELECT state, district, municipality, ward_no FROM (
  SELECT a.state, a.district, a.municipality, a.ward_no
  FROM OwnerTable o, TABLE(o.owner_address) a
  UNION
  SELECT a.state, a.district, a.municipality, a.ward_no
  FROM AgentTable ag, TABLE(ag.agent_address) a
) t
ORDER BY state, district, municipality, ward_no;


--------------------Nested--------

SELECT o.owner_name, o.email, o.phone_number, a.state, a.municipality, a.ward_no
FROM OwnerTable o,  TABLE(o.owner_address) a
WHERE EXISTS (
  SELECT 1
  FROM PropertyTable p
  WHERE p.owner_id = o.owner_id AND p.property_category = 'Apartment' 
);


------------------Timestamp---------

SELECT
 at.sell_id,
 at.sell_date,
 ( sysdate - at.sell_date ),
 EXTRACT(DAY FROM(sysdate -
at.sell_date)) AS daysuptonow
FROM
 SellTable at
WHERE
 EXTRACT(DAY FROM(sysdate -
at.sell_date)) < 50;


--------------Partition----------

SELECT
  SUM(price) AS total_sale,
  MAX(price) AS max_price,
  ROUND(AVG(price), 2) AS avg_price
FROM
  SellTable
WHERE
  sell_date >= TO_DATE('01-JAN-2023 00:00:00', 'DD-MON-YYYY HH24:MI:SS')
  AND sell_date <= TO_DATE('31-MAR-2023 23:59:59', 'DD-MON-YYYY HH24:MI:SS')
  AND agent_id = 3;








