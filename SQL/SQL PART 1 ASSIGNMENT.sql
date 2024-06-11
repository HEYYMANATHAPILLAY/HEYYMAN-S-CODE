Create database ELibraryManagmentsystem

--UNF
--Table: Members

CREATE TABLE Members1(
	MemberID nvarchar(50) PRIMARY KEY,
	Membername nvarchar(50),
	Address nvarchar(50),
	City nvarchar(50),
	State nvarchar(50),
	ZipCode int,
	Gender nvarchar(50)
)
INSERT INTO Members1
(MemberID,Membername,Address,City,State,ZipCode,Gender)
VALUES
('E01','Heyymanathapillay','Bukit Jalil','Kuala Lumpur','Selangor',57000,'Male'),
('E02','Hemanthrajah','Puchong','Subang Jaya','Selangor',47560,'Male'),
('E03','Joshua','USJ 20','Subang Jaya','Selangor',47630,'Male'),
('E04','Darsyen','Desa Petaling','Kuala Lumpur','Selangor',57000,'Male')

--Table: Books

Create Table Books(
	BookID Nvarchar(50) Primary Key,
	Title Nvarchar(50),
	Description Nvarchar(50),
	DateBorrowed Date,
	DueDate Date,
	TagColour Nvarchar(50)
)

INSERT INTO Books
(BookID,Title,Description,DateBorrowed,DueDate,TagColour)
VALUES
('B01','Percy Jackson','ISBN-01-02','2022-05-10','2022-05-15','Red'),
('B02','Harry Potter','ISBN-02-03','2022-05-10','2022-05-15','Blue'),
('B03','Malaysiaku','ISBN-04-05','2022-05-10','2022-05-15','Yellow'),
('B04','Animals that are facing extinction','ISBN-01-06','2022-05-10','2022-05-15','Green')


--Table: Authors

CREATE TABLE Authors(
	AuthorID nvarchar(50) PRIMARY KEY,
	Authorname nvarchar(50)
)

INSERT INTO Authors
(AuthorID,Authorname)
VALUES
('F001','J.K. Rowling'),
('F002','Bindi Irwin'),
('F003','Rick Riordan'),
('F004','James May')

--Table: Publishers

Create Table Publishers(
	PublisherID Nvarchar(50) Primary Key,
	PublisherName Nvarchar(50)
)

INSERT INTO Publishers
(PublisherID,Publishername)
VALUES
('P001','Arnotts Publishing Company'),
('P002','New York Times'),
('P003','Ram publishing Company'),
('P004','Star Publishings Sdn. Bhd.')

--Table: Editions

Create Table Editions(
	EditionID Nvarchar(50) Primary Key,
	BookID Nvarchar(50) Foreign Key References Books(BookID),
	EditionNumber Nvarchar(50)
)

INSERT INTO Editions
(EditionID,BookID,EditionNumber)
VALUES
('E01','B01','ED3'),
('E02','B02','ED4'),
('E03','B03','ED7'),
('E04','B04','ED4')


--Table: Copies
CREATE TABLE Copies(
	CopyID nvarchar(50) PRIMARY KEY,
	BookID nvarchar(50) FOREIGN KEY REFERENCES Books(BookID),
	EditionID nvarchar(50) FOREIGN KEY REFERENCES Editions(EditionID),
	Status nvarchar(50)
)

INSERT INTO Copies
(CopyID,BookID,EditionID,Status)
VALUES
('E001','E01','ED3','Overdue'),
('E002','E02','ED2','Not due'),
('E003','E03','ED1','Due')

--Table: Tags

Create Table Tags1(
	TagID Nvarchar(50) Primary Key,
	TagName Nvarchar(50)
)

INSERT INTO Tags1
(TagID,TagName)
VALUES
('T01','James'),
('T02','Turner.JW'),
('T03','Peterson'),
('T04','Pearson')


--Table: Members_Contact_Numbers
Create Table Members_Contact_Numbers(
	MemberID Nvarchar(50), --(add PK,FK)
	ContactNumber Int
	PRIMARY KEY (MemberID, ContactNumber),
	FOREIGN KEY (MemberID) REFERENCES Members1(MemberID)
)

INSERT INTO Members_Contact_Numbers
(MemberID,ContactNumber)
VALUES
('E01',0123945678),
('E02',0145678976),
('E03',0165678976),
('E04',0116547687)


--Table: Members_Overdue_Payments
Create Table Members_Overdue_Payments(
	MemberID Nvarchar(50), --Add(PK,FK)
	BookID Nvarchar(50), --Add(PK,FK)
	PaymentDate Date,
	AmountDue decimal(10,2)
	PRIMARY KEY (MemberID, BookID),
	FOREIGN KEY (MemberID) REFERENCES Members1(MemberID),
	FOREIGN KEY (BookID) REFERENCES Books(BookID)
)

INSERT INTO Members_Overdue_Payments
(MemberID,BookID,PaymentDate,AmountDue)
VALUES
('E01','B01','2020-04-11',5.60),
('E02','B02','2020-05-21',10.00),
('E03','B03','2020-06-15',7.00),
('E04','B04','2020-07-17',8.00)


--Table: Members_Reservations
Create Table Members_Reservations(
	ReservationID Nvarchar(50) Primary Key,
	MemberID Nvarchar(50) Foreign Key References Members1(MemberID),
	BookID Nvarchar(50) Foreign Key References Books(BookID),
	ReservationDate Date
)

INSERT INTO Members_Reservations
(ReservationID,MemberID,BookID,ReservationDate)
VALUES
('R001','E01','B01','2022-05-12'),
('R002','E02','B02','2022-06-13'),
('R003','E03','B03','2022-08-15'),
('R003','E04','B04','2022-09-17')

Select*from Members1
Select*from Books
Select*from Authors
Select*from Publishers
Select*from Editions

Select*from Copies --INSERT ERROR
Select*from Tags1
Select*from Members_Contact_Numbers
Select*from Members_Overdue_Payments
select*from Members_Reservations --INSERT ERROR



--1NF

-- Table: Members
CREATE TABLE Members01 (
    MemberID Nvarchar(50) PRIMARY KEY,
    MemberName Nvarchar(50),
    Address Nvarchar(50),
    City NVARCHAR(50),
    State NVARCHAR(50),
    ZipCode INT,
    Gender NVARCHAR(50)
);

-- Table: MemberContactNumbers
CREATE TABLE MemberContactNumbers01 (
    ContactNumberID NVARCHAR(50) PRIMARY KEY,
    MemberID NVARCHAR(50),
    ContactNumber INT,
    FOREIGN KEY (MemberID) REFERENCES Members01(MemberID)
);

-- Table: MemberOverduePayments
CREATE TABLE MemberOverduePayments01 (
    PaymentID NVARCHAR(50) PRIMARY KEY,
    MemberID NVARCHAR(50),
	BookID NVARCHAR(50),
    PaymentDate DATE,
    AmountDue DECIMAL(10, 2),
    FOREIGN KEY (MemberID) REFERENCES Members01(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Table: MemberReservations
CREATE TABLE MemberReservations01 (
    ReservationID NVARCHAR(50) PRIMARY KEY,
    MemberID NVARCHAR(50),
    BookID NVARCHAR(50),
    ReservationDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members01(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Table: Books
CREATE TABLE Books01 (
    BookID NVARCHAR(50) PRIMARY KEY,
    Title NVARCHAR(50),
    Description NVARCHAR(50),
    DateBorrowed DATE,
    DueDate DATE,
    TagColor NVARCHAR(50)
);

-- Table: Authors
CREATE TABLE Authors01 (
    AuthorID NVARCHAR(50) PRIMARY KEY,
    AuthorName NVARCHAR(50)
);

-- Table: Publishers
CREATE TABLE Publishers01 (
    PublisherID NVARCHAR(50) PRIMARY KEY,
    PublisherName NVARCHAR(50)
);

-- Table: Copies
CREATE TABLE Copies01 (
    CopyID NVARCHAR(50) PRIMARY KEY,
    BookID NVARCHAR(50),
    EditionID NVARCHAR(50),
    Status NVARCHAR(50),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (EditionID) REFERENCES Editions(EditionID)
);

-- Table: Editions
CREATE TABLE Editions01 (
    EditionID NVARCHAR(50) PRIMARY KEY,
    BookID NVARCHAR(50),
    EditionNumber NVARCHAR(50),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Table: Tags
CREATE TABLE Tags01 (
    TagID NVARCHAR(50) PRIMARY KEY,
    TagName NVARCHAR(50)
);


INSERT INTO Members01
(MemberID,MemberName,Address,City,State,ZipCode,Gender)
VALUES
('E01','Darsyen','Desa Petaling','Kuala Lumpur','Selangor',57000,'Male'),
('E02','Hemanthrajah','Taman Mas','Puchong','Selangor',57000,'Male'),
('E03','Heyymanathapillay','Desa Petaling','Kuala Lumpur','Selangor',57000,'Male'),
('E04','Joshua','USJ 20','Subang Jaya','Selangor',47650,'Male')

INSERT INTO MemberContactNumbers01
(ContactNumberID,MemberID,ContactNumber)
VALUES
('E001','E01',0123945678),
('E002','E02',0145678976),
('E003','E03',0165678976),
('E004','E04',0116547687)

INSERT INTO MemberOverduePayments01
(PaymentID,MemberID,BookID,PaymentDate,AmountDue)
VALUES
('P01','E01','B01','2020-04-11',5.60),
('P02','E02','B02','2020-05-21',10.00),
('P03','E03','B03','2020-06-15',7.00),
('P04','E04','B04','2020-07-17',8.00)

INSERT INTO MemberReservations01
(ReservationID,MemberID,BookID,ReservationDate)
VALUES
('R001','E01','B01','2022-05-12'),
('R002','E02','B02','2022-06-13'),
('R003','E03','B03','2022-08-15'),
('R003','E04','B04','2022-09-17')

INSERT INTO Books01
(BookID,Title,Description,DateBorrowed,DueDate,TagColor)
VALUES
('B01','Percy Jackson','ISBN-01-02','2022-05-10','2022-05-15','Red'),
('B02','Harry Potter','ISBN-02-03','2022-05-10','2022-05-15','Blue'),
('B03','Malaysiaku','ISBN-04-05','2022-05-10','2022-05-15','Yellow'),
('B04','Animals that are facing extinction','ISBN-01-06','2022-05-10','2022-05-15','Green')

INSERT INTO Authors01
(AuthorID,Authorname)
VALUES
('A001','Rick Riordan'),
('A002','J.K.Rowling'),
('A003','Don Patrick'),
('A004','James Lopez')

INSERT INTO Publishers01
(PublisherID,Publishername)
VALUES
('P001','Arnotts Publishing Company'),
('P002','New York Times'),
('P003','Ram publishing Company'),
('P004','Star Publishings Sdn. Bhd.')

INSERT INTO Copies01
(CopyID,BookID,EditionID,Status)
VALUES
('C01','B01','E001','Due'),
('C02','B02','E002','Overdue'),
('C03','B03','E003','Not due'),
('C04','B04','E004','Due')

INSERT INTO Editions01
(EditionID,BookID,EditionNumber)
VALUES
('E01','B01','ED3'),
('E02','B02','ED4'),
('E03','B03','ED7'),
('E04','B04','ED4')

INSERT INTO Tags01
(TagID,TagName)
VALUES
('T01','James'),
('T02','Turner.JW'),
('T03','Peterson'),
('T04','Pearson')

--2NF

-- Table: Members
CREATE TABLE Members001 (
    MemberID NVARCHAR(50) PRIMARY KEY,
    MemberName NVARCHAR(50),
    Address NVARCHAR(50),
    City NVARCHAR(50),
    State NVARCHAR(50),
    ZipCode INT,
    Gender NVARCHAR(50)
)

-- Table: MemberContactNumbers
CREATE TABLE MemberContactNumbers001 (
    ContactNumberID NVARCHAR(50) PRIMARY KEY,
    MemberID NVARCHAR(50),
    ContactNumber INT,
    FOREIGN KEY (MemberID) REFERENCES Members001(MemberID)
)

-- Table: MemberOverduePayments
CREATE TABLE MemberOverduePayments001 (
    PaymentID NVARCHAR(50) PRIMARY KEY,
    MemberID NVARCHAR(50),
    BookID NVARCHAR(50),
    PaymentDate DATE,
    AmountDue DECIMAL(10, 2),
    FOREIGN KEY (MemberID) REFERENCES Members001(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
)

-- Table: MemberReservations
CREATE TABLE MemberReservations001 (
    ReservationID NVARCHAR(50) PRIMARY KEY,
    MemberID NVARCHAR(50),
    BookID NVARCHAR(50),
    ReservationDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members001(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
)

-- Table: Books
CREATE TABLE Books001 (
    BookID NVARCHAR(50) PRIMARY KEY,
    Title NVARCHAR(50),
    Description NVARCHAR(50),
    DateBorrowed DATE,
    DueDate DATE,
    TagColor NVARCHAR(50),
    AuthorID NVARCHAR(50),
    PublisherID NVARCHAR(50),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
)

-- Table: Authors
CREATE TABLE Authors001 (
    AuthorID NVARCHAR(50) PRIMARY KEY,
    AuthorName NVARCHAR(50)
)

-- Table: Publishers
CREATE TABLE Publishers001 (
    PublisherID NVARCHAR(50) PRIMARY KEY,
    PublisherName NVARCHAR(50)
)

-- Table: Copies
CREATE TABLE Copies001 (
    CopyID NVARCHAR(50) PRIMARY KEY,
    BookID NVARCHAR(50),
    EditionID NVARCHAR(50),
    Status NVARCHAR(50),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (EditionID) REFERENCES Editions(EditionID)
)

-- Table: Editions
CREATE TABLE Editions001 (
    EditionID NVARCHAR(50) PRIMARY KEY,
    BookID NVARCHAR(50),
    EditionNumber NVARCHAR(50),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
)

-- Table: Tags
CREATE TABLE Tags001 (
    TagID NVARCHAR(50) PRIMARY KEY,
    TagName NVARCHAR(50)
)


INSERT INTO Members001
(MemberID,MemberName,Address,City,State,ZipCode,Gender)
VALUES
('E01','Darsyen','Desa Petaling','Kuala Lumpur','Selangor',57000,'Male'),
('E02','Hemanthrajah','Taman Mas','Puchong','Selangor',57000,'Male'),
('E03','Heyymanathapillay','Desa Petaling','Kuala Lumpur','Selangor',57000,'Male'),
('E04','Joshua','USJ 20','Subang Jaya','Selangor',47650,'Male')


INSERT INTO MemberContactNumbers001
(ContactNumberID,MemberID,ContactNumber)
VALUES
('E001','E01',0123945678),
('E002','E02',0145678976),
('E003','E03',0165678976),
('E004','E04',0116547687)


INSERT INTO MemberOverduePayments001
(PaymentID,MemberID,BookID,PaymentDate,AmountDue)
VALUES
('P01','E01','B01','2020-04-11',5.60),
('P02','E02','B02','2020-05-21',10.00),
('P03','E03','B03','2020-06-15',7.00),
('P04','E04','B04','2020-07-17',8.00)


INSERT INTO MemberReservations001
(ReservationID,MemberID,BookID,ReservationDate)
VALUES
('R001','E01','B01','2022-05-12'),
('R002','E02','B02','2022-06-13'),
('R003','E03','B03','2022-08-15'),
('R003','E04','B04','2022-09-17')


INSERT INTO Books001
(BookID,Title,Description,DateBorrowed,DueDate,TagColor)
VALUES
('B01','Percy Jackson','ISBN-01-02','2022-05-10','2022-05-15','Red'),
('B02','Harry Potter','ISBN-02-03','2022-05-10','2022-05-15','Blue'),
('B03','Malaysiaku','ISBN-04-05','2022-05-10','2022-05-15','Yellow'),
('B04','Animals that are facing extinction','ISBN-01-06','2022-05-10','2022-05-15','Green')


INSERT INTO Authors001
(AuthorID,Authorname)
VALUES
('A001','Rick Riordan'),
('A002','J.K.Rowling'),
('A003','Don Patrick'),
('A004','James Lopez')


INSERT INTO Copies001
(CopyID,BookID,EditionID,Status)
VALUES
('C01','B01','E001','Due'),
('C02','B02','E002','Overdue'),
('C03','B03','E003','Not due'),
('C04','B04','E004','Due')


INSERT INTO Editions001
(EditionID,BookID,EditionNumber)
VALUES
('E01','B01','ED3'),
('E02','B02','ED4'),
('E03','B03','ED7'),
('E04','B04','ED4')


INSERT INTO Tags001
(TagID,TagName)
VALUES
('T01','James'),
('T02','Turner.JW'),
('T03','Peterson'),
('T04','Pearson')


--3NF


-- Table: MemberContactNumbers
CREATE TABLE MemberContactNumbers0001 (
    ContactNumberID NVARCHAR(50) PRIMARY KEY,
    MemberID NVARCHAR(50),
    ContactNumber NVARCHAR(50),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Table: MemberOverduePayments
CREATE TABLE MemberOverduePayments0001 (
    PaymentID NVARCHAR(50) PRIMARY KEY,
    MemberID NVARCHAR(50),
    BookID NVARCHAR(50),
    PaymentDate DATE,
    AmountDue DECIMAL(10, 2),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Table: MemberReservations
CREATE TABLE MemberReservations0001 (
    ReservationID NVARCHAR(50) PRIMARY KEY,
    MemberID NVARCHAR(50),
    BookID NVARCHAR(50),
    ReservationDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Table: States
CREATE TABLE States0001 (
    StateID NVARCHAR(50) PRIMARY KEY,
    StateName NVARCHAR(50)
);

-- Table: Cities
CREATE TABLE Cities0001 (
    CityID NVARCHAR(50) PRIMARY KEY,
    CityName NVARCHAR(50),
    StateID NVARCHAR(50),  -- Changed to StateID, which is a foreign key to States table
    FOREIGN KEY (StateID) REFERENCES States0001(StateID)
);


-- Table: ZipCodes
CREATE TABLE ZipCodes0001 (
    ZipCodeID NVARCHAR(50) PRIMARY KEY,
    ZipCode NVARCHAR(50),
    CityID NVARCHAR(50),  -- Changed to CityID, which is a foreign key to Cities table
    FOREIGN KEY (CityID) REFERENCES Cities0001(CityID)
);

-- Table: Members
CREATE TABLE Members0001 (
    MemberID NVARCHAR(50) PRIMARY KEY,
    MemberName NVARCHAR(50),
    Address NVARCHAR(50),
    ZipCodeID NVARCHAR(50),  -- Changed to ZipCodeID, which is a foreign key to ZipCodes table
    Gender NVARCHAR(50),
    FOREIGN KEY (ZipCodeID) REFERENCES ZipCodes0001(ZipCodeID)
);

-- Table: Books
CREATE TABLE Books0001 (
    BookID NVARCHAR(50) PRIMARY KEY,
    Title NVARCHAR(100),
    Description TEXT,
    DateBorrowed DATE,
    DueDate DATE,
    TagColor NVARCHAR(50),
    AuthorID NVARCHAR(50),
    PublisherID NVARCHAR(50),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

-- Table: Authors
CREATE TABLE Authors0001 (
    AuthorID NVARCHAR(50) PRIMARY KEY,
    AuthorName NVARCHAR(50)
);

-- Table: Publishers
CREATE TABLE Publishers0001 (
    PublisherID NVARCHAR(50) PRIMARY KEY,
    PublisherName NVARCHAR(50)
);

-- Table: Copies
CREATE TABLE Copies0001 (
    CopyID NVARCHAR(50) PRIMARY KEY,
    BookID NVARCHAR(50),
    EditionID NVARCHAR(50),
    Status NVARCHAR(50),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (EditionID) REFERENCES Editions(EditionID)
);

-- Table: Editions
CREATE TABLE Editions0001 (
    EditionID NVARCHAR(50) PRIMARY KEY,
    BookID NVARCHAR(50),
    EditionNumber NVARCHAR(50),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Table: Tags
CREATE TABLE Tags0001 (
    TagID NVARCHAR(50) PRIMARY KEY,
    TagName NVARCHAR(50)
);

INSERT INTO MemberContactNumbers0001
(ContactNumberID,MemberID,ContactNumber)
VALUES
('E001','E01',0123945678),
('E002','E02',0145678976),
('E003','E03',0165678976),
('E004','E04',0116547687)


INSERT INTO MemberOverduePayments0001
(PaymentID,MemberID,BookID,PaymentDate,AmountDue)
VALUES
('P01','E01','B01','2020-04-11',5.60),
('P02','E02','B02','2020-05-21',10.00),
('P03','E03','B03','2020-06-15',7.00),
('P04','E04','B04','2020-07-17',8.00)


INSERT INTO MemberReservations0001
(ReservationID,MemberID,BookID,ReservationDate)
VALUES
('R001','E01','B01','2022-05-12'),
('R002','E02','B02','2022-06-13'),
('R003','E03','B03','2022-08-15'),
('R003','E04','B04','2022-09-17')


INSERT INTO States0001
(StateID,StateName)
VALUES
('S01','Selangor'),
('S02','Perak'),
('S03','Johor'),
('S04','Pinang')

INSERT INTO Cities0001
(CityID,CityName,StateID)
VALUES
('C01','Selangor','S01'),
('C02','Perak', 'S02'),
('C03','Johor', 'S03'),
('C04','Pinang','S04')

INSERT INTO ZipCodes0001
(ZipCodeID,ZipCode,CityID)
VALUES
('ZC1',47630 ,'C01'),
('ZC2',65060 ,'C02'),
('ZC3',56930, 'C03'),
('ZC4',56444 ,'C04')

INSERT INTO Members0001
(MemberID,MemberName,Address,ZipCodeID,Gender)
VALUES
('E01','Darsyen','Desa Petaling','Kuala Lumpur','Selangor',57000,'Male'),
('E02','Hemanthrajah','Taman Mas','Puchong','Selangor',57000,'Male'),
('E03','Heyymanathapillay','Desa Petaling','Kuala Lumpur','Selangor',57000,'Male'),
('E04','Joshua','USJ 20','Subang Jaya','Selangor',47650,'Male')

INSERT INTO Books0001
(BookID,Title,Description,DateBorrowed,DueDate,TagColor)
VALUES
('B01','Percy Jackson','ISBN-01-02','2022-05-10','2022-05-15','Red'),
('B02','Harry Potter','ISBN-02-03','2022-05-10','2022-05-15','Blue'),
('B03','Malaysiaku','ISBN-04-05','2022-05-10','2022-05-15','Yellow'),
('B04','Animals that are facing extinction','ISBN-01-06','2022-05-10','2022-05-15','Green')


INSERT INTO Authors0001
(AuthorID,Authorname)
VALUES
('A001','Rick Riordan'),
('A002','J.K.Rowling'),
('A003','Don Patrick'),
('A004','James Lopez')


INSERT INTO Publishers0001
(PublisherID,Publishername)
VALUES
('P001','Arnotts Publishing Company'),
('P002','New York Times'),
('P003','Ram publishing Company'),
('P004','Star Publishings Sdn. Bhd.')


INSERT INTO Copies0001
(CopyID,BookID,EditionID,Status)
VALUES
('C01','B01','E001','Due'),
('C02','B02','E002','Overdue'),
('C03','B03','E003','Not due'),
('C04','B04','E004','Due')


INSERT INTO Editions0001
(EditionID,BookID,EditionNumber)
VALUES
('E01','B01','ED3'),
('E02','B02','ED4'),
('E03','B03','ED7'),
('E04','B04','ED4')


INSERT INTO Tags0001
(TagID,TagName)
VALUES
('T01','James'),
('T02','Turner.JW'),
('T03','Peterson'),
('T04','Pearson')
