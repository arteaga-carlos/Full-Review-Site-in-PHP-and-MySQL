grant select, insert, update, delete
on reviews.*
to webuser
identified by 'thisISssaVery37328lOngPswoejdwword9203';

create table users
(
	id int(4) unsigned not null auto_increment primary key,
	username varchar(15) not null,
	display_name varchar(15) not null,
	email varchar(64) not null,
	password char(64) not null,
	activation varchar(32) default 0 not null
);

insert into users
values
('', 'admin', 'administrator', 'admin@localhost.com', sha2('password', 256), '0');

create table reviews
(
	id int unsigned not null auto_increment primary key,
	title varchar(100) not null,
	raiting int(1) unsigned not null
);

create table reviews_descriptions
(
	id int unsigned not null auto_increment primary key,
	description text not null,
	review_id int unsigned not null,
	
	constraint reviews_descriptions_fk_review_id
	foreign key (review_id)
		references reviews(id)
		on delete cascade
);

alter table reviews
add constraint unique_title
	unique(title);
	
create table categories
(
	id int unsigned not null auto_increment primary key,
	category varchar(30) not null unique 
);

insert into categories
(category)
values
('Beauty'),
('Vehicles'),
('Shops'),
('Restaurants'),
('Electronics'),
('Music'),
('Movies'),
('Instruments'),
('Education'),
('Tools'),
('Science'),
('Travel'),
('Sports'),
('People'),
('Games'),
('Entertainment'),
('Pets'),
('Businesses');

insert into categories
(category)
values
('TV');

insert into categories
(category)
values
('Technology');

alter table categories
add column review_id int unsigned not null references reviews(id);

alter table categories
drop column review_id;

alter table reviews
add column category int unsigned not null references categories(id);

alter table reviews
modify raiting tinyint(1) unsigned;

alter table reviews
change category category_id int unsigned not null;

alter table reviews
modify raiting tinyint(1) unsigned not null;

alter table reviews
add column user_id int unsigned not null references users(id);

alter table reviews
add column parent int unsigned not null references review (id);

alter table reviews
add column date date not null;

alter table users
add column date_joined date not null;

alter table users
drop column display_name;

alter table reviews
modify column raiting tinyint(1) unsigned not null default 0;

alter table reviews
add column likes int unsigned not null default 0;
	
create table user_likes
(
	user_id int unsigned not null,
	comment_id int unsigned not null,
	constraint pk_user_likes
		primary key(user_id, comment_id),
		
	constraint user_likes_fk_user_id
	foreign key (user_id)
		references users(id)
		on delete cascade,
		
	constraint user_likes_fk_comment_id
	foreign key (comment_id)
		references comments(id)
		on delete cascade
);

alter table reviews
drop column likes;

alter table reviews
add column tag varchar(20);

create table comments
(
	id int unsigned not null auto_increment primary key,
	title varchar(100) not null,
	user_id int unsigned not null,
	review_id int unsigned not null,
	date date not null,
	tag varchar(20) not null,
	constraint unique_title
		unique(title),
		
	constraint fk_review_id
	foreign key (review_id)
		references reviews(id)
		on delete cascade
);

create table comments_descriptions
(
	id int unsigned not null auto_increment primary key,
	description text not null,
	comment_id int unsigned not null,
	constraint fk_comment_id
	foreign key (comment_id)
	references comments(id)
	on delete cascade
);

alter table comments
modify title varchar(50) not null;

alter table reviews
drop index unique_title;

alter table comments
drop index unique_title;

alter table reviews
drop column tag;

alter table comments
add column rating tinyint(1) unsigned not null default 1;

alter table reviews
drop column raiting;

alter table user_likes
change column review_id comment_id int unsigned not null;

alter table reviews
drop column parent;

alter table reviews_descriptions
drop column user_id;

alter table comments
drop column tag;

-- CREATE TABLE FOR CODEIGNITER'S SESSIONS
-- *NOTE: CHANGE SETTING IN CODEIGNITER FOR DATABASE USE
CREATE TABLE IF NOT EXISTS  sessions (
	session_id varchar(40) DEFAULT '0' NOT NULL,
	ip_address varchar(45) DEFAULT '0' NOT NULL,
	user_agent varchar(120) NOT NULL,
	last_activity int(10) unsigned DEFAULT 0 NOT NULL,
	user_data text NOT NULL,
	PRIMARY KEY (session_id),
	KEY last_activity_idx (last_activity)
);


-- CREATE GET_RAITING FUNCTION
SET GLOBAL log_bin_trust_function_creators = 1; 

delimiter //
drop function if exists get_rating;
create function get_rating(id tinyint(1) unsigned) 
returns int

begin
	declare rating int unsigned;
	declare rating_count int unsigned;
	
	select sum(c.rating), count(c.rating)
	into rating, rating_count
	from comments c
	where c.review_id = id;
	
	if (rating is null || rating_count is null)
	then
		set rating = 0;
	else
		set rating = rating / rating_count;
	end if;	
	
	return rating;
end //
delimiter ;

create table reviews_flags (
	review_id int unsigned not null,
	user_id int unsigned not null,
	
	constraint pk_reviews_flags
		primary key (review_id, user_id),
	
	foreign key (review_id)
		references reviews(id)
		on delete cascade,
		
	foreign key (user_id)
		references users(id)
		on delete cascade
);

-- Delete reviews when flags reach the count of 5
delimiter #
drop trigger if exists after_flag_insert;
create trigger after_flag_insert
after insert on reviews_flags
for each row
begin
	declare flag_count int unsigned;
	
	set flag_count = (
		select count(review_id)
		from reviews_flags
		where reviews_flags.review_id = new.review_id
	);
	
	if ((flag_count is not null) and (flag_count = 8))
	then
		delete from reviews
		where reviews.id = new.review_id;	
	end if;
end #
delimiter ;

-- Select foreign key cnstraints
use information_schema;

SELECT
  constraint_name
FROM
  information_schema.REFERENTIAL_CONSTRAINTS
WHERE
  constraint_schema = 'reviews' AND table_name = 'comments';








  
  
  
  
  
  
  update users
  set password = sha2('password', 256);











