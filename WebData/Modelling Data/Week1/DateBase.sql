create table People(
	int id unsigned,
	varchar(50) first_name,
	varchar(50) last_name,
	varchar(200) company_name,
	varchar(200) address,
	varchar(100) city,
	varchar(100) county,
	varchar(100) postal,
	varchar(200) email,
	varchar(400) web,
	constraint pk_people primary key (id)
);

create table phone(
	int people_id unsigned,
	varchar(200) phone,
	constraint pk_people_phone primary key (people_id, phone),
	constraint fk_people foreign key (people_id) references People (id)
);

LOAD DATA LOCAL INFILE 'people.csv'
INTO TABLE PEOPLE
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(id, first_name, last_name, company_name, address, city, county, postal,email, web)