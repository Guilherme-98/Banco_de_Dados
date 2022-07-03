CREATE SCHEMA _library; 

CREATE TABLE _library.publisher(
	name VARCHAR(50), 
	address VARCHAR(50),
	phone NUMERIC,
	CONSTRAINT pk_publisher_name PRIMARY KEY(name)
);

CREATE TABLE _library.book(
	book_id VARCHAR(50),
	title VARCHAR(50),
	publisher_name VARCHAR(50),
	CONSTRAINT pk_book_book_id PRIMARY KEY(book_id),
	CONSTRAINT fk_library_publisher_name FOREIGN KEY(publisher_name)
		REFERENCES _library.publisher (name) ON DELETE CASCADE
);

CREATE TABLE _library.book_authors(
	book_id VARCHAR(50),
	author_name VARCHAR(50),
	CONSTRAINT pk_book_authors_book_id_author_name PRIMARY KEY (book_id, author_name),
	CONSTRAINT fk_book_authors_book_book_id FOREIGN KEY(book_id)
		REFERENCES _library.book(book_id) ON DELETE CASCADE
);

CREATE TABLE _library.library_branch(
	branch_id VARCHAR(50),
	branch_name VARCHAR(50),
	address VARCHAR(50),
	CONSTRAINT pk_library_branch_brach_id PRIMARY KEY(branch_id)
);

CREATE TABLE _library.book_copies(
	book_id VARCHAR(50),
	branch_id VARCHAR(50),
	no_of_copies VARCHAR(50),
	CONSTRAINT pk_book_copies_book_id_brench_id PRIMARY KEY(book_id,branch_id),
	CONSTRAINT fk_book_copies_book_book_id FOREIGN KEY(book_id)
		REFERENCES _library.book (book_id) ON DELETE CASCADE,
	CONSTRAINT fk_book_copies_library_branch_branch_id FOREIGN KEY(branch_id)
		REFERENCES _library.library_branch (branch_id) ON DELETE CASCADE
);

CREATE TABLE _library.borrower(
	card_no NUMERIC,
	name VARCHAR(50),
	address VARCHAR(50),
	phone NUMERIC,
	CONSTRAINT pk_borrower_card_no PRIMARY KEY(card_no)
);

CREATE TABLE _library.book_loans(
	book_id VARCHAR(50),
	branch_id VARCHAR(50),
	card_no NUMERIC(50),
	date_out DATE,
	due_date DATE,
	CONSTRAINT pk_book_loans_book_id_branch_id_card_no PRIMARY KEY(book_id,branch_id,card_no),
	CONSTRAINT fk_book_lons_book_book_id FOREIGN KEY(book_id)
		REFERENCES _library.book(book_id) ON DELETE CASCADE,
	CONSTRAINT fk_book_loans_library_branch_branch_id FOREIGN KEY(branch_id)
		REFERENCES _library.library_branch (branch_id) ON DELETE CASCADE,
	CONSTRAINT fk_book_loans_borrower_card_no FOREIGN KEY(card_no)
		REFERENCES _library.borrower(card_no) ON DELETE CASCADE
);


INSERT INTO _library.publisher(name, address, phone)
	VALUES('Sharpstown', 'Liberal', 3166365555);
INSERT INTO _library.publisher(name, address, phone)
	VALUES('Silva', 'Fort Dodge', 3161111234);

INSERT INTO _library.book(book_id, title, publisher_name)
	VALUES('1', 'Land Before Time I', 'Sharpstown');
INSERT INTO _library.book(book_id, title, publisher_name)
	VALUES('2','Land Before Time II', 'Silva');
	
INSERT INTO _library.book_authors(book_id, author_name)
	VALUES('1', 'Sharpstown');
INSERT INTO _library.book_authors(book_id, author_name)
	VALUES('2', 'Silva');
	
INSERT INTO _library.library_branch(branch_id, branch_name, address)
	VALUES('100', 'Sharpstown_branch', 'Fort Hays');
INSERT INTO _library.library_branch(branch_id, branch_name, address)
	VALUES('200','Silva_brand', 'Liberal');
	
INSERT INTO _library.book_copies(book_id, branch_id, no_of_copies)
	VALUES(1, 100, 25);
INSERT INTO _library.book_copies(book_id, branch_id, no_of_copies)
	VALUES(2, 200, 10);
	
INSERT INTO _library.borrower(card_no, name, address, phone)
	VALUES(0010, 'Gonçalves', 'Kansas City', 999998888);
INSERT INTO _library.borrower(card_no, name, address, phone)
	VALUES(0090, 'Brown', 'EUA', 111118888);

INSERT INTO _library.book_loans(book_id, branch_id, card_no, date_out, due_date)
	VALUES('1', '100', 0010, '2020-10-06', '2022-10-06');
INSERT INTO _library.book_loans(book_id, branch_id, card_no, date_out, due_date)
	VALUES('2', '200', 0090, '2020-07-07', '2024-01-01');

-- a. How many copies of the book titled ‘The Lost Tribe’ are owned by the library branch whose name is ‘Sharpstown’?
SELECT no_of_copies
FROM ( (_library.book NATURAL JOIN _library.book_copies ) NATURAL JOIN _library.library_branch )
WHERE title='The Lost Tribe' AND branch_name='Sharpstown' 

-- b. How many copies of the book titled ‘The Lost Tribe’ are owned by each library branch?
SELECT branch_name, no_of_copies
FROM ( (_library.book NATURAL JOIN _library.book_copies ) NATURAL JOIN _library.library_branch )
WHERE title='The Lost Tribe'

-- c. Retrieve the names of all borrowers who do not have any books checked out.
SELECT name
FROM  _library.borrower B
WHERE NOT EXISTS ( SELECT *
				 FROM _library.book_loans L WHERE B.card_no = L.card_no )

-- d. For each book that is loaned out from the ‘Sharpstown’ branch and whose Due_date is today,
SELECT B.title, R.name, R.address
FROM _library.book B, _library.borrower R, _library.book_loans BL, _library.library_branch LB
WHERE LB.branch_name='Sharpstown' AND LB.branch_id=BL.Branch_id AND
BL.due_date='today' AND BL.card_no=R.card_no AND BL.book_id=B.book_id 

-- e. For each library branch, retrieve the branch name and the total number of books loaned out from that branch
SELECT L.branch_name, COUNT(*)
FROM  _library.book_loans B, _library.library_branch L
WHERE B.branch_id = L.branch_id
GROUP BY L.branch_name 

-- f. Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
SELECT B.name, B.address, COUNT(*)
FROM _library.borrower B, _library.book_loans L
WHERE B.card_no = L.card_no
GROUP BY B.card_no
HAVING COUNT(*) > 5 

-- g. For each book authored (or coauthored) by ‘Stephen King’, retrieve the title and the number of copies owned by the library branch whose name is ‘Central’.
SELECT title, no_of_copies
FROM ( ( ( _library.book_authors NATURAL JOIN _library.book)
NATURAL JOIN _library.book_copies)
NATURAL JOIN _library.library_branch)
WHERE author_name = 'Stephen King' and branch_name = 'Central' 