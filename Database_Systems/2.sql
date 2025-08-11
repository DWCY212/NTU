create table branch(
    name varchar(10),
    city varchar(10),
    director varchar(20),
    assets numeric,
)

create table employee(
    emp_name varchar(24) primary key,
    address varchar(36) default 'company address',
);

create table branch(
    name varchar(10),
    city varchar(20) default 'Singapore',
    director varchar(20) unique,
    assets numeric check (assets > 0),
    primary key (name, city)
)


create table workfor(
    branch_name varchar(10),
    city varchar(20) default 'Singapore',
    employee varchar(20) references staff(name),
    foreing key (branch_name, city) references branch(name, city),
    primary key (branch_name, city, employee)
)

"""insert into relation_name [(att [,att]*)]"""

insert into branch (name, city, director, assets)  
    values ('clementi', 'Singapore', 'ng wee hiong', 3000000);

delete from branch where city = 'jaha' and assets < 1000000;

update branch 
    set assets = assets*1.5
    where name = 'clementi' and city = 'Singapore';

"""query"""
"""select [distinct]
from relation_list
[where qualification]"""

select *
from workfor

select name
from branch
where city = 'Singapore' and assets > 1000000;

select distinct employee, director
from workfor, branch
where name = branch_name and branch.city = workfor.city;

select branch_name from workfor;

select name,city
from branch
order by name asc, city desc;

select name, city, assets*1.7 as assets_USD
from branch

"""renaming"""

select b1.name, b2.name
from branches b1, branches b2
where b1.assets> b2.assets;

"""conceptiual evaluation of queries"""
"""select [distinct] att_list
from relation_list
[where qualification]"""

select title as movietitle, rating as reviewScore
from movies

select 'rating for' || title || 'is' || rating
from movies;

select title, (rating + 0.2)*10
from movies;

"""conditions in where clause"""

select title
from movies
where ((director = 'coen') or (rating > 8.0))

"""where title like 'W_%S'"""

"""Find all employees who work in a Singaporean branch"""
SELECT employee
FROM work_for
WHERE branch_name IN (
    SELECT name
    FROM branch
    WHERE  city= 'Singapore')

"""Find all employees who do not work in a Singaporean branch"""
SELECT employee
FROM work_for
WHERE branch_name <> ALL (
    SELECT name
    FROM branch
    WHERE  city= 'Singapore')

"""Find the cities where the average assets of their branches 
    are larger than the global average"""
select city
from branch b1
group by city
having avg(b1.assets) > (
    select avg(b2.assets)
    from branch b2
);

"""Find actors who have acted in some movie made before 2000"""
select distinct A.actor
from acts a
where A.title IN ( SELECT M.title
    FROM Movies M
    WHERE M.myear < 2000 )

"""Is the above query equivalent to the following query?"""
SELECT DISTINCT A.actor
FROM Acts A, Movies M
WHERE A.title = M.title
AND M.year < 2000

"""Find movies made after 1997 without the actor Maguire"""
SELECT M.title
FROM Movies M
WHERE M.year > 1997
AND M.title NOT IN ( SELECT A.title
    FROM Acts A
    WHERE A.actor = 'Maguire')

"""Is the above query equivalent to the following query?"""
SELECT DISTINCT M.title
FROM Movies M, Acts A
WHERE M.year > 1997
AND M.title = A.title
AND A.actor <> 'Maguire'

"""Find movies that are rated higher than some Coen's movie"""
SELECT M.title
FROM Movies M
WHERE M.rating > ANY ( SELECT N.rating
    FROM Movies N
    WHERE N.director = 'Coen' )

"""Is the above query equivalent to the following query?"""
SELECT M.title
FROM Movies M, Movies N
WHERE N.director = 'Coen'
AND M.rating > N.rating

"""Find movies that are rated higher than all Coen's movies"""
SELECT M.title
FROM Movies M
WHERE M.rating > ALL ( SELECT N.rating
    FROM Movies N
    WHERE N.director = 'Coen' )

"""Find directors who have made some movie before 2000 with Cage"""
SELECT D.director
FROM Directors D
WHERE D.director IN ( SELECT M.director
    FROM Movies M
    WHERE M.myear < 2000
    AND M.title IN ( SELECT A.title
        FROM Acts A
        WHERE A.actor = 'Cage')
);

"""Find movies with rating higher than the average rating of the director's movies"""
SELECT M.title
FROM Movies  M
WHERE M.rating  >  ( SELECT AVG (N.rating)
    FROM Movies  N
    WHERE N.director = M.director )

"""Find directors who have made some movie before 2000 with Cage"""
SELECT D.director
FROM Directors D
WHERE EXISTS ( SELECT *
    FROM    Movies M, Acts A
    WHERE M.director = D.director
    AND M.myear < 2000
    AND M.title = A.title
    AND A.actor = 'Cage' )

"""Find actors who have acted in some Coen's Movie"""
SELECT DISTINCT A.actor
FROM Acts A,
    ( SELECT M.title AS title
    FROM Movies M
    WHERE M.director = 'Coen') AS C
WHERE A.title = C.title

"""Union"""
SELECT A.title
FROM Acts A
WHERE A.actor = 'Cage'
UNION
SELECT A.title
FROM Acts A
WHERE A.actor = 'Maguire'
'wrong——'
SELECT A.title
FROM Acts A
WHERE A.actor = 'Cage'
OR A.actor = 'Maguire'

"""intersect"""
SELECT A.title
FROM Acts A
WHERE A.actor = 'Cage'
INTERSECT
SELECT A.title
FROM Acts A
WHERE A.actor = 'Maguire'
'wrong——'
SELECT A.title
FROM Acts A, Acts B
WHERE A.actor = 'Cage'
AND A.title = B.title
AND A.actor = 'Maguire'

"""GROUP BY Clause"""

SELECT M.director, COUNT (DISTINCT A.actor) AS num
FROM Movies M, Acts A
WHERE M.title = A.title
GROUP BY M.director

SELECT M.director, MAX (M.rating) AS maxRating
FROM Movies M
GROUP BY M.director
HAVING COUNT (*) > 1

SELECT A.actor
FROM Acts A
GROUP BY A.actor
HAVING COUNT (*) > ( SELECT COUNT (M.title)
    FROM Movies M
    WHERE M.director = 'Hanson' )