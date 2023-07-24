--Task 1

Select Count(SurveyId) from Survey 

--Task 2

Select COUNT(Day("Timestamp")) as total_days from survey

--Task 3

Select Count (s.SurveyId) from Survey as s inner join Age as a  on s.SurveyID=a.SurveyID 
Where Age<=30
 
--Task 4

Select Gender,Count (SurveyID) from Gender 
Group by Gender
Order by Count(SurveyID) DESC 

--Task 5

Select Gender,self_employed, count(g.SurveyID) from Gender as g inner join Survey as s on g.SurveyID=s.SurveyId 
where Gender = "Female" and self_employed = "Yes"
Group by Gender, self_employed
Order by Count (g.SurveyID)

--Task 6

Select * from Survey as s inner join Gender as g on s.SurveyID = g.SurveyID 
inner join Location as l on l.SurveyID=g.SurveyID 
where Gender='Female' 
and tech_company = 'Yes'
and Country='Canada'
Order by s.SurveyID ASC 

--Task 7

Select Count (s.SurveyId) from Survey as s inner join Location as l on s.SurveyId=l.SurveyID 
inner JOIN Gender as g on g.SurveyID=l.SurveyID 
where Country= 'United States' and work_interfere = 'Often' and Gender='Male'

--Task 8

Select Count (s.SurveyId) from Survey as s inner join Gender as g on s.SurveyID=g.SurveyID  
Inner Join Age as a on g.SurveyID =a.SurveyID 
where Gender='Male' and remote_work ='Yes' and family_history ='Yes' and Age<30



--Task 9

Create view old_working_Canadians as
Select * from Survey as s inner join Age as a on s.SurveyID=a.SurveyID 
Where Age>= 50

--Task 10 Should it be treatment or seek help column?

Select Country, seek_help , Count (s.SurveyId) from Survey as s inner join Location as l on s.SurveyID=l.SurveyID 
Where Country='Canada' and seek_help not LIKE 'Don%'
Group by Country, seek_help  
Order by Count (s.SurveyID) desc


--Task 11

Select care_options, wellness_program, Count(SurveyID) from (Select * from Survey where care_options='Yes' 
and (wellness_program = 'Yes' 
or wellness_program='No')
Order by SurveyID)
Group by care_options, wellness_program



-- Task 12 Creating the column age group for better convenience

alter table Age add column age_group Varchar(50) Default 'Null'

Update Age Set age_group
= case when age<=25 then '25 and younger' 
when age between 26 and 49 then  '26-49 years_old' 
when age>50 then 'Older than 50'
else 'Null' end
 WHERE  age <= 25 OR age BETWEEN 26 AND 49 OR age > 50

 --Selecting required information, with new column allowing to avoid multiple where clauses

Select age_group,Count (SurveyID) from (Select Age.SurveyID,age_group from Age
inner join Survey on Age.SurveyID= Survey.SurveyID 
where (mental_health_consequence='Yes' or phys_health_consequence='Yes') and age_group !='Null')
Group by age_group
Order by Count (SurveyID) DESC 






