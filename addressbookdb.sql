---uc1
create database AddressBookService;

USE AddressBookService;
--uc2
CREATE TABLE addressbook(
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(20) NOT NULL,
    state VARCHAR(20) NOT NULL,
    zip INT NOT NULL,
    phone_no VARCHAR(15) NOT NULL,
    email VARCHAR(50) NOT NULL,
);
--uc3
--Insert data
INSERT INTO addressbook (first_name,last_name,address,city,state,zip,phone_no,email)
    VALUES('Vladimir','Putin','3/40, Broadway Street','Moscow','Narnia',989001,'2354618524','v.putin@gmail.com'),
        ('Sherlock','Holmes','Baker Street','London','England',567897,'7654874','sherlocked@gmail.com');
--uc4
--Edit existinng contact using name
UPDATE addressbook SET zip=786532 
    WHERE first_name='Sherlock' AND last_name='Holmes';
SELECT * FROM addressbook;

--uc5
--Delete contact using person name
DELETE FROM addressbook WHERE first_name='Vladimir' AND last_name='Putin';
SELECT * FROM addressbook;

--uc6
--Retrieve a person from city or state
SELECT first_name,last_name FROM addressbook 
    WHERE city='london' OR  state='Las Angeles';

--uc7
--Count of address book by city and state
SELECT COUNT(city) AS COUNT_OF_ADDRESS_BOOK
    FROM addressbook WHERE city='london' AND state='england';

--UC8
--RETRIEVE ENTRIES ALPHABETICALLY BY NAME FOR A CITY
INSERT INTO addressbook (first_name,last_name,address,city,state,zip,phone_no,email)
    VALUES('Vladimir','Putina','3/40 Broadway Street','Moscow','Narnia',45001,'235461','v.putin@gmail.com'),
            ('Jake','Peralta','99 Precinct','New York','USA',25679,'911','j.pera@gmail.com');
SELECT * FROM addressbook;
INSERT INTO addressbook (first_name,last_name,address,city,state,zip,phone_no,email)
    VALUES('keya','lutina','yenyen','Hiroshima','japan',450981,'239871','ke.lut@gmail.com');
INSERT INTO addressbook (first_name,last_name,address,city,state,zip,phone_no,email)
    VALUES('rosa','lopa','andheri','New York','Narnia',25679,'235461','rosa@gmail.com');

SELECT first_name,last_name FROM addressbook
    WHERE city='new york'
        ORDER By first_name asc;

--uc9
--Alter to add name and type
ALTER TABLE AddressBook
ADD BookName VARCHAR(50), BookType VARCHAR(50);

UPDATE addressbook SET BookName='Book1', BookType='Family' WHERE last_name='lopa'; 
UPDATE addressbook SET BookName='Book2', BookType='Friends' WHERE first_name='keya' OR first_name='Jake';
UPDATE addressbook SET BookName='book3', BookType='Profession' WHERE first_name='Sherlock';
UPDATE addressbook SET BookName='book3', BookType='Profession' WHERE first_name='Vladimir';
SELECT * FROM addressbook;

--uc10
--Count by type
SELECT COUNT(first_name) AS CONTACTS FROM addressbook
    WHERE BookType='Profession';

--UC11
--ADD INTO FRIENDS AND FAMILY
INSERT INTO addressbook VALUES
('Shakira','Shamina','Borivali','Mumbai','Maharashtra',400098,'7452166','shakira@gmail.com','Book1','Family'),
('Shakira','Shamina','Borivali','Mumbai','Maharashtra',400098,'7452166','shakira@gmail.com','Book2','Friends');
SELECT * FROM addressbook;

--UC12 
--ER DIAGRAM 
DROP TABLE addressbook;
--CREATING TABLE CONTACT
CREATE TABLE contact(
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(20) NOT NULL,
    state VARCHAR(20) NOT NULL,
    zip INT NOT NULL,
    phone_no VARCHAR(15) NOT NULL,
    email VARCHAR(50) NOT NULL,
    book_id VARCHAR(30) FOREIGN KEY REFERENCES booknametype(book_id)
);
--CREATING TABLE BOOKNAMETYPE
CREATE TABLE booknametype(
    book_id VARCHAR(30) NOT NULL PRIMARY KEY,
    bk_name VARCHAR(30) NOT NULL,
    bk_type VARCHAR(30) NOT NULL
);
--INSERTING DATA IN CONTACT
INSERT INTO contact (first_name,last_name,address,city,state,zip,phone_no,email,book_id)
    VALUES('Vladimir','Putin','3/40, Broadway Street','Moscow','Narnia',989001,'2354618524','v.putin@gmail.com','BK1'),
        ('Sherlock','Holmes','Baker Street','London','England',567897,'7654874','sherlocked@gmail.com','BK2'),
        ('Vladimir','Putina','3/40 Broadway Street','Moscow','Narnia',989001,'2354618524','v.putin@gmail.com','BK3'),
        ('Jake','Peralta','99 Precinct','New York','USA',25679,'911','j.pera@gmail.com','BK1'),
        ('keya','lutina','yenyen','Hiroshima','japan',450981,'239871','ke.lut@gmail.com','BK2'),
        ('rosa','lopa','andheri','New York','Narnia',25679,'235461','rosa@gmail.com','BK3'),
        ('Shakira','Shamina','Borivali','Mumbai','Maharashtra',400098,'7452166','shakira@gmail.com','BK1');
SELECT * FROM contact;

--INSERTING DATA IN BOOKNAME
INSERT INTO booknametype(book_id,bk_name,bk_type)
    VALUES('BK1','Book1','Family'),('BK2','Book2','Friends'),('BK3','Book3','Profession');
SELECT * FROM booknametype;

--LETS VIEW THE TABLES
SELECT * FROM contact;
SELECT * FROM booknametype;

--UC13
--RETRIEVE DATA AS NEEDED
SELECT first_name, last_name FROM contact c INNER JOIN booknametype b
ON c.book_id=b.book_id 
WHERE c.city='new york' OR c.state='england';

SELECT COUNT(c.first_name) AS TOTAL_COUNT, c.city AS PLACE FROM contact c INNER JOIN booknametype b
ON c.book_id=b.book_id 
GROUP BY c.city;

SELECT first_name, last_name FROM contact c INNER JOIN booknametype b
ON c.book_id=b.book_id 
WHERE c.city='new york'
ORDER BY first_name DESC;

SELECT b.bk_type AS Book_Type, COUNT(b.bk_type) AS Total_COUNT FROM contact c INNER JOIN booknametype b
ON c.book_id=b.book_id 
GROUP BY b.bk_type;