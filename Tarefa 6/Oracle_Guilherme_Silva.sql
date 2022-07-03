CREATE TABLE publisher (
   name VARCHAR(200),
   address VARCHAR(200),
   phone VARCHAR(200),
   CONSTRAINT pk_publisher PRIMARY KEY (name)
);

CREATE TABLE book (
    book_id INTEGER,
    title VARCHAR(200),
    publisher_name VARCHAR(200),
    CONSTRAINT pk_book PRIMARY KEY (book_id),
    CONSTRAINT fk_book_publisher FOREIGN KEY (publisher_name)
        REFERENCES publisher (name)
);

CREATE TABLE book_authors (
    book_id INTEGER,
    author_name VARCHAR(200),
    CONSTRAINT pk_book_authors PRIMARY KEY (book_id, author_name),
    CONSTRAINT fk_book_authors_book FOREIGN KEY (book_id)
        REFERENCES book (book_id)
);

CREATE TABLE library_branch (
    branch_id INTEGER,
    branch_name VARCHAR(200),
    address VARCHAR(200),
    CONSTRAINT pk_library_branch PRIMARY KEY (branch_id)
);

CREATE TABLE book_copies (
    book_id INTEGER,
    branch_id INTEGER,
    no_of_copies INTEGER,
    CONSTRAINT pk_book_copies PRIMARY KEY (book_id, branch_id),
    CONSTRAINT fk_book_copies_book FOREIGN KEY (book_id)
        REFERENCES book (book_id),
    CONSTRAINT fk_book_copies_branch FOREIGN KEY (branch_id)
        REFERENCES library_branch(branch_id)
);

CREATE TABLE borrower (
    card_no INTEGER,
    name VARCHAR(200),
    address VARCHAR(200),
    phone VARCHAR(200),
    CONSTRAINT pk_borrower PRIMARY KEY (card_no)
);

CREATE TABLE book_loans (
    book_id INTEGER,
    branch_id INTEGER,
    card_no INTEGER,
    date_out DATE,
    due_date DATE,
    CONSTRAINT pk_book_loans PRIMARY KEY (book_id, branch_id, card_no),
    CONSTRAINT fk_book_loans_book FOREIGN KEY (book_id)
        REFERENCES book (book_id),
    CONSTRAINT fk_book_loans_branch FOREIGN KEY (branch_id)
        REFERENCES library_branch (branch_id),
    CONSTRAINT fk_book_loans_borrower FOREIGN KEY (card_no)
        REFERENCES borrower (card_no)
);

-- Inserção dos dados no Banco de Dados

INSERT ALL
    INTO publisher (name, address, phone) VALUES ('Pequin Random House', 'Villatown', '555555')
    INTO publisher (name, address, phone) VALUES ('Anchor Books', 'New York', '555556')
    INTO publisher (name, address, phone) VALUES ('Mariner Books', 'Boston', '555557')
    INTO publisher (name, address, phone) VALUES ('Gollancz', 'London', '555558')
    INTO publisher (name, address, phone) VALUES ('Little, Brown and Company', 'Boston', '555559')
    INTO publisher (name, address, phone) VALUES ('Scholastic Books', 'New York', '555560')
    INTO publisher (name, address, phone) VALUES ('Pottermore Limited', 'Londres', '555561')
    INTO publisher (name, address, phone) VALUES ('Scribner', 'New York', '555562')
SELECT 1 FROM DUAL;

INSERT ALL
    INTO book (book_id, title, publisher_name) VALUES (100, 'The Lost Tribe', 'Picador USA')
    INTO book (book_id, title, publisher_name) VALUES (200, 'The Little Prince', 'Mariner Books')
    INTO book (book_id, title, publisher_name) VALUES (300, 'The Shining', 'Anchor Books')
    INTO book (book_id, title, publisher_name) VALUES (400, 'The Green Mile', 'Gollancz')
    INTO book (book_id, title, publisher_name) VALUES (500, 'Under The Dome', 'Scribner')
    INTO book (book_id, title, publisher_name) VALUES (600, 'Private Paris', 'Little, Brown and Company')
    INTO book (book_id, title, publisher_name) VALUES (700, 'Harry Potter and the Sorcerer''s Stone', 'Scholastic Books')
    INTO book (book_id, title, publisher_name) VALUES (800, 'Harry Potter and the Chamber of Secrets', 'Scholastic Books')
    INTO book (book_id, title, publisher_name) VALUES (900, 'Deadly Cross', 'Little, Brown and Company')
    INTO book (book_id, title, publisher_name) VALUES (1000, 'Fantastic Beasts and Where to Find Them', 'Scholastic Books')
    INTO book (book_id, title, publisher_name) VALUES (1100, 'The Casual Vacancy', 'Little, Brown and Company')
SELECT 1 FROM DUAL;

INSERT ALL
    INTO book_authors (book_id, author_name) VALUES (100, 'Mark Lee')
    INTO book_authors (book_id, author_name) VALUES (200, 'Antoine de Saint-Exupéry')
    INTO book_authors (book_id, author_name) VALUES (300, 'Stephen E. King')
    INTO book_authors (book_id, author_name) VALUES (400, 'Stephen E. King')
    INTO book_authors (book_id, author_name) VALUES (500, 'James Patterson')
    INTO book_authors (book_id, author_name) VALUES (500, 'Mark Sullivan')
    INTO book_authors (book_id, author_name) VALUES (600, 'J. K. Rowling')
    INTO book_authors (book_id, author_name) VALUES (700, 'J. K. Rowling')
    INTO book_authors (book_id, author_name) VALUES (800, 'James Patterson')
    INTO book_authors (book_id, author_name) VALUES (900, 'Stephen Edwin King')
    INTO book_authors (book_id, author_name) VALUES (1000, 'J. K. Rwoling')
    INTO book_authors (book_id, author_name) VALUES (1100, 'J. K. Rowliing')
SELECT 1 FROM DUAL;

INSERT ALL
    INTO library_branch (branch_id, branch_name, address) VALUES (10, 'Sharpstown', '23rd Park Street')
    INTO library_branch (branch_id, branch_name, address) VALUES (20, 'Villatown', 'First Street')
    INTO library_branch (branch_id, branch_name, address) VALUES (30, 'Central', 'Main Street')
SELECT 1 FROM DUAL;

INSERT ALL
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (100, 10, 3)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (200, 10, 12)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (300, 10, 3)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (400, 10, 1)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (100, 20, 13)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (200, 20, 5)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (300, 20, 1)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (400, 20, 7)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (100, 30, 2)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (200, 30, 10)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (300, 30, 50)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (400, 30, 9)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (500, 30, 2)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (500, 10, 1)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (600, 30, 8)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (700, 30, 4)
    INTO book_copies (book_id, branch_id, no_of_copies) VALUES (800, 30, 20)
SELECT 1 FROM DUAL;

INSERT ALL
    INTO borrower (card_no, name, address, phone) VALUES (1111, 'Guilherme', 'Rua Laurinda Pereira', '92341234')
    INTO borrower (card_no, name, address, phone) VALUES (2222, 'Nathalia', 'Rua Tiradentes', '94324321')
    INTO borrower (card_no, name, address, phone) VALUES (3333, 'Matheus', 'Rua J.K.', '91112222')
SELECT 1 FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-mm-dd';

INSERT ALL
    INTO book_loans (book_id, branch_id, card_no, date_out, due_date)
        VALUES (100, 20, 2222, TO_DATE('2022-02-03'), TO_DATE('2022-02-17'))
    INTO book_loans (book_id, branch_id, card_no, date_out, due_date)
        VALUES (200, 20, 2222, TO_DATE('2022-02-01'), TO_DATE('2022-02-15'))
    INTO book_loans (book_id, branch_id, card_no, date_out, due_date)
        VALUES (600, 40, 2222, TO_DATE('2022-03-10'), TO_DATE('2022-03-24'))
    INTO book_loans (book_id, branch_id, card_no, date_out, due_date)
        VALUES (700, 40, 2222, TO_DATE('2022-03-13'), TO_DATE('2022-03-27'))
    INTO book_loans (book_id, branch_id, card_no, date_out, due_date)
        VALUES (100, 30, 3333, TO_DATE('2022-02-02'), TO_DATE('2022-02-16'))
    INTO book_loans (book_id, branch_id, card_no, date_out, due_date)
     VALUES (200, 20, 3333, TO_DATE('2022-02-02'), TO_DATE('2022-02-16'))
    INTO book_loans (book_id, branch_id, card_no, date_out, due_date)
        VALUES (300, 40, 3333, TO_DATE('2022-02-02'), TO_DATE('2022-02-16'))
    INTO book_loans (book_id, branch_id, card_no, date_out, due_date)
        VALUES (400, 40, 3333, TO_DATE('2022-02-02'), TO_DATE('2022-02-16'))
    INTO book_loans (book_id, branch_id, card_no, date_out, due_date)
        VALUES (600, 40, 3333, TO_DATE('2022-02-02'), TO_DATE('2022-02-16'))
    INTO book_loans (book_id, branch_id, card_no, date_out, due_date)
        VALUES (800, 40, 3333, TO_DATE('2022-02-02'), TO_DATE('2022-03-22'))
SELECT 1 FROM DUAL;

COMMIT;

------------------------ EXERCÍCIO 1

CREATE MATERIALIZED VIEW month_borrowers AS
SELECT b.card_no, name, b.address, phone, abs(date_out - due_date) AS loan_length,
       title, branch_name
FROM book_loans bl
JOIN borrower b on bl.card_no = b.card_no
JOIN book b2 on bl.book_id = b2.book_id
JOIN library_branch lb on bl.branch_id = lb.branch_id
WHERE abs(date_out - due_date) >= 30
AND b.card_no IN (
    SELECT card_no
    FROM book_loans
    WHERE abs(date_out - due_date) >= 30
    GROUP BY card_no
    HAVING COUNT(*) > 1
);

------------------------- TESTES

-- Não existe nenhuma pessoa com MAIS de um empréstimo com duração de 30 dias ou MAIS
SELECT * FROM month_borrowers;

-- A pessoa de cartão 3333 (Matheus) já possui um empréstimo que se encaixa no critério. Inserindo mais um emprestimo com duração superior a 30 dias
INSERT INTO book_loans (book_id, branch_id, card_no, date_out, due_date)
VALUES (500, 30, 3333, TO_DATE('2021-12-10'), TO_DATE('2022-03-20'));

COMMIT;

BEGIN
    DBMS_SNAPSHOT.REFRESH('MONTH_BORROWERS');
END;

-- Existe uma pessoa com 2 empréstimos com duração de 30 dias ou MAIS. Eles devem ser listados nessa consulta
SELECT * FROM month_borrowers;

------------------------ EXERCÍCIO 2

CREATE GLOBAL TEMPORARY TABLE old_book_copies ON COMMIT PRESERVE ROWS AS SELECT * FROM book_copies;
DROP TABLE book_copies;

CREATE SEQUENCE book_copies_detail_seq;
CREATE TABLE book_copies_detail (
        copy_id INTEGER DEFAULT book_copies_detail_seq.nextval,
        book_id INTEGER NOT NULL,
        branch_id INTEGER NOT NULL,
        acquisition_date DATE,
        condition VARCHAR(8) CHECK (condition IN ('fine', 'good', 'fair', 'poor')),
        CONSTRAINT pk_book_copies PRIMARY KEY (copy_id),
        CONSTRAINT fk_book_copies_book FOREIGN KEY (book_id)
     REFERENCES book (book_id),
        CONSTRAINT fk_book_copies_branch FOREIGN KEY (branch_id)
     REFERENCES library_branch(branch_id)
    );

ALTER TABLE book_loans ADD copy_id INTEGER;
ALTER TABLE book_loans ADD CONSTRAINT fk_loan_copy FOREIGN KEY (copy_id)
    REFERENCES book_copies_detail (copy_id);

DECLARE
    diff INT;
    v_copy_id INT;
BEGIN
    FOR c IN (SELECT obc.book_id, obc.branch_id, obc.no_of_copies AS num_copies_old, COALESCE(bc.no_of_copies, 0) AS num_copies_new
              FROM old_book_copies obc
                       LEFT JOIN (SELECT book_id, branch_id, COUNT(*) AS no_of_copies
                                  FROM book_copies_detail
                                  GROUP BY book_id, branch_id) bc ON bc.book_id = obc.book_id AND bc.branch_id = obc.branch_id
              WHERE obc.no_of_copies != COALESCE(bc.no_of_copies, 0)) LOOP
        diff := c.num_copies_old - c.num_copies_new;
        IF diff > 0 THEN
            FOR i IN 1..diff LOOP
                INSERT INTO book_copies_detail(book_id, branch_id) VALUES (c.book_id, c.branch_id);
            END LOOP;
        END IF;
    END LOOP;

    FOR c IN (SELECT * FROM book_loans) LOOP
        v_copy_id := NULL;
        BEGIN
            SELECT copy_id INTO v_copy_id FROM book_copies_detail WHERE branch_id = c.branch_id AND book_id = c.book_id FETCH FIRST ROW ONLY;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('There is no copy for book ' || c.book_id || ' found in branch ' || c.branch_id ||
                                 ' while updating loan from ' || c.card_no);
        END;
        UPDATE book_loans SET copy_id = v_copy_id
        WHERE card_no = c.card_no AND branch_id = c.branch_id AND book_id = c.book_id;
    END LOOP;

    COMMIT;
END;

COMMIT;

ALTER TABLE book_loans MODIFY (copy_id NOT NULL);

TRUNCATE TABLE old_book_copies;
DROP TABLE old_book_copies;

CREATE VIEW book_copies AS
SELECT book_id, branch_id, COUNT(*) AS no_of_copies
FROM book_copies_detail
GROUP BY book_id, branch_id;

CREATE TRIGGER book_copy_delete_tg
INSTEAD OF DELETE ON book_copies
FOR EACH ROW
BEGIN
    DELETE FROM book_copies_detail WHERE book_id = :old.book_id AND branch_id = :old.branch_id;
END;

CREATE TRIGGER book_copy_no_update_tg
INSTEAD OF UPDATE ON book_copies
FOR EACH ROW
DECLARE
    diff INT;
    reducing_copies EXCEPTION;
    PRAGMA EXCEPTION_INIT (reducing_copies, -20001);
BEGIN
    diff := :new.no_of_copies - COALESCE(:old.no_of_copies, 0);

    IF diff < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Reducing the number of copies is not allowed');
    END IF;

    IF :old.branch_id != :new.branch_id OR :old.book_id != :new.book_id THEN
        UPDATE book_copies_detail SET branch_id = :new.branch_id, book_id = :new.book_id
        WHERE branch_id = :old.branch_id AND book_id = :old.book_id;
    END IF;

    FOR i IN 1..diff LOOP
        INSERT INTO book_copies_detail(book_id, branch_id, acquisition_date)
        VALUES (:new.book_id, :new.branch_id, SYSDATE);
    END LOOP;

EXCEPTION
    WHEN reducing_copies THEN
        DBMS_OUTPUT.PUT_LINE(sqlerrm);
        RAISE reducing_copies;
END;

CREATE TRIGGER book_copy_no_insert_tg
    INSTEAD OF INSERT ON book_copies
    FOR EACH ROW
BEGIN
    FOR i IN 1..:new.no_of_copies LOOP
        INSERT INTO book_copies_detail(book_id, branch_id, acquisition_date)
        VALUES (:new.book_id, :new.branch_id, SYSDATE);
    END LOOP;
END;

--------------------------- TESTES

-- Branch de ID 30 do livro 200 deve ter 10 cópias
SELECT * FROM book_copies;

-- FALHA, pois reduzirá o número de cópias do livro 200
UPDATE book_copies SET no_of_copies = 9 WHERE book_id = 200 AND branch_id = 30;

-- CORRETO, pois aumentará o número de cópias do livro 200
UPDATE book_copies SET no_of_copies = 15 WHERE book_id = 200 AND branch_id = 30;

-- Branch de ID 30 deve ter 15 cópias do livro 200
SELECT * FROM book_copies;

-- Deleta o livro 200 com a Branch de ID 30
DELETE FROM book_copies WHERE book_id = 200 AND branch_id = 30;

-- Não existe cópias do livro 200 na branch de ID 30
SELECT * FROM book_copies;

-- Inseri o livro 200 com a Branch de ID 30 com 10 cópias
INSERT INTO book_copies (book_id, branch_id, no_of_copies) VALUES (200, 30, 10);

-- Branch de ID 30 deve ter 10 cópias do livro 200
SELECT * FROM book_copies;

COMMIT;

----------------------------- EXERCÍCIO 3

CREATE TABLE log(
    book_id INTEGER,
    old_author_name VARCHAR(200),
    new_author_name VARCHAR(200) NOT NULL,
    update_time TIMESTAMP NOT NULL,
    CONSTRAINT pk_dup_elim_log PRIMARY KEY (book_id, old_author_name, new_author_name)
);

CREATE OR REPLACE FUNCTION compare_middle_name(name1 VARCHAR, name2 VARCHAR) RETURN BOOLEAN IS
    name1_first VARCHAR(200);
    name2_first VARCHAR(200);
    name1_mid VARCHAR(200);
    name2_mid VARCHAR(200);
    name1_nomid VARCHAR(200);
    name2_nomid VARCHAR(200);
BEGIN
    name1_mid := regexp_substr(name1, '[^ ]+', 1, 2);
    name2_mid := regexp_substr(name2, '[^ ]+', 1, 2);
    name1_first := substr(name1_mid, 1, 1);
    name2_first := substr(name2_mid, 1, 1);
    name1_nomid := regexp_replace(name1, name1_mid || ' ', '');
    name2_nomid := regexp_replace(name2, name2_mid || ' ', '');

    RETURN name1_first = name2_first AND
           (name1_mid LIKE '_.' OR length(name1) = 1
               OR name2_mid LIKE '_.' OR length(name2) = 1)
        AND UTL_MATCH.EDIT_DISTANCE(name1_nomid, name2_nomid) <= 2;
END;

CREATE OR REPLACE PROCEDURE elim_duplicate_authors IS
    c1_count INT;
    c2_count INT;
    l_exst number(1);
BEGIN
    FOR c IN (SELECT DISTINCT a.book_id c1_book_id, a.author_name c1_author_name,
                              b.book_id c2_book_id, b.author_name c2_author_name
              FROM book_authors a CROSS JOIN book_authors b
              WHERE a.author_name < b.author_name) LOOP
        SELECT COUNT(*) into l_exst FROM log
            WHERE book_id = c.c1_book_id AND old_author_name = c.c1_author_name
              OR book_id = c.c2_book_id AND old_author_name = c.c2_author_name;
        IF l_exst > 0 THEN
            CONTINUE;
        END IF;
        IF compare_middle_name(c.c1_author_name, c.c2_author_name)
            OR UTL_MATCH.EDIT_DISTANCE(c.c1_author_name, c.c2_author_name) <= 2 THEN
            SELECT COUNT(*) INTO c1_count FROM book_authors WHERE author_name = c.c1_author_name;
            SELECT COUNT(*) INTO c2_count FROM book_authors WHERE author_name = c.c2_author_name;

            IF c1_count > c2_count THEN
                INSERT INTO log (book_id, old_author_name, new_author_name, update_time)
                VALUES (c.c2_book_id, c.c2_author_name, c.c1_author_name, SYSDATE);
                UPDATE book_authors SET author_name = c.c1_author_name
                WHERE author_name = c.c2_author_name
                  AND book_id = c.c2_book_id;
            ELSIF c2_count > c1_count THEN
                INSERT INTO log (book_id, old_author_name, new_author_name, update_time)
                VALUES (c.c1_book_id, c.c1_author_name, c.c2_author_name, SYSDATE);
                UPDATE book_authors SET author_name = c.c2_author_name
                WHERE author_name = c.c1_author_name
                  AND book_id = c.c1_book_id;
            END IF;
        END IF;
    END LOOP;
END;

------------------- TESTES

-- Existe 3 entradas duplicadas
SELECT * FROM book_authors;

-- Executar a elim_duplicate_authors()
CALL elim_duplicate_authors();

-- É mostrada as 3 entradas que foram substituídas
SELECT * FROM log;

-- Não existe mais entradas duplicadas
SELECT * FROM book_authors;