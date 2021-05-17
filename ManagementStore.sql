------------------------------------------------------------------1
-- public.vendors definition

-- Drop table

-- DROP TABLE public.vendors;

CREATE TABLE public.vendors (
	vendor_id bpchar(36) NOT NULL,
	vendor_code varchar(10) NOT NULL,
	vendor_name varchar NOT NULL,
	address varchar(255) NULL,
	phone_number varchar(15) NOT NULL,
	email varchar(100) NULL,
	tax_number varchar(15) NULL,
	state int4 NOT NULL, -- 0- ngá»«ng cc, 1- cc
	CONSTRAINT vendors_pk PRIMARY KEY (vendor_id)
);
COMMENT ON TABLE public.vendors IS 'nhÃ  cung cáº¥p';

-- Column comments

COMMENT ON COLUMN public.vendors.state IS '0- ngá»«ng cc, 1- cc';

--------------------------------------------------------10

-- public.group_employee definition

-- Drop table

-- DROP TABLE public.group_employee;

CREATE TABLE public.group_employee (
	group_id bpchar(36) NOT NULL,
	group_name varchar(100) NOT NULL,
	base_salary float8 NOT NULL,
	CONSTRAINT group_employee_pk PRIMARY KEY (group_id)
);
COMMENT ON TABLE public.group_employee IS 'nhóm các nhân viên';

--------------------------------------------------------------------2

-- public.category definition

-- Drop table

-- DROP TABLE public.category;

CREATE TABLE public.category (
	category_id bpchar(36) NOT NULL,
	category_name varchar(255) NULL,
	CONSTRAINT category_pk PRIMARY KEY (category_id)
);
COMMENT ON TABLE public.category IS 'phÃ¢n loáº¡i sáº£n pháº©m';

------------------------------------------------3
-- public.items definition

-- Drop table

-- DROP TABLE public.items;

CREATE TABLE public.items (
	item_id bpchar(36) NOT NULL,
	item_code varchar(10) NOT NULL,
	item_name varchar(255) NOT NULL,
	unit varchar(50) NULL,
	imported_price int8 NOT NULL,
	description text NULL,
	category_id bpchar(36) NOT NULL,
	state int4 NOT NULL, -- 0 - ngá»«ng nháº­p, 1- nháº­p
	CONSTRAINT items_pk PRIMARY KEY (item_id)
);
COMMENT ON TABLE public.items IS 'báº£ng thÃ´ng tin hÃ ng hÃ³a nháº­n Ä‘Æ°á»£c tá»« nhÃ  cung cáº¥p';

-- Column comments

COMMENT ON COLUMN public.items.state IS '0 - ngá»«ng nháº­p, 1- nháº­p';


-- public.items foreign keys

ALTER TABLE public.items ADD CONSTRAINT items_fk FOREIGN KEY (category_id) REFERENCES public.category(category_id);


-----------------------------------------------4

-- public.vendor_item definition

-- Drop table

-- DROP TABLE public.vendor_item;

CREATE TABLE public.vendor_item (
	vendor_item_id bpchar(36) NOT NULL,
	vendor_id bpchar(36) NOT NULL,
	item_id bpchar(36) NOT NULL,
	CONSTRAINT vendor_item_pk PRIMARY KEY (vendor_item_id, vendor_id, item_id)
);
COMMENT ON TABLE public.vendor_item IS 'báº£ng trung gian giá»¯a nhÃ  cung cáº¥p vá»›i sáº£n pháº©m';


-- public.vendor_item foreign keys

ALTER TABLE public.vendor_item ADD CONSTRAINT vendor_item_fk FOREIGN KEY (vendor_id) REFERENCES public.vendors(vendor_id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE public.vendor_item ADD CONSTRAINT vendor_item_fk_1 FOREIGN KEY (item_id) REFERENCES public.items(item_id) ON DELETE CASCADE ON UPDATE CASCADE;


------------------------------------------------5

-- public.employee definition

-- Drop table

-- DROP TABLE public.employee;

CREATE TABLE public.employee (
	employee_id bpchar(36) NOT NULL,
	employee_code varchar(5) NOT NULL,
	employee_name varchar(100) NOT NULL,
	age int4 NULL,
	dob date NULL,
	address varchar(255) NULL,
	phone_number varchar(15) NOT NULL,
	email varchar(100) NULL,
	gender bpchar(5) NULL,
	identify_number varchar(12) NOT NULL,
	shift int4 NULL, -- 1-sÃ¡ng, 2-chiá»�u, 3-tá»‘i
	pass_word varchar(20) NULL,
	status int4 NULL, -- 0- nghá»‰, 1- hoáº¡t Ä‘á»™ng
	join_date date NOT NULL,
	group_id bpchar(36) NOT NULL,
	CONSTRAINT employee_pk PRIMARY KEY (employee_id)
);

-- Column comments

COMMENT ON COLUMN public.employee.shift IS '1-sÃ¡ng, 2-chiá»�u, 3-tá»‘i';
COMMENT ON COLUMN public.employee.status IS '0- nghá»‰, 1- hoáº¡t Ä‘á»™ng';

-- public.employee foreign keys

ALTER TABLE public.employee ADD CONSTRAINT employee_fk FOREIGN KEY (group_id) REFERENCES public.group_employee(group_id);

-------------------
-- public.invoice definition

-- Drop table

-- DROP TABLE public.invoice;

CREATE TABLE public.invoice (
	invoice_id bpchar(36) NOT NULL,
	invoice_code varchar(25) NOT NULL,
	employee_id bpchar(36) NOT NULL,
	vendor_id bpchar(36) NOT NULL,
	order_date date NULL,
	amount int8 NULL,
	tax int8 NULL,
	total_amount int8 NULL,
	CONSTRAINT invoice_pk PRIMARY KEY (invoice_id)
);
COMMENT ON TABLE public.invoice IS 'chá»©ng tá»« khi nháº­p hÃ ng hÃ³a vá»� kho';


-- public.invoice foreign keys

ALTER TABLE public.invoice ADD CONSTRAINT invoice_employee_fk FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);
ALTER TABLE public.invoice ADD CONSTRAINT invoice_fk FOREIGN KEY (vendor_id) REFERENCES public.vendors(vendor_id);

--------------------------------------------------------6

-- public.invoice_line definition

-- Drop table

-- DROP TABLE public.invoice_line;

CREATE TABLE public.invoice_line (
	invoice_id bpchar(36) NOT NULL,
	invoice_line_id bpchar(36) NOT NULL,
	item_id bpchar(36) NOT NULL,
	CONSTRAINT invoice_line_pk PRIMARY KEY (invoice_id, invoice_line_id, item_id)
);
COMMENT ON TABLE public.invoice_line IS 'báº£ng trung gian giá»¯a báº£ng chá»©ng tá»« mua hÃ ng vá»›i hÃ ng hÃ³a';


-- public.invoice_line foreign keys

ALTER TABLE public.invoice_line ADD CONSTRAINT invoice_line_fk FOREIGN KEY (item_id) REFERENCES public.items(item_id);
ALTER TABLE public.invoice_line ADD CONSTRAINT invoice_line_fk_1 FOREIGN KEY (invoice_id) REFERENCES public.invoice(invoice_id);

------------------------------------7



-----------------------------------------------------8

-- public.store_house definition

-- Drop table

-- DROP TABLE public.store_house;

CREATE TABLE public.store_house (
	item_id varchar NOT NULL, -- vá»«a lÃ  khÃ³a chÃ­nh, vá»«a lÃ  khÃ³a ngoáº¡i
	quantity varchar NULL, -- sá»‘ lÆ°á»£ng sáº£n pháº©m
	selling_price int8 NULL, -- giÃ¡ bÃ¡n ra thá»‹ trÆ°á»�ng
	CONSTRAINT store_house_pk PRIMARY KEY (item_id)
);
COMMENT ON TABLE public.store_house IS 'nÆ¡i lÆ°u trá»¯ cÃ¡c hÃ ng hÃ³a sau khi Ä‘Æ°á»£c nháº­p vá»�';

-- Column comments

COMMENT ON COLUMN public.store_house.item_id IS 'vá»«a lÃ  khÃ³a chÃ­nh, vá»«a lÃ  khÃ³a ngoáº¡i';
COMMENT ON COLUMN public.store_house.quantity IS 'sá»‘ lÆ°á»£ng sáº£n pháº©m';
COMMENT ON COLUMN public.store_house.selling_price IS 'giÃ¡ bÃ¡n ra thá»‹ trÆ°á»�ng';


-- public.store_house foreign keys

ALTER TABLE public.store_house ADD CONSTRAINT store_house_fk FOREIGN KEY (item_id) REFERENCES public.items(item_id);

-----------------------------------------------------------9

-- public.imported definition

-- Drop table

-- DROP TABLE public.imported;

CREATE TABLE public.imported (
	store_id bpchar(36) NOT NULL,
	employee_id bpchar(36) NOT NULL,
	date_imported date NULL,
	invoice_id bpchar(36) NOT NULL,
	CONSTRAINT store_pk PRIMARY KEY (store_id, invoice_id)
);
COMMENT ON TABLE public.imported IS 'báº£ng lÆ°u láº¡i hoáº¡t Ä‘á»™ng nháº­p hÃ ng';


-- public.imported foreign keys

ALTER TABLE public.imported ADD CONSTRAINT store_fk FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);
ALTER TABLE public.imported ADD CONSTRAINT store_fk_1 FOREIGN KEY (invoice_id) REFERENCES public.invoice(invoice_id);


---------------------------------------------------------11

-- public.discount_voucher definition

-- Drop table

-- DROP TABLE public.discount_voucher;

CREATE TABLE public.discount_voucher (
	discount_voucher_id bpchar(36) NOT NULL,
	discount_voucher_code varchar(10) NOT NULL,
	expired_date date NOT NULL, -- ngÃ y háº¿t háº¡n
	category_id bpchar(36) NOT NULL, -- loáº¡i hÃ ng hÃ³a Ã¡p dá»¥ng
	min_total_amount int8 NULL, -- giÃ¡ tá»‘i thiá»ƒu Ä‘á»ƒ Ã¡p dá»¥ng mÃ£ giáº£m giÃ¡
	effective_date date NULL, -- ngÃ y cÃ³ hiá»‡u lá»±c
	discount_rate int4 NULL, -- % giáº£m giÃ¡
	max_discount int8 NULL, -- giáº£m giÃ¡ tá»‘i Ä‘a trÃªn 1 Ä‘Æ¡n hÃ ng
	CONSTRAINT discount_voucher_pk PRIMARY KEY (discount_voucher_id)
);
COMMENT ON TABLE public.discount_voucher IS 'phiáº¿u giáº£m giÃ¡';

-- Column comments

COMMENT ON COLUMN public.discount_voucher.expired_date IS 'ngÃ y háº¿t háº¡n';
COMMENT ON COLUMN public.discount_voucher.category_id IS 'loáº¡i hÃ ng hÃ³a Ã¡p dá»¥ng';
COMMENT ON COLUMN public.discount_voucher.min_total_amount IS 'giÃ¡ tá»‘i thiá»ƒu Ä‘á»ƒ Ã¡p dá»¥ng mÃ£ giáº£m giÃ¡';
COMMENT ON COLUMN public.discount_voucher.effective_date IS 'ngÃ y cÃ³ hiá»‡u lá»±c';
COMMENT ON COLUMN public.discount_voucher.discount_rate IS '% giáº£m giÃ¡';
COMMENT ON COLUMN public.discount_voucher.max_discount IS 'giáº£m giÃ¡ tá»‘i Ä‘a trÃªn 1 Ä‘Æ¡n hÃ ng';


-- public.discount_voucher foreign keys

ALTER TABLE public.discount_voucher ADD CONSTRAINT discount_voucher_fk FOREIGN KEY (category_id) REFERENCES public.category(category_id);

----------------------------------------------12


-- public.customer definition

-- Drop table

-- DROP TABLE public.customer;

CREATE TABLE public.customer (
	customer_id bpchar(36) NOT NULL,
	customer_name varchar(100) NULL,
	age int4 NULL,
	dob date NULL,
	cumulative_point int4 NULL DEFAULT 0, -- Ä‘iá»ƒm tÃ­ch lÅ©y
	email varchar(100) NULL,
	phone varchar(15) NOT NULL,
	address varchar(255) NULL,
	status int4 NOT NULL, -- 0-ngá»«ng sá»­ dá»¥ng, 1- hoáº¡t Ä‘á»™ng, 2- cáº£nh cÃ¡o
	CONSTRAINT customer_pk PRIMARY KEY (customer_id)
);

-- Column comments

COMMENT ON COLUMN public.customer.cumulative_point IS 'Ä‘iá»ƒm tÃ­ch lÅ©y';
COMMENT ON COLUMN public.customer.status IS '0-ngá»«ng sá»­ dá»¥ng, 1- hoáº¡t Ä‘á»™ng, 2- cáº£nh cÃ¡o';

--------------------------------------13

-- public.bill definition

-- Drop table

-- DROP TABLE public.bill;

CREATE TABLE public.bill (
	bill_id bpchar(36) NOT NULL,
	customer_id bpchar(36) NULL,
	discount_voucher_id bpchar(36) NULL,
	employee_id bpchar(36) NOT NULL,
	"date" date NOT NULL,
	vat_tax varchar NULL,
	total_amount int8 NULL,
	CONSTRAINT bill_pk PRIMARY KEY (bill_id)
);
COMMENT ON TABLE public.bill IS 'hÃ³a Ä‘Æ¡n mua hÃ ng cá»§a khÃ¡ch hÃ ng';


-- public.bill foreign keys

ALTER TABLE public.bill ADD CONSTRAINT bill_fk FOREIGN KEY (employee_id) REFERENCES public.employee(employee_id);
ALTER TABLE public.bill ADD CONSTRAINT bill_fk_1 FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);
ALTER TABLE public.bill ADD CONSTRAINT bill_fk_2 FOREIGN KEY (discount_voucher_id) REFERENCES public.discount_voucher(discount_voucher_id);

-------------------------------------------14

-- public.bill_line definition

-- Drop table

-- DROP TABLE public.bill_line;

CREATE TABLE public.bill_line (
	bill_line_id bpchar(36) NOT NULL,
	bill_id bpchar(36) NOT NULL,
	item_id bpchar(36) NOT NULL, -- sáº£n phaame nÃ y pháº£i tham chiáº¿u á»Ÿ trong store_house vÃ¬ khi Ä‘Ã³ sáº£n pháº©m má»›i á»Ÿ trong kho
	quantity int4 NULL,
	CONSTRAINT bill_line_pk PRIMARY KEY (bill_line_id, bill_id, item_id)
);

-- Column comments

COMMENT ON COLUMN public.bill_line.item_id IS 'sáº£n phaame nÃ y pháº£i tham chiáº¿u á»Ÿ trong store_house vÃ¬ khi Ä‘Ã³ sáº£n pháº©m má»›i á»Ÿ trong kho';


-- public.bill_line foreign keys

ALTER TABLE public.bill_line ADD CONSTRAINT bill_line_fk FOREIGN KEY (bill_id) REFERENCES public.bill(bill_id);
ALTER TABLE public.bill_line ADD CONSTRAINT bill_line_fk_1 FOREIGN KEY (item_id) REFERENCES public.store_house(item_id);

-----------------------------------------------15

-- public.selling definition

-- Drop table

-- DROP TABLE public.selling;

CREATE TABLE public.selling (
	selling_id bpchar(36) NOT NULL,
	bill_id bpchar(36) NULL,
	CONSTRAINT selling_pk PRIMARY KEY (selling_id)
);
COMMENT ON TABLE public.selling IS 'báº£ng bÃ¡n hÃ ng';


-- public.selling foreign keys

ALTER TABLE public.selling ADD CONSTRAINT selling_fk FOREIGN KEY (bill_id) REFERENCES public.bill(bill_id);



