CREATE SCHEMA library;

SET search_path TO library;

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

INSERT INTO library.publisher (name, address, phone)
VALUES ('Pequin Random House', 'Villatown', '555555'),
       ('Anchor Books', 'New York', '555556'), 
       ('Mariner Books', 'Boston', '555557'),
       ('Gollancz', 'London', '555558'),
       ('Little, Brown and Company', 'Boston', '555559'),
       ('Scholastic Books', 'New York', '555560'),
       ('Pottermore Limited', 'Londres', '555561'),
       ('Scribner', 'New York', '555562');

INSERT INTO library.book (book_id, title, publisher_name)
VALUES (100, 'The Lost Tribe', 'Pequin Random House'),
       (200, 'The Little Prince', 'Mariner Books'),
       (300, 'The Shining', 'Anchor Books'),
       (400, 'The Green Mile', 'Gollancz'),
       (500, 'Under The Dome', 'Scribner'),
       (600, 'Private Paris', 'Little, Brown and Company'),
       (700, 'Harry Potter and the Sorcerer''s Stone', 'Scholastic Books'),
       (800, 'Harry Potter and the Chamber of Secrets', 'Scholastic Books'),
       (900, 'Deadly Cross', 'Little, Brown and Company'),
       (1000, 'Fantastic Beasts and Where to Find Them', 'Scholastic Books'),
       (1100, 'The Casual Vacancy', 'Little, Brown and Company');

INSERT INTO library.book_authors (book_id, author_name)
VALUES (100, 'Mark Lee'),
       (200, 'Antoine de Saint-Exupéry'),
       (300, 'Stephen E. King'),
       (400, 'Stephen E. King'),
       (500, 'James Patterson'),
       (500, 'Mark Sullivan'),
       (600, 'J. K. Rowling'),
       (700, 'J. K. Rowling'),
       (800, 'James Patterson'),
       (900, 'Stephen Edwin King'),
       (1000, 'J. K. Rwoling'),
       (1100, 'J. K. Rowliing');

INSERT INTO library.library_branch (branch_id, branch_name, address)
VALUES (10, 'Sharpstown', '23rd Park Street'),
       (20, 'Villatown', 'First Street'),
       (30, 'Central', 'Main Street');

INSERT INTO library.book_copies (book_id, branch_id, no_of_copies)
VALUES (100, 10, 3),
       (200, 10, 12),
       (300, 10, 3),
       (400, 10, 1),
       (100, 20, 13),
       (200, 20, 5),
       (300, 20, 1),
       (400, 20, 7),
       (100, 30, 2),
       (200, 30, 10),
       (300, 30, 50),
       (400, 30, 9),
       (500, 30, 2),
       (500, 10, 1),
       (600, 30, 8),
       (700, 30, 4),
       (800, 30, 20);

INSERT INTO library.borrower (card_no, name, address, phone)
VALUES (1111, 'Guilherme', 'Rua Laurinda Pereira', '92341234'),
       (2222, 'Nathalia', 'Rua Tiradentes', '94324321'),
       (3333, 'Matheus', 'Rua J.K.', '91112222');

INSERT INTO library.book_loans (book_id, branch_id, card_no, date_out, due_date)
VALUES (100, 10, 1111, '2022-02-03', '2022-02-17'),
       (200, 10, 2222, '2022-02-01', '2022-02-15'),
       (600, 30, 2222, '2022-03-10', '2022-03-24'),
       (700, 30, 2222, '2022-03-13', '2022-03-27'),
       (100, 20, 3333, '2022-02-02', '2022-02-16'),
       (200, 10, 3333, '2022-02-02', '2022-02-16'),
       (300, 30, 3333, '2022-02-02', '2022-02-16'),
       (400, 30, 3333, '2022-02-02', '2022-02-16'),
       (600, 30, 3333, '2022-02-02', '2022-02-16'),
       (800, 30, 3333, '2022-02-02', '2022-03-22');


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
INSERT INTO book_loans (book_id, branch_id, card_no, date_out, due_date) VALUES (500, 30, 3333, '2021-12-10', '2022-03-20');
REFRESH MATERIALIZED VIEW month_borrowers;

-- Existe uma pessoa com 2 empréstimos com duração de 30 dias ou MAIS. Eles devem ser listados nessa consulta
SELECT * FROM month_borrowers;

------------------------ EXERCÍCIO 2

BEGIN;

CREATE TEMPORARY TABLE old_book_copies AS SELECT * FROM book_copies;
DROP TABLE book_copies;

CREATE SEQUENCE book_copies_detail_seq;
CREATE TABLE book_copies_detail (
    copy_id INTEGER DEFAULT nextval('book_copies_detail_seq'),
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

ALTER TABLE book_loans ADD COLUMN copy_id INTEGER;
ALTER TABLE book_loans ADD CONSTRAINT fk_loan_copy FOREIGN KEY (copy_id)
    REFERENCES book_copies_detail (copy_id);

CREATE OR REPLACE FUNCTION find_inconsistencies()
    RETURNS TABLE(book_id INT, branch_id INT, num_copies_old INT, num_copies_new INT) AS $$
        SELECT obc.book_id, obc.branch_id, obc.no_of_copies AS num_copies_old, COALESCE(bc.no_of_copies, 0) AS num_copies_new
        FROM old_book_copies obc
        LEFT JOIN (SELECT book_id, branch_id, COUNT(*) AS no_of_copies
            FROM book_copies_detail
            GROUP BY book_id, branch_id) bc ON bc.book_id = obc.book_id AND bc.branch_id = obc.branch_id
        WHERE obc.no_of_copies != COALESCE(bc.no_of_copies, 0)
$$ LANGUAGE SQL;

DO $$
DECLARE
    c RECORD;
    diff INT;
    v_copy_id INT;
BEGIN
    FOR c IN (SELECT * FROM find_inconsistencies()) LOOP
        SELECT c.num_copies_old - c.num_copies_new INTO diff;
        IF diff > 0 THEN
            FOR _ IN 1..diff LOOP
                INSERT INTO library.book_copies_detail(book_id, branch_id) VALUES (c.book_id, c.branch_id);
            END LOOP;
        END IF;
    END LOOP;

    FOR c IN (SELECT * FROM book_loans) LOOP
        v_copy_id := NULL;
        SELECT copy_id INTO v_copy_id FROM book_copies_detail WHERE branch_id = c.branch_id AND book_id = c.book_id;
        IF v_copy_id IS NULL THEN
            RAISE EXCEPTION 'There is no copy for book % found in branch % while updating loan from %', c.book_id,
                c.branch_id, c.card_no;
        END IF;

        UPDATE book_loans SET copy_id = v_copy_id
        WHERE card_no = c.card_no AND branch_id = c.branch_id AND book_id = c.book_id;
    END LOOP;
END
$$ LANGUAGE PLPGSQL;

ALTER TABLE book_loans ALTER COLUMN copy_id SET NOT NULL;

COMMIT;

DROP FUNCTION find_inconsistencies();
DROP TABLE old_book_copies;

CREATE VIEW book_copies AS
SELECT book_id, branch_id, COUNT(*) AS no_of_copies
FROM library.book_copies_detail
GROUP BY book_id, branch_id;

CREATE OR REPLACE FUNCTION delete_copies() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM book_copies_detail WHERE book_id = OLD.book_id AND branch_id = OLD.branch_id;
    RETURN NULL;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION update_copies() RETURNS TRIGGER AS $$
DECLARE
    diff INT;
BEGIN
    SELECT NEW.no_of_copies - COALESCE(OLD.no_of_copies, 0) INTO diff;

    IF diff < 0 THEN
        RAISE EXCEPTION 'Reducing the number of copies is not allowed';
    END IF;

    IF OLD IS NOT NULL AND (OLD.branch_id != NEW.branch_id OR OLD.book_id != NEW.book_id) THEN
        UPDATE book_copies_detail SET branch_id = NEW.branch_id, book_id = NEW.book_id
        WHERE branch_id = OLD.branch_id AND book_id = OLD.book_id;
    END IF;

    FOR _ IN 1..diff LOOP
        INSERT INTO library.book_copies_detail(book_id, branch_id, acquisition_date)
            VALUES (NEW.book_id, NEW.branch_id, now());
    END LOOP;

    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER book_copy_delete_tg
    INSTEAD OF DELETE ON library.book_copies
    FOR EACH ROW
    EXECUTE PROCEDURE delete_copies();

CREATE TRIGGER book_copy_no_update_tg
    INSTEAD OF INSERT OR UPDATE ON library.book_copies
    FOR EACH ROW
    EXECUTE PROCEDURE update_copies();

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

----------------------------- EXERCÍCIO 3

CREATE EXTENSION fuzzystrmatch;

CREATE TABLE log(
    book_id INTEGER,
    old_author_name VARCHAR(200),
    new_author_name VARCHAR(200),
    update_time TIMESTAMP NOT NULL,
    CONSTRAINT pk_log PRIMARY KEY (book_id, old_author_name, new_author_name)
);

CREATE OR REPLACE FUNCTION compare_middle_name(name1 TEXT, name2 TEXT) RETURNS BOOL AS $$
DECLARE
    name1_first TEXT;
    name2_first TEXT;
    name1_mid TEXT;
    name2_mid TEXT;
    name1_nomid TEXT;
    name2_nomid TEXT;
BEGIN
    SELECT split_part(name1, ' ', 2) INTO name1_mid;
    SELECT split_part(name2, ' ', 2) INTO name2_mid;
    SELECT substring(name1_mid, 1, 1) INTO name1_first;
    SELECT substring(name2_mid, 1, 1) INTO name2_first;
    SELECT regexp_replace(name1, name1_mid || ' ', '') INTO name1_nomid;
    SELECT regexp_replace(name2, name2_mid || ' ', '') INTO name2_nomid;

    RETURN name1_first = name2_first AND
           (name1_mid LIKE '_.' OR char_length(name1) = 1
                OR name2_mid LIKE '_.' OR char_length(name2) = 1)
            AND levenshtein(name1_nomid, name2_nomid) <= 2;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION elim_duplicate_authors() RETURNS VOID AS $$
DECLARE
    c RECORD;
    c1_count INT;
    c2_count INT;
BEGIN
    FOR c IN (SELECT DISTINCT a.book_id c1_book_id, a.author_name c1_author_name,
                              b.book_id c2_book_id, b.author_name c2_author_name
              FROM book_authors a CROSS JOIN book_authors b
              WHERE a.author_name < b.author_name) LOOP
        IF EXISTS (SELECT * FROM log WHERE book_id = c.c1_book_id AND old_author_name = c.c1_author_name
            OR book_id = c.c2_book_id AND old_author_name = c.c2_author_name) THEN CONTINUE;
        END IF;
        IF compare_middle_name(c.c1_author_name, c.c2_author_name)
               OR levenshtein(c.c1_author_name, c.c2_author_name) <= 2 THEN
            SELECT COUNT(*) INTO c1_count FROM book_authors WHERE author_name = c.c1_author_name;
            SELECT COUNT(*) INTO c2_count FROM book_authors WHERE author_name = c.c2_author_name;

            IF c1_count > c2_count THEN
                INSERT INTO log (book_id, old_author_name, new_author_name, update_time)
                    VALUES (c.c2_book_id, c.c2_author_name, c.c1_author_name, now());
                UPDATE book_authors SET author_name = c.c1_author_name
                WHERE author_name = c.c2_author_name
                AND book_id = c.c2_book_id;
            ELSIF c2_count > c1_count THEN
                INSERT INTO log (book_id, old_author_name, new_author_name, update_time)
                    VALUES (c.c1_book_id, c.c1_author_name, c.c2_author_name, now());
                UPDATE book_authors SET author_name = c.c2_author_name
                WHERE author_name = c.c1_author_name
                AND book_id = c.c1_book_id;
            END IF;
        END IF;
    END LOOP;
END
$$ LANGUAGE PLPGSQL;

------------------- TESTES

-- Existe 3 entradas duplicadas
SELECT * FROM book_authors;

-- Executar a elim_duplicate_authors()
SELECT elim_duplicate_authors();

-- É mostrada as 3 entradas que foram substituídas
SELECT * FROM log;

-- Não existe mais entradas duplicadas
SELECT * FROM book_authors;