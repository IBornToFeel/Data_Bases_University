--СВЯЗАННЫЕ ПОДЗАПРОСЫ

--1. Напишите запрос для получения списка предметов 
--  (ID, наименование, часы, семестр), 
--  на изучение которых отведено максимальное количество часов 
--  среди всех предметов, изучаемых в том же семестре. 
--  Список упорядочить по семестрам.

select *
from subject s1
where hour = (select MAX(hour) from subject s2 where s1.semester = s2.semester )

select *
from subject s1 
join (select semester SEM, MAX(hour) MAX_H
		from subject 
		group by semester) s2 on s1.semester = sem and s1."hour" = MAX_H

select * from subject s order by s.semester ;

--2. Вывести всех студентов (все поля из таблицы STUDENT), 
--   у которых стипендия выше средней по курсу.

select *, (select AVG(stipend) from student where kurs = s.kurs)
from student s
where stipend > (select AVG(stipend) from student where kurs = s.kurs);


--3. Напишите запрос для получения списка студентов 
--   (поля: STUDENT_ID, SURNAME, NAME, STIPEND, KURS, CITY, BIRTHDAY, UNIV_ID), 
--  получающих минимальную стипендию в своем университете, 
--  с последующей сортировкой по значениям идентификатора университета и стипендии.

select *
from student s
where stipend = (select MIN(stipend) from student where univ_id = s.univ_id )
order by univ_id, stipend;



--4. Напишите запрос для получения списка университетов (все поля), 
--   в которых учится более 50 студентов, 
--   с последующей сортировкой университетов по рейтингам.

select *, (select COUNT(*) from student s where s.univ_id = u.univ_id) cnt
from university u 
where (select COUNT(*) from student s where s.univ_id = u.univ_id) > 50 
order by cnt; 
 

--5. Напишите запрос для получения списка университетов (все поля), 
--   в которых работает более 5 преподавателей, 
--   с последующей сортировкой по рейтингам университетов.
select *, (select COUNT(*) from lecturer l where l.univ_id = u.univ_id) cnt
from university u 
where (select COUNT(*) from lecturer l where l.univ_id = u.univ_id) > 5
--where cnt > 5
order by cnt; 


--6. Напишите запрос для получения списка студентов (все поля), 
--   которые учатся в своем городе.

select *
from student s 
where s.city = (select city from university u where u.univ_id = s.univ_id);


--select *
--from university u   
--where city = (select city from student s where u.univ_id = s.univ_id);

-- id, surname, univ_id
-- 4747, Самара,  Зиновьев, 6   6, СГУ, Самара
--for each student_row 
--  for each university_row
--        condition if( u.univ_id = s.univ_id)

--7. Напишите запрос для получения списка иногородних студентов (все поля), которые обучаются не в своем городе, с последующей сортировкой списка по идентификаторам университетов и курсам.
select *
from student s 
where s.city != (select city from university u where u.univ_id = s.univ_id);


--8. Напишите запрос для получения списка преподавателей (все поля), 
--  работающих не в своем городе, с последующей сортировкой по идентификаторам университетов и городам проживания преподавателей.

select *
from lecturer l  
where city != (select city from university u where u.univ_id = l.univ_id);



--9. Выведите отличников (поля: STUDENT_ID, SURNAME, NAME, UNIV_ID, KURS), 
--   которые получили ТОЛЬКО отличные оценки,
--   с последующей сортировкой списка по идентификаторам университетов и курсам.
select *
from student s 
where student_id in (select student_id 
						from exam_marks
						group by student_id 
						having AVG(mark) = 5);
select * 
  from student s 
  where 5 = (select AVG(mark) from exam_marks em where s.student_id = em.student_id )


select student_id 
	from exam_marks
    group by student_id 
    having MIN(mark) = 4 and MAX(mark) = 4
    
select student_id 
	from exam_marks
    group by student_id
    having COUNT(distinct mark) = 1;
    --having MIN(mark) = MAX(mark);

    
  


--10. Напишите запрос для получения списка неуспевающих студентов 
-- (поля: ID студента, фамилию, имя, ID университета и курс), 
-- которые получили ХОТЯ БЫ ОДНУ неудовлетворительную оценку, с последующей сортировкой по идентификаторам университетов и курсам.

explain analyze --43 ms
select * --4013
  from student s 
  where 3 > (select MIN(mark) 
                   from exam_marks em 
                   where s.student_id = em.student_id)

explain analyze -- 10ms
select * --4013
  from student s 
  where EXISTS(select 1
                  from exam_marks em 
                  where s.student_id = em.student_id
                         and mark < 3) 

                   

--11. Напишите запрос, выполняющий вывод списка всех студентов 
--(атрибуты: STUDENT_ID, SURNAME, NAME, UNIV_ID, KURS, AVG_MARK), 
--средняя оценка которых превышает 4 балла.
select * 
  from student s 
  where 4 < (select AVG(mark) from exam_marks em where s.student_id = em.student_id )

--12. Напишите запрос, выполняющий вывод списка фамилий студентов,
-- имеющих только отличные оценки и проживающих в городе,
-- не совпадающем с городом их университета.

select * 
  from student s 
  where 5 = (select AVG(mark) 
  				from exam_marks em 
  				where s.student_id = em.student_id )
        and 
           city != (select city 
           			  from university u 
           			  where s.univ_id = u.univ_id)

--HAVING

--1. Найти города, в которых работают более двух преподавателей.

--2. Найти города, где есть преподаватели, чьи LECTURER_ID содержат цифру 2, и таких преподавателей в городе больше одного.

--3. Найти города, в которых обучается более 10 студентов, и отсортировать их по убыванию численности.

--4. Вывести названия предметов обучения, для которых средняя оценка превышает среднюю оценку по всем предметам. Упорядочить названия предметов по алфавиту.

--5. Вывести количество предметов, по которым экзаменовался каждый студент, сдававший более 6 предметов.

--6. Найти университеты (UNIV_ID), 
--   в которых есть два и более студентов с одинаковой фамилией.
           			  
 select univ_id
 from student
 group by univ_id
 having COUNT(surname) - COUNT(distinct surname) >= 2 

 
 select distinct univ_id
 from student
 group by univ_id, surname 
 having COUNT(*) >= 2
 
 
--7. Найти города, в которых студенты носят более 10 различных имён.
 
 select distinct city 
 from student s 
 where (select COUNT(distinct name) from student s1 where s.city = s1.city) > 10
 
 select city 
 from student s 
 group by city 
 having COUNT(distinct name) > 10;
           			  

--8. Найти названия предметов, суммарное количество часов по которым во всех семестрах превышает 100 часов. Это поможет выявить самые трудоёмкие курсы в учебном плане. Отсортировать по убыванию часов.

--9. Найти дисциплины, которые изучаются в течение двух и более семестров.

--10. Найти дисциплины, в рамках которых за один семестр предусмотрено более 64 часов. Упорядочить записи по убыванию часов.

--11. Найти дисциплины, которые преподаются в весенних семестрах
--    (чётные номера: 2, 4, 6, 8), 
--    и при этом их суммарная нагрузка во всех семестрах (чётных и нечётных) 
--    превышает 70 часов.
           			  
select subj_name, sum(hour) 
from subject s 
where semester % 2 = 0
group by subj_name 
having sum(hour) > 70;

select subj_name, (select sum(hour) 
                      from subject s2 
                      where s1.subj_name = s2.subj_name) sum
from subject s1 
where semester % 2 = 0
group by subj_name 
having 70 < (select sum(hour) 
               from subject s2 
               where s1.subj_name = s2.subj_name);


select subj_name, SUM(hour) 
from subject s 
group by subj_name 
having SUM(hour) > 70 and 
       SUM(case when semester % 2 = 0 then 1 else 0 end) > 0;

select subj_name, SUM(hour) 
from subject s1 
group by subj_name 
having SUM(hour) > 70 and 
       exists(select 1 
               from subject s2 
               where s1.subj_name = s2.subj_name 
                     and semester % 2 = 0);



select * 
from subject
order by subj_name ;           			  
           			  
           			  
           			  
--12. Найти дисциплины, которые преподаются в осенних семестрах (нечётные номера семестров: 1, 3, 5, 7), и при этом их суммарная нагрузка во всех таких семестрах не превышает 120 часов. Упорядочить по убыванию часов.
select subj_name, SUM(hour) 
from subject s 
group by subj_name 
having SUM(hour) <= 120 and 
       SUM(case when semester % 2 != 0 then 1 else 0 end) > 0;


-- УПРАЖНЕНИЯ 2_8 Подзапросы
select univ_id, count(*)
	from student
	where kurs in (1,2,4) 
	group by univ_id
	having count(*) > 10
    order by 2 DESC;

WITH 
-- 1. Первый подзапрос: Расчет средней оценки каждого студента
student_avg_marks AS (
    SELECT 
        student_id,
        AVG(mark) AS avg_mark
    FROM exam_marks
    GROUP BY student_id
),

-- 2. Второй подзапрос: Агрегация данных по университетам
university_stats AS (
    SELECT 
        s.univ_id,
        COUNT(s.student_id) AS total_students,
        AVG(sam.avg_mark) AS univ_avg_mark
    FROM student s
    JOIN student_avg_marks sam ON s.student_id = sam.student_id
    GROUP BY s.univ_id
),

-- 3. Третий подзапрос: Выборка топ-преподавателей для каждого университета (по количеству ведомых предметов)
lecturer_loads AS (
    SELECT 
        l.univ_id,
        COUNT(sl.subj_id) AS total_lectures_taught
    FROM lecturer l
    JOIN subj_lect sl ON l.lecturer_id = sl.lecturer_id
    GROUP BY l.univ_id
)
SELECT 
    u.univ_name,
    u.city,
    u.rating,
    COALESCE(us.total_students, 0) AS students_count,
    ROUND(COALESCE(us.univ_avg_mark, 0), 2) AS average_score,
    COALESCE(ll.total_lectures_taught, 0) AS total_courses_conducted
FROM university u
LEFT JOIN university_stats us ON u.univ_id = us.univ_id
LEFT JOIN lecturer_loads ll ON u.univ_id = ll.univ_id
ORDER BY u.rating DESC;


--№1 
-- Вывести список студентов, получающих минимальную стипендию, 
-- отсортировав его в алфавитном порядке по фамилиям.
select * 
from student 
where stipend = (select MIN(stipend) from student)
order by surname;

-- Вывести список студентов, получающих максимальную стипендию, 
-- отсортировав его в алфавитном порядке по фамилиям.

select * 
from student 
where stipend = (select MAX(stipend) from student)
order by surname;

-- Вывести список студентов, получающих стипендию, 
-- меньшую, чем среднее значение стипендии.

select * 
from student 
where stipend < (select AVG(stipend) from student) --295
order by stipend DESC;


--Вывести список студентов, получающих стипендию, превышающую среднее значение стипендии
select * 
from student 
where stipend > (select AVG(stipend) from student) --295
order by stipend;


--№3 
-- Получить список студентов, которые учатся в Москве, 
-- отсортировать по идентификаторам университетов и курсам.

explain analyse
select *
from student s
where univ_id in (select univ_id
					from university u 
					where city = 'Москва' and univ_id is not null);


explain analyse
select name, surname, kurs, univ_name
	from student s
	join university u on s.univ_id = u.univ_id
	where u.city = 'Москва'
	order by u.univ_id, kurs;

--explain analyze
select *
from student s 
where s.city != (select u.city 
					  from university u
					  where u.univ_id = s.univ_id);
--explain analyze
select name
	, surname
	, s.city live_city
	, u.city study_city
	, kurs
	, univ_name
from student s
join university u on s.univ_id = u.univ_id
where u.city != s.city
order by u.univ_id, kurs;



-- Получить список студентов, учащихся в Воронеже, 
-- отсортировать по идентификаторам университетов и курсам.	


-- Вывести фамилию, имя студента и 
-- количество студентов обучающихся в данном университете
select 
	surname,
	name,
	(select count(*) 
		from student s2 
		where s.univ_id = s2.univ_id
			  and s2.univ_id is not null 
			  and s.univ_id is not null
			  ) as cnt
from student s 
order by cnt;



select surname, name, cnt 
from student s1 
join (select 
			univ_id
			, count(*) as cnt
		from student 
		group by univ_id) s2
		on s1.univ_id = s2.univ_id
order by cnt;



select surname, name, s2.univ_name, s2.cnt 
from student s1 
join (select 
			u.univ_id
			, univ_name
			, count(*) as cnt
		from student s 
		join university u on u.univ_id = s.univ_id 
		group by u.univ_id, u.univ_name) s2
		on s1.univ_id = s2.univ_id
order by cnt;


-- Найти студентов, 
-- получающих стипендию выше средней стипендии в их университете.
​
select surname, name, stipend, 
		(select AVG(stipend) 
							from student s2 
							where s.univ_id = s2.univ_id) as avg_univ
from student s
where stipend > (select AVG(stipend) 
					from student s2 
					where s.univ_id = s2.univ_id);


--№4 
--Получить список предметов, на изучение которых отведено минимальное количество часов.
--Получить список учебных дисциплин, на изучение которых отведено максимальное количество часов.
	
 
--_№5 !!!
-- Написать запрос, выполняющий вывод фамилий и имен студентов, 
-- место проживания которых не совпадает с городом, 
-- в котором находится их университет.

--select surname, name, s.city student_city, u.city study_city
explain analyse
select s.*
	from student s
	join university u on s.univ_id  = u.univ_id
	where s.city != u.city; --4ms

explain analyse
select * 
from student s 
where city != (select city from university u where u.univ_id =s.univ_id);
--118ms


-- Написать запрос, выполняющий вывод имен и фамилий студентов, 
-- место проживания которых совпадает с городом, в котором находится их университет.
	
--№6 
--Получить список университетов, расположенных в Москве и имеющих рейтинг меньший, чем у ВГУ.
--Получить список университетов, расположенных в Москве и имеющих рейтинг больший, чем у ВГУ.


--Вывести всех студентов (все поля из таблицы STUDENT), 
--у которых стипендия выше средней по курсу.

select *
from student s1 
where s1.stipend > (select AVG(stipend ) from student s2 where s1.univ_id = s2.univ_id); --295

select surname, name, s1.stipend ,
       (select AVG(stipend ) from student s2 where s1.kurs = s2.kurs) avg_kurs 
from student s1 
where s1.stipend > (select AVG(stipend ) from student s2 where s1.kurs = s2.kurs); --295

select surname, name, s1.stipend
       (select AVG(stipend ) from student s2 where s1.kurs = s2.kurs) avg_kurs 
from student s1 
where s1.stipend > (select AVG(stipend ) from student s2 where s1.kurs = s2.kurs);



select univ_id, AVG(stipend)
      --, COUNT(*), COUNT(student_id)
from student 
group by univ_id

select s1.*
from student s1
join  (select univ_id, AVG(stipend) avg_stipend
			from student 
			group by univ_id) s2 on s1.univ_id = s2.univ_id
where s1.stipend > avg_stipend;


-- Напишите запрос для получения списка университетов (все поля),
-- в которых учится более 50 студентов, с последующей сортировкой университетов по рейтингам.
select univ_id, COUNT(*)
from student s 
group by univ_id
having COUNT(student_id) > 50;

select *
from university u 
where u.univ_id in(select univ_id
					  from student s 
					  group by univ_id
					  having COUNT(student_id) > 50);

select *
from university u 
where (select COUNT(*) from student s where s.univ_id = u.univ_id) > 50
order by rating; 


-- Напишите запрос для получения списка студентов 
-- (поля: STUDENT_ID, SURNAME, NAME, STIPEND, KURS, CITY, BIRTHDAY, UNIV_ID), 
-- получающих минимальную стипендию в своем университете, 
-- с последующей сортировкой по значениям идентификатора университета и стипендии.

select *
from student s
where s.stipend = (select MIN(stipend) from student s2 where s.univ_id = s2.univ_id);





-- Напишите запрос для получения списка университетов (все поля),
-- в которых работает более 5 преподавателей, с последующей сортировкой
-- по рейтингам университетов.

select *
from university u
where (select COUNT(lecturer_id) from lecturer l where l.univ_id = u.univ_id ) > 5
order by u.rating;



select *
from university u
join lecturer l on l.univ_id = u.univ_id 
order by l.univ_id ;


-- Напишите запрос для получения списка студентов (все поля),
-- которые учатся в своем городе.

select *
from student s
where s.city = (select u.city from university u where s.univ_id = u.univ_id)


-- Напишите запрос для получения списка иногородних студентов (все поля), 
-- которые обучаются не в своем городе, 
-- с последующей сортировкой списка по идентификаторам университетов и курсам.

select *
from student s
where s.city != (select u.city from university u where s.univ_id  = u.univ_id )

select s.univ_id, u.univ_id,  surname, name, s.city stud_city, u.city study_city
from student s
join university u on s.univ_id = u.univ_id 
order by u.univ_id ;



-- УПРАЖНЕНИЯ 2_9 Формирование связанных подзапросов
-- 1. Напишите запрос для получения списка студентов, которые 
-- учатся в своем городе.

-- 2. Напишите запрос для получения списка иногородних студентов
-- (обучающихся не в своем городе), с последующей сортировкой по
-- идентификаторам университетов и курсам.

-- 3. Напишите запрос для получения списка преподавателей, работа-
-- ющих не в своем городе, с последующей сортировкой по иденти-
-- фикаторам университетов и городам проживания преподавателей.

-- 4. Напишите запрос для получения списка предметов, на изучение
-- которых отведено максимальное количество часов среди всех
-- предметов, изучаемых в том же семестре. Список упорядочить по
-- семестрам.

-- 5. Напишите запрос для получения списка студентов, получающих
-- стипендию, превосходящую среднее значение стипендии на их
-- курсе.

-- 6. Напишите запрос для получения списка студентов, получающих
-- минимальную стипендию в своем университете, с последующей
-- сортировкой по значениям идентификатора университета и сти-
-- пендии.

-- 7. Напишите запрос для получения списка университетов, в кото-
-- рых учится более 50 студентов, с последующей сортировкой по
-- рейтингам.

-- 8. Напишите запрос для получения списка университетов, в кото-
-- рых работает более 5 преподавателей, с последующей сортиров-
-- кой по рейтингам университетов.

-- 9. Напишите запрос для получения списка отличников (студентов,
-- получивших только отличные оценки), с последующей сортиров-
-- кой по идентификаторам университетов и курсам.

-- 10. Напишите запрос для получения списка неуспевающих студен-
-- тов (получивших хотя бы одну неудовлетворительную оценку), с
-- последующей сортировкой по идентификаторам университетов и курсам.

-- 11. Напишите запрос, выполняющий вывод списка студентов, сред-
-- няя оценка которых превышает 4 балла.

-- 12. Напишите запрос, выполняющий вывод списка фамилий студен-
-- тов, имеющих только отличные оценки и проживающих в городе,
-- не совпадающем с городом их университета.

-- УПРАЖНЕНИЯ 2_10 Связанные подзапросы в having
-- 1. Напишите запрос с подзапросом для получения всех оценок сту-
-- дента с фамилией Иванов. Предположим, что его персональный
-- номер неизвестен. Всегда ли такой запрос будет корректным?

-- 2. Напишите запрос, выбирающий имена всех студентов, имеющих
-- по предмету c идентификатором 101 балл выше общего среднего
-- балла.

-- 3. Напишите запрос, который выполняет выборку имен всех студен-
-- тов, имеющих по предмету c идентификатором 102 балл ниже
-- общего среднего балла.

-- 4. Напишите запрос, выполняющий вывод количества предметов,
-- по которым экзаменовался каждый студент, сдававший более
-- 20 предметов.

-- 5. Напишите команду SELECT, использующую связанные подзапро-
-- сы и выполняющую вывод имен и идентификаторов студентов, у
-- которых стипендия совпадает с максимальным значением стипен-
-- дии для города, в котором живет студент.

-- 6. Напишите запрос, который позволяет вывести имена и иденти-
-- фикаторы всех студентов, о которых точно известно, что они
-- проживают в городе, где нет ни одного университета.

-- 7. Напишите два запроса, которые позволяют вывести имена и
-- идентификаторы всех студентов, о которых точно известно, что
-- они проживают не в том городе, где расположен их университет:
-- один запрос с использованием связанного подзапроса, а другой —
-- с использованием соединения.

