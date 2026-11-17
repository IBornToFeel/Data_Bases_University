1) SELECT COUNT(student_id) AS student_count
FROM exam_marks
WHERE subj_id = 20;

2)select count(distinct subj_id)
from exam_marks

3)select student_id, MIN(mark)
from exam_marks
GROUP BY student_id

4)select student_id, MAX(MARK)
from exam_marks
GROUP BY student_id

5)select min(surname)
from student
where surname like 'И%'

6)select subj_name, MAX(semester)
from subject
group by subj_name

7)select exam_date, count(distinct student_id)
from exam_marks
group by exam_date

8) select student_id, avg(mark)
from exam_marks
group by student_id

9)SELECT subj_id, AVG(mark)
FROM exam_marks
GROUP BY subj_id
ORDER BY subj_id

10)SELECT subj_id, COUNT(STUDENT_ID)
FROM exam_marks
GROUP BY subj_id
ORDER BY subj_id

11) SELECT CEIL(SEMESTER/2), COUNT(*)
FROM subject
GROUP BY CEIL(semester/2)
ORDER BY CEIL(semester/2);

12)select univ_name, sum(stipend) as total
from university, student
where student.univ_id = university.univ_id
group by university.univ_id,univ_name
order by total desc

13)select semester, sum(hour) as total
from subject
group by semester
order by semester asc

14)select surname, name, avg(mark) as total
from student, exam_marks
where exam_marks.student_id = student.student_id
group by surname, name

15)select surname,name, subj_name, avg(mark)
from student, subject, exam_marks
where exam_marks.subj_id = subject.subj_id and exam_marks.student_id = student.student_id
group by surname, name, subj_name
order by surname

16)SELECT city, COUNT(STUDENT_ID)
FROM student
GROUP BY city
order by count(STUDENT_ID) desc

17)SELECT univ_name, COUNT(student_id) as  STUDENT_COUNT
FROM university
LEFT JOIN student ON university.univ_id = student.univ_id
GROUP BY university.univ_id, univ_name
ORDER BY STUDENT_COUNT

18) SELECT univ_name, COUNT(*) AS lecturers_count
FROM university, lecturer
WHERE university.univ_id = lecturer.univ_id
GROUP BY university.univ_id, univ_name
ORDER BY lecturers_count DESC, university.univ_id;

19)select univ_name, kurs, sum(stipend) as total_stipend
from university, student
where student.univ_id = university.univ_id
group by univ_name, kurs
order by univ_name, kurs

20) SELECT city, MAX(rating) as max_rating
FROM university
group by city
order by max_rating desc

21)SELECT exam_date, avg(mark) as average_mark
FROM exam_marks
group by exam_date
order by exam_date

22)select exam_date,  subj_name, max(mark) as max_mark
from exam_marks, subject
WHERE exam_marks.subj_id = subject.subj_id
GROUP BY exam_date, subject.subj_id, subj_name
ORDER BY exam_date, subj_name;

23)select exam_date, count(distinct student_id)
from exam_marks
group by exam_date

24)select exam_date, surname, name, count(exam_id)
from exam_marks, student
where exam_marks.student_id = student.student_id
group by exam_date, surname, name
order by exam_date, surname

25) SELECT surname, name, count(*) as subjects_count
FROM lecturer, subj_lect
WHERE lecturer.lecturer_id = subj_lect.lecturer_id
GROUP BY lecturer.lecturer_id, surname, name
ORDER BY subjects_count desc, lecturer.lecturer_id

26)select subj_name, count(*) as lecturers_count
from subject, subj_lect
WHERE subject.subj_id = subj_lect.subj_id
group by subject.subj_id, subj_name
order by lecturers_count desc

27)SELECT COUNT(DISTINCT student_id)
FROM exam_marks
WHERE student_id NOT IN (
    SELECT student_id 
    FROM exam_marks 
    WHERE mark < 5
);

28)select count(*) as passed_exams_count
from exam_marks
WHERE mark > 2 and student_id = 32


