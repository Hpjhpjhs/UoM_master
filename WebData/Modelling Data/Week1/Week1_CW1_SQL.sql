/*Q1Process*/
SELECT p.last_name, p.first_name, count(a.person_id) as num_answer
FROM people p, attempts a
where p.id = a.person_id
group by a.person_id
;

/*Q2Process*/
SELECT num_answer.last_name,
num_answer.first_name,
num_answer.postal,
num_answer.num_answered,
num_answer.perc_answered,
correct.num_correctly,
correct.num_correctly *100 / num_answer.num_answered as perc_correctly_from_answered,
correct.num_correctly *100 / (select count(*) from problems) as perc_collectly_from_all

FROM 
(SELECT p.id as person_id, p.last_name, p.first_name, p.postal, 
count(a.person_id) as num_answered,
count(a.person_id)*100 / (select count(*) from problems) as perc_answered
FROM people p, attempts a
where p.id = a.person_id 
group by a.person_id
) num_answer,
(
SELECT a.person_id as person_id, 
count(a.person_id) as num_correctly
FROM attempts a,
(SELECT pro.id problem_id,
case pro.operator
when '+' then pro.arg1 + pro.arg2
when '-' then pro.arg1 - pro.arg2
when '*' then pro.arg1 * pro.arg2
when '/' then pro.arg1 / pro.arg2
else 0
end answer
FROM problems pro) pro_answers
where pro_answers.problem_id = a.problem_id
and a.answer = pro_answers.answer
group by a.person_id
) correct
where num_answer.person_id = correct.person_id

