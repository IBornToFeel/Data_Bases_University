2_1 task
1) select subj_name, subject.subj_id, subject.hour, subject.semester from subject

2)select * from exam_marks where subj_id = 12;

3)select kurs,surname,name,stipend from student;

4)SELECT subj_name, hour
FROM subject
WHERE semester = 4;

5) select distinct mark from exam_marks;

6) SELECT surname
FROM student
WHERE kurs >= 3;

7) SELECT surname, name, kurs
FROM student
WHERE stipend > 140;

8) SELECT subj_name
FROM subject
WHERE hour > 30;

9) SELECT univ_name
FROM university
WHERE rating > 300;

10) SELECT surname, name, kurs
FROM student
WHERE stipend >= 100 AND city = 'Воронеж';

13) SELECT *
FROM student
WHERE birthday < CURRENT_DATE - INTERVAL '25 years'
  AND kurs = 1;

14) SELECT subj_name
FROM subject
WHERE semester = 1 AND hour > 100;

15) SELECT surname, name
FROM lecturer
WHERE city = 'Воронеж';

16) SELECT univ_name
FROM university
WHERE city = 'Москва'
  AND rating < (SELECT rating FROM university WHERE univ_name = 'ВГУ');

17)SELECT surname, name
FROM student
WHERE city = 'Воронеж'
  AND (stipend IS NULL OR stipend = 0);

18) SELECT *
FROM student
WHERE birthday > CURRENT_DATE - INTERVAL '20 years';

19) SELECT surname, name
FROM student
WHERE city IS NULL;

2_2 tasks

1) select distinct sub.subj_id, subj_name
from exam_marks em
join subject sub on em.subj_id = sub.subj_id
where exam_date between '2000-03-01' and '2000-03-31'

2)SELECT subject.subj_name
FROM subject, exam_marks
WHERE subject.subj_id = exam_marks.subj_id
  AND exam_marks.student_id IN (12, 32);

3)select subj_name
from subject
where subj_name like 'И%';

4) select *
from student
where name like 'И%' or name like 'С'

5)select *
from exam_marks
where mark is null;

7) select name
from lecturer
where city like '%-%'

8)select *
from university
where univ_name like '%"%'

9)select subj_name
from subject
where subj_name like '%ия'

10)select university.univ_name
from university
where lower(univ_name) like 'университет'

11)select *
from student
where surname like 'Ков%' or surname like 'Куз%'

12)select subject.subj_name
from subject
where subj_name like '% %'

13) select univ_name
from university
where univ_name like '% % % % % % %'

14)select *
from student
where surname like '___'

2_3 task

1)select
    upper(student_id
    || ';' || surname
    || ';' || name
    || ';' || stipend
    || ';' || city
    || ';' || to_char(birthday, 'dd.mm.yyyy')
    || ';' || univ_id) as full_name
from student

2)select
    (substr(name, 1,1)
    || '.' || upper(surname)
    || '; место жительства - ' || upper(city)
    || '; родился - ' || to_char(birthday, 'dd.mm.yyyy')
        ) as full_name
from student

3)select
    (lower(substr(name, 1,1)
    || '.' || upper(surname)
    || '; место жительства - ' || upper(city)
    || '; родился - ' || to_char(birthday, 'dd.mon.yyyy')
        )) as full_name
from student

4)select
    (name
    || ' ' || surname
    || ' родился(-ась) в ' || to_char(birthday, 'yyyy году')
        ) as full_name
from student


5) select stipend, stipend * 100
from student

6)select
    (kurs, upper(name) || ' ' || upper(surname) || ' родился(-ась) в ' || to_char(birthday, 'yyyy году')) as full_name
from student
where kurs in(1,2,4)

7)select
    ('Код-'|| univ_id || '; ' || univ_name || '-г.' || upper(city) || '; Рейтинг=' || rating) as full_name
from university

8)select
    ('Код-'|| univ_id || '; ' || univ_name || '-г.' || upper(city) || '; Рейтинг=' || round(rating, -2)) as full_name
from university