DROP DATABASE IF EXISTS Testing_System_Assignment_2;
CREATE DATABASE Testing_System_Assignment_2;

USE Testing_System_Assignment_2;

DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department`(
	DepartmentID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	DepartmentName	VARCHAR(30) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position`(
	PositionID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName	ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE KEY
    );

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	AccountID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email	VARCHAR(30) NOT NULL UNIQUE KEY,
    Username	VARCHAR(30) NOT NULL UNIQUE KEY,
    Fullname	VARCHAR(100) NOT NULL,
    DepartmentID	TINYINT UNSIGNED NOT NULL,
    PositionID	TINYINT UNSIGNED NOT NULL,
	CreateDate	DATETIME DEFAULT NOW(),
    FOREIGN KEY(DepartmentID) REFERENCES `Department`(DepartmentID),
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
    );
    
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName	VARCHAR(30) NOT NULL UNIQUE KEY,
    CreatorID	TINYINT UNSIGNED,
    CreateDate	DATETIME DEFAULT NOW(),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
    );
    
DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE `GroupAccount`(
	GroupID	TINYINT UNSIGNED NOT NULL,
    AccountID	TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY(GroupID, AccountID),
    JoinDate	DATETIME DEFAULT NOW(),
    FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)
	);
    
    
DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE `TypeQuestion`(
	TypeID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName	ENUM('Essay', 'Multiple-choice')
    );
    
DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE `CategoryQuestion`(
	CategoryID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE KEY
    );
    
DROP TABLE IF EXISTS `Question`;
CREATE TABLE `Question`(
	QuestionID	TINYINT UNSIGNED AUTO_INCREMENT,
    Content	VARCHAR(100) NOT NULL,
    CategoryID	TINYINT UNSIGNED NOT NULL,
    TypeID	TINYINT UNSIGNED NOT NULL,
    CreatorID	TINYINT UNSIGNED NOT NULL,
    CreateDate	DATETIME DEFAULT NOW(),
    PRIMARY KEY(QuestionID, CategoryID, TypeID, CreatorID),
    FOREIGN KEY(CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
    FOREIGN KEY(TypeID) REFERENCES `TypeQuestion`(TypeID),
    FOREIGN KEY(CreatorID) REFERENCES `Group`(CreatorID)
    );

DROP TABLE IF EXISTS `Answer`;
CREATE TABLE `Answer`(
	AnswerID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Content	VARCHAR(100) NOT NULL,
    QuestionID	TINYINT UNSIGNED NOT NULL,
    isCorrect	BIT DEFAULT 1,
    FOREIGN KEY(QuestionID) REFERENCES `Question`(QuestionID)
    );
    
DROP TABLE IF EXISTS `Exam`;
CREATE TABLE `Exam`(
	ExamID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`	VARCHAR(10) NOT NULL,
    Title	VARCHAR(50) NOT NULL,
    CategoryId	TINYINT UNSIGNED NOT NULL,
    Duration	TINYINT UNSIGNED NOT NULL,
    CreatorID	TINYINT UNSIGNED NOT NULL,
    CreateDate	DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
    );
    
DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE `ExamQuestion`(
	ExamID	TINYINT UNSIGNED NOT NULL,
    QuestionID	TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY(ExamID, QuestionID),
    FOREIGN KEY(ExamID) REFERENCES `Exam`(ExamID),
    FOREIGN KEY(QuestionID) REFERENCES `Question`(QuestionID)
    );

 
INSERT INTO `Department`(DepartmentName)
VALUES	('Marketing'),
		('Sale'),
        ('Human Resources'),
        ('Engineer'),
        ('Accountant'),
        ('Janitor');
    
INSERT INTO `Position`(PositionName)
VALUES	('Dev'),
		('Test'),
        ('PM');

INSERT INTO `Account`(Email , UserName , FullName , DepartmentID , PositionID , CreateDate)
VALUES	('hung1@gmail.com' , 'Hung' , 'Nguyen Manh Hung' , 1 , 1 , '2022-07-23'),
		('hien1@gmail.com' , 'Hien' , 'Nguyen Minh Hien' , 2 , 1 , '2022-08-23'),
        ('huong1@gmail.com' , 'Huong' , 'Haha Huong' , 3 , 2 , '2022-08-03'),
        ('van1@gmail.com' , 'Van' , 'Nguyen Thuy Van' , 4 , 3 , '2022-08-23'),
		('coco1@gmail.com' , 'Coco' , 'Miss Coco' , 5 , 3 , '2022-08-23');
        
INSERT INTO `Group`(GroupName , CreatorID , CreateDate)
VALUES 	('Testing System' , 5,'2022-08-22'),
		('Development' , 1,'2022-08-24'),
		('Creator' , 3 ,'2022-08-14'),
		('Marketing 01' , 4 ,'2022-08-01'),
		('Management' , 5 ,'2022-02-02');
        
        
INSERT INTO `GroupAccount`(GroupID , AccountID , JoinDate)
VALUES 	(1 , 1,'2021-12-31'),
		(1 , 2,'2003-03-16'),
        (2 , 3,'2022-08-19'),
        (4 , 4,'2022-08-23'),
        (5 , 5,'2022-08-24');
        
INSERT INTO `TypeQuestion`(TypeName)
VALUES 	('Essay'),
		('Multiple-Choice');
        
INSERT INTO `CategoryQuestion`(CategoryName )
VALUES 	('Java'),
		('Python'),
		('C++'),
		('Ruby'),
		('PHP');
        
INSERT INTO `Question`(Content , CategoryID, TypeID , CreatorID, CreateDate)
VALUES	('Question for Python', 1, '1', '1', '2022-08-12'),
		('Question for Ruby', 1, '2', '1', '2022-08-20'),
        ('Question for Java', 3, '1', '1', '2022-08-12'),
        ('Question for C++', 5, '2', '1', '2012-12-31'),
		('Question for PHP', 4, '1', '1', '2012-12-31');
        
INSERT INTO `Answer`(Content , QuestionID , isCorrect)
VALUES 	('Answer 01' , 1 , 0),
		('Answer 02' , 1 , 1),
		('Answer 03', 1 , 0),
		('Answer 04', 1 , 1),
		('Answer 05', 2 , 1);
        
INSERT INTO Exam (`Code` , Title , CategoryID, Duration , CreatorID , CreateDate )
VALUES	('SQ001' , 'EXAM C#' ,1 , 1 , '1' ,'2022-08-01'),
		('SQ002' , 'EXAM PHP' ,2 , 2 , '2' ,'2021-08-05'),
		('SQ003' , 'EXAM C++' , 3 ,120 , '2' ,'2012-08-22'),
		('SQ004' , 'EXAM Java' , 5 , 60, '3' ,'2020-08-23'),
		('SQ005' , 'EXAM Ruby' , 4 , 10 , '4' ,'2021-08-31');
        
INSERT INTO `ExamQuestion`(ExamID , QuestionID )
VALUES 	(1 , 1),
		(2 , 2),
		(3 , 4),
		(4 , 3),
		(5 , 5);
