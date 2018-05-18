drop table customers
drop table ADMIN
drop table USER_LOGIN
drop table [USER]
drop table USER_ROLE
drop table vehicle
drop table feedback
drop table car_rental_organisation
drop table TRIP_DETAILS

CREATE TABLE [dbo].[USER_ROLE](
	[USER_TYPE_ID] [int] NOT NULL,
	[user_type_desc] [char](20),
	constraint USER_TYPE_ID_pk PRIMARY KEY(USER_TYPE_ID)
);

insert into USER_ROLE values(1, 'Admin')
insert into USER_ROLE values(2, 'Customers')

create table [USER]
(
USER_ID int not null,
USER_FIRST_NAME varchar(20) not null,
USER_LAST_NAME varchar(20) not null,
USER_EMAIL varchar(20) not null,
USER_TYPE_ID int not null,
constraint USER_ID_pk primary key(USER_ID),
constraint USER_TYPE_ID_fk foreign key(USER_TYPE_ID) references USER_ROLE(USER_TYPE_ID)
);
insert into [USER] values(65432, 'Neha','Farheen','farheen@gmail.com',2)
insert into [USER] values(65431, 'Sneha','Blarheen','Blarheen@gmail.com',2)
insert into [USER] values(65433, 'Snehal','Fardeen','fardeen@gmail.com',2)

create table USER_LOGIN
(
USER_ID int not null,
username varchar(20) not null,
password varchar(20) not null,
constraint USER_ID_pk5 primary key(USER_ID),
constraint USER_ID_fk5 foreign key(USER_ID) references [USER](USER_ID)
);
insert into USER_LOGIN values(65432,'gurleendua','gurl12345')
insert into USER_LOGIN values(65431,'snehablarheen','sneha12345')
insert into USER_LOGIN values(65433,'snehalfardeen','sneha123452')

 
create table ADMIN
(
USER_ID int not null,
constraint USER_ID_pk1 primary key(USER_ID),
constraint USER_ID_fk1 foreign key(USER_ID) references [USER](USER_ID)
);

insert into ADMIN(12340)


create table customers
(
USER_ID int not null,
LICENSE_NUMBER varchar(20) not null,
CONTACT_NUMBER int,
Previous_Trip_Description varchar(50),
constraint USER_ID_pk2 primary key(USER_ID),
constraint USER_ID_fk2 foreign key(USER_ID) references [USER](USER_ID)
);
insert into customers values(65432,'FAR12345','647328647','Great job')
insert into customers values(65431,'SAR12345','647322347','Great job')
insert into customers values(65432,'ZAR12345','647231647','Great job')

create table feedback
(
	[Feedback_ID] [int] NOT NULL,
	[Rating] [int],
	[Description] [varchar](50),
	constraint USER_ID_pk3 primary key(Feedback_ID)
);

insert into feedback values(00001,5,'Great job')
insert into feedback values(00002,4,'satisfied')
insert into feedback values(00003,3,'Moderate')

create table car_rental_organisation
(
Organisation_ID int not null,
Organisation_name varchar(20),
Place varchar(20),
Number_Of_Vehicles_Provided int,
constraint Organisation_ID_pk primary key(Organisation_ID)
);


insert into car_rental_organisation1 values(99991,'Pranay Rentals','Syracuse',100)
insert into car_rental_organisation1 values(99992,'Ritesh Rentals','NYC',90)
insert into car_rental_organisation1 values(99993,'Romil Rentals','Las Vegas',100)


create table TRIP_DETAILS
(
TRIP_ID int not null,
Car_Pickup_Point varchar(20) not null,
Drop_Off_Point varchar(20) not null,
Start_Date date not null,
Number_Of_Travellers int not null,
constraint TRIP_ID_pk primary key(TRIP_ID)
);

insert into TRIP_DETAILS values(88881,'Syracuse','New york city','08-09-2017',6)
insert into TRIP_DETAILS values(88882,'New York City','Syracuse','02-09-2017',5)
insert into TRIP_DETAILS values(88883,'New Jersey','New york city','08-01-2017',4)



create table vehicle
(
USER_ID int not null,
Organization_ID int not null,
Trip_ID int not null,
Feedback_ID int,
Vehicle_Name varchar(20) not null,
Availibility_Statuse varchar(20) not null,
capacity int not null,
cost int not null,
constraint USER_ID_pk4 primary key(USER_ID, Organization_ID, TRIP_ID),
constraint USER_ID_fk4 foreign key(USER_ID) references [USER](USER_ID),
constraint Organization_ID_fk3 foreign key(Organization_ID) references [car_rental_organisation1](Organization_ID),
constraint TRIP_ID_fk foreign key(TRIP_ID) references TRIP_DETAILS(TRIP_ID),
constraint Feedback_ID_fk foreign key(Feedback_ID) references feedback(Feedback_ID)
);

insert into vehicle values(65432,99991,88881,00001,'i20','yes',6,60)
insert into vehicle values(65431,99992,88882,00002,'Bugatti','yes',6,200)
insert into vehicle values(65433,99993,88883,00003,'Mercedes','yes',6,120)


alter table vehicle
add constraint Feedback_ID_fk foreign key([Feedback_ID]) references feedback([Feedback_ID])


select * from vehicle
create table car_rental_organisation1
(
Organization_ID int not null,
Organization_name varchar(20),
Place varchar(20),
Number_Of_Vehicles_Provided int,
constraint Organization_ID_pk primary key(Organization_ID)
);

alter table TRIP_DETAILS
add LICENSE_NUMBER varchar(20)


DROP trigger ADD_LICENSE1



create trigger
ADD_LICENSE2
on customers
for insert,update as
if @@ROWCOUNT >= 1
begin
update TRIP_DETAILS
SET LICENSE_NUMBER=inserted.LICENSE_NUMBER
from
(
select v.TRIP_ID, c.LICENSE_NUMBER
from customers c
inner join vehicle v 
on c.USER_ID=v.USER_ID
inner join TRIP_DETAILS t
on v.Trip_ID=t.TRIP_ID
) as inserted
where TRIP_DETAILS.TRIP_ID=inserted.Trip_ID
END;

select * from TRIP_DETAILS
select * from customers

insert into customers values(98768,'SAURABH12345',234789232,'SATISFIED')
insert into customers values(98769,'YUN HUANG',999999999,'Very Good Experience')



insert into USER_ROLE values()

SELECT [customers].[USER_ID],[customers].[LICENSE_NUMBER], [customers].[CONTACT_NUMBER],[customers].[Previous_trip_description], [USER].[USER_FIRST_NAME], [USER].[USER_LAST_NAME],[USER].[USER_EMAIL],[TRIP_DETAILS].[TRIP_ID],[TRIP_DETAILS].[Car_Pickup_Point],[TRIP_DETAILS].[Drop_off_point],[TRIP_DETAILS].[Start_Date],[TRIP_DETAILS].[Number_Of_Travellers],[vehicle].[Vehicle_Name], [vehicle].[capacity], [vehicle].[cost] FROM TRIP_DETAILS INNER JOIN (([USER] INNER JOIN customers ON [USER].[USER_ID] =[customers].[USER_ID]) INNER JOIN vehicle ON [customers].[USER_ID] =[vehicle].[USER_ID]) ON [TRIP_DETAILS].[TRIP_ID] =[vehicle].[TRIP_ID];




SELECT [USER].USER_ID, [USER].USER_FIRST_NAME, [USER].USER_LAST_NAME, customers.LICENSE_NUMBER, TRIP_DETAILS.Car_Pickup_Point, TRIP_DETAILS.Drop_Off_Point, TRIP_DETAILS.Number_Of_Travellers
FROM TRIP_DETAILS INNER JOIN (([USER] INNER JOIN customers ON [USER].USER_ID = customers.USER_ID) INNER JOIN vehicle ON customers.USER_ID = vehicle.USER_ID) ON TRIP_DETAILS.TRIP_ID = vehicle.Trip_ID
WHERE ((([USER].USER_ID)=12346));

SELECT vehicle.USER_ID, Count(vehicle.TRIP_ID) AS CountOfTRIP_ID
FROM TRIP_DETAILS INNER JOIN (customers INNER JOIN vehicle ON customers.USER_ID = vehicle.USER_ID) ON TRIP_DETAILS.TRIP_ID = vehicle.TRIP_ID
GROUP BY vehicle.USER_ID
HAVING (((vehicle.USER_ID)=12346));

SELECT vehicle.USER_ID, feedback.Feedback_ID, feedback.Rating, feedback.Description
FROM vehicle INNER JOIN feedback ON vehicle.Feedback_ID = feedback.Feedback_ID
WHERE (((vehicle.USER_ID)=12346));


SELECT car_rental_organisation1.Organization_ID, car_rental_organisation1.organization_Name, vehicle.Vehicle_Name, vehicle.Availibility_Statuse, vehicle.capacity, vehicle.cost
FROM car_rental_organisation1 INNER JOIN vehicle ON car_rental_organisation1.Organization_ID = vehicle.Organization_ID
WHERE (((vehicle.Vehicle_Name)='i20') And ((vehicle.capacity)=6) And ((vehicle.cost)<=200))
ORDER BY vehicle.cost;

SELECT car_rental_organisation1.Organization_ID, car_rental_organisation1.Organization_name, car_rental_organisation1.Place, car_rental_organisation1.Number_Of_Vehicles_Provided, vehicle.Vehicle_Name, vehicle.capacity, vehicle.cost
FROM car_rental_organisation1 INNER JOIN vehicle ON car_rental_organisation1.Organization_ID = vehicle.Organization_ID
WHERE (((car_rental_organisation1.Organization_ID)=33334));

