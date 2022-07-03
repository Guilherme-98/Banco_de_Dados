CREATE SCHEMA company;

CREATE TABLE company.parts(
	p_no VARCHAR(50),
	p_name VARCHAR(50),
	price NUMERIC,
	CONSTRAINT pk_parts_p_no PRIMARY KEY (p_no)
);

CREATE TABLE company.zip_codes(
	zip NUMERIC,
	city VARCHAR(50),
	CONSTRAINT pk_zip_codes_zip PRIMARY KEY(zip)
); 

CREATE TABLE company.customers(
	id VARCHAR(50),
	c_name VARCHAR(50),
	street VARCHAR(50),
	c_zip NUMERIC,
	phone NUMERIC,
	CONSTRAINT pk_customers_id PRIMARY KEY(id),
	CONSTRAINT fk_customers_zip_codes_zip FOREIGN KEY(c_zip)
		REFERENCES company.zip_codes(zip) ON DELETE CASCADE
);

CREATE TABLE company.employees(
	e_no VARCHAR(50),
	e_name VARCHAR(50),
	e_zip NUMERIC,
	hire_date DATE, 
	CONSTRAINT pk_employees_e_no PRIMARY KEY(e_no),
	CONSTRAINT fk_employess_zip_codes_zip FOREIGN KEY(e_zip)
		REFERENCES company.zip_codes(zip) ON DELETE CASCADE 
);

CREATE TABLE company.orders(
	c_number NUMERIC,
	cid VARCHAR(50),
	eno VARCHAR(50),
	date_received DATE,
	date_shipped DATE,
	CONSTRAINT pk_orders_c_number PRIMARY KEY(c_number),
	CONSTRAINT fk_orders_customers_id FOREIGN KEY(cid)
		REFERENCES company.customers(id) ON DELETE CASCADE,
	CONSTRAINT fk_orders_employees_e_no FOREIGN KEY(eno)
		REFERENCES company.employees(e_no) ON DELETE CASCADE
);

CREATE TABLE company.order_details(
	details_number NUMERIC,
	o_pno VARCHAR(50),
	quantity NUMERIC,
	CONSTRAINT pk_order_details_details_number_o_pno PRIMARY KEY(details_number, o_pno),
	CONSTRAINT fk_order_details_orders_c_number FOREIGN KEY(details_number)
		REFERENCES company.orders(c_number) ON DELETE CASCADE,
	CONSTRAINT pk_order_details_parts_p_no FOREIGN KEY(o_pno)
		REFERENCES company.parts(p_no) ON DELETE CASCADE
);

INSERT INTO company.parts (p_no, p_name, price)
	VALUES (10506, 'Land Before Time I', 19.99);
INSERT INTO company.parts (p_no, p_name, price)	
	VALUES (10507, 'Land Before Time II', 19.99);
INSERT INTO company.parts (p_no, p_name, price)
    VALUES (10508, 'Land Before Time III', 19.99);
INSERT INTO company.parts (p_no, p_name, price)
    VALUES (10509, 'Land Before Time IV', 19.99);
INSERT INTO company.parts (p_no, p_name, price)
    VALUES (10601, 'Sleeping Beauty', 24.99);
INSERT INTO company.parts (p_no, p_name, price)
    VALUES (10701, 'When Harry Met Sally', 19.99);
INSERT INTO company.parts (p_no, p_name, price)
    VALUES (10800, 'Dirty Harry', 14.99);
INSERT INTO company.parts (p_no, p_name, price)
    VALUES (10900, 'Dr. Zhivago', 24.99);
	
INSERT INTO company.zip_codes (zip, city)
    VALUES (67226, 'Wichita');
INSERT INTO company.zip_codes (zip, city)
    VALUES (60606, 'Fort Dodge');
INSERT INTO company.zip_codes (zip, city)
    VALUES (50302, 'Kansas City');
INSERT INTO company.zip_codes (zip, city)
    VALUES (54444, 'Columbia');
INSERT INTO company.zip_codes (zip, city)
    VALUES (66002, 'Liberal');
INSERT INTO company.zip_codes (zip, city)
   VALUES (61111, 'Fort Hays');
	
INSERT INTO company.customers (id, c_name, street, c_zip, phone)
    VALUES (1111, 'Charles', '123 Main St.', 60606, 3166365555);
INSERT INTO company.customers (id, c_name, street, c_zip, phone)
    VALUES (2222, 'Bertram', '237 Ash Avenue', 67226, 3166895555);
INSERT INTO company.customers (id, c_name, street, c_zip, phone)
    VALUES (3333, 'Barbara', '111 Inwood St.', 60606, 3161111234);	
	
INSERT INTO company.employees (e_no, e_name, e_zip, hire_date)
     VALUES (1000, 'Jones', 67226, '1995-12-12');
INSERT INTO company.employees (e_no, e_name, e_zip, hire_date)
     VALUES (1001, 'Smith', 60606, '1992-01-01');
INSERT INTO company.employees (e_no, e_name, e_zip, hire_date)
     VALUES (1002, 'Brown', 50302, '09-01-1994');
   
INSERT INTO company.orders (c_number, cid, eno, date_received, date_shipped)
     VALUES (1020, 1111, 1000, '1994-12-10', '1994-12-12');
INSERT INTO company.orders (c_number, cid, eno, date_received, date_shipped)
     VALUES (1021, 1111, 1000, '1995-01-12', '1995-01-15');
INSERT INTO company.orders (c_number, cid, eno, date_received, date_shipped)
     VALUES (1022, 2222, 1001, '1995-02-13', '1995-02-20');
INSERT INTO company.orders (c_number, cid, eno, date_received, date_shipped)
     VALUES (1023, 3333, 1000, '1997-06-20', '1997-06-22');
	 
INSERT INTO company.order_details (details_number, o_pno, quantity)
     VALUES (1020, 10506, 1);
INSERT INTO company.order_details (details_number, o_pno, quantity)
     VALUES (1020, 10507, 1);
INSERT INTO company.order_details (details_number, o_pno, quantity)
     VALUES (1020, 10508, 2);
INSERT INTO company.order_details (details_number, o_pno, quantity)
     VALUES (1020, 10509, 3);
INSERT INTO company.order_details (details_number, o_pno, quantity)
     VALUES (1021, 10601, 4);
INSERT INTO company.order_details (details_number, o_pno, quantity)
     VALUES (1022, 10601, 1);
INSERT INTO company.order_details (details_number, o_pno, quantity)
     VALUES (1022, 10701, 1);
INSERT INTO company.order_details (details_number, o_pno, quantity)
     VALUES (1023, 10800, 1);
INSERT INTO company.order_details (details_number, o_pno, quantity)
     VALUES (1023, 10900, 1);
	 
-- a. Retrieve the names of parts that cost less than $20.00.
select p_name
from   company.parts
where  price < 20.00;

-- b. Retrieve the names and cities of employees who have taken orders for parts costing more than $50.00.
select e.e_name,z.city
from   company.employees e, company.zip_codes z, company.orders o, company.order_details d, company.parts p
where  e.e_zip = z.zip and
       e.e_no = o.eno and
       o.c_number = d.details_number and
       d.o_pno = p.p_no and
       p.price > 50.00;
	   
-- c. Find the names of employees who are directly supervised by ‘Franklin Wong’.
select c1.id, c2.id
from   company.customers c1, company.customers c2
where  c1.c_zip = c2.c_zip and c1.id < c2.id;

-- d. Retrieve the names of customers who have ordered parts only from employees living in the city of Wichita.
select c_name
from   company.customers
where  not exists (
         select *
         from   company.orders o, company.employees e, company.zip_codes z
         where  o.cid = company.customers.id and
                o.eno = e.e_no and
                e.e_zip = z.zip and z.city = 'Wichita');
			
-- e. Retrieve the names of customers who have ordered all parts costing less than $20.00.
select c_name
from   company.customers c
where  not exists (
         select *
         from   company.parts p
         where  p.price < 20.00 and
                not exists (
                  select *
                  from   company.orders o, company.order_details d
                  where  o.c_number = d.details_number and
                         o.cid = c.id and
                         o.cid = p.p_no));
						 
-- f. Retrieve the names of customers who have not placed a single order.
select c_name
from   company.customers
where  not exists (
         select *
         from   company.orders
         where  company.orders.cid = company.customers.id);
		 
-- g. Retrieve the names of customers who have placed exactly two orders.
select c_name
from   company.customers
where  exists (
         select *
         from   company.orders o1, company.orders o2
         where  o1.cid = company.customers.id and
                o2.cid = company.customers.id and
                o1.c_number <> o2.c_number) and
       not exists (
         select *
         from   company.orders o1, company.orders o2, company.orders o3
         where  o1.cid = company.customers.id and
                o2.cid = company.customers.id and
                o3.cid = company.customers.id and
                o1.c_number <> o2.c_number and
                o2.c_number <> o3.c_number and
                o1.c_number <> o3.c_number);
				
