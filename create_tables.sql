create sequence nlmk_common_seq order start with 1
/
create table nlmk_dept_t (
  dept_id integer
    default nlmk_common_seq.nextval
    constraint nlmk_dept_pk primary key,
  dept_name varchar2(64) not null
)
/
create table nlmk_person_t(
  person_id integer
    default nlmk_common_seq.nextval
    constraint nlmk_person_pk primary key,
  first_name  varchar2(128)  not null,
  last_name   varchar2(128)  not null,
  middle_name varchar2(128)  not null, --хоть и не отчество но пусть будет так
  birth_date  date
)
/
create table nlmk_employee_t(
  employee_id integer
    default nlmk_common_seq.nextval
    constraint nlmk_employee_pk primary key,
  person_id   integer not null,
  dept_id     integer not null,
  tab_num     varchar2(20) not null,
  salary      number,
  constraint nlmk_employee_person_fk foreign key  
    (person_id) references nlmk_person_t(person_id),
  constraint nlmk_employee_dept_fk foreign key 
    (dept_id) references nlmk_dept_t(dept_id)
)
/
insert into nlmk_dept_t(dept_id, dept_name)
  select 1, 'DEPT_1' from dual union all
  select 2, 'DEPT_2' from dual union all
  select 3, 'DEPT_3' from dual union all
  select 4, 'DEPT_4' from dual
/
insert into nlmk_person_t(
  person_id, first_name, middle_name, last_name, birth_date
) select  1, 'FIRST_NAME_01', 'MIDDLE_NAME_01', 'LAST_NAME_01', trunc(sysdate) - 365*25 from dual union all
  select  2, 'FIRST_NAME_02', 'MIDDLE_NAME_02', 'LAST_NAME_02', trunc(sysdate) - 365*25 from dual union all
  select  3, 'FIRST_NAME_03', 'MIDDLE_NAME_03', 'LAST_NAME_03', trunc(sysdate) - 365*25 from dual union all
  select  4, 'FIRST_NAME_04', 'MIDDLE_NAME_04', 'LAST_NAME_04', trunc(sysdate) - 365*25 from dual union all
  select  5, 'FIRST_NAME_05', 'MIDDLE_NAME_05', 'LAST_NAME_05', trunc(sysdate) - 365*25 from dual union all
  select  6, 'FIRST_NAME_06', 'MIDDLE_NAME_06', 'LAST_NAME_06', trunc(sysdate) - 365*25 from dual union all
  select  7, 'FIRST_NAME_07', 'MIDDLE_NAME_07', 'LAST_NAME_07', trunc(sysdate) - 365*25 from dual union all
  select  8, 'FIRST_NAME_08', 'MIDDLE_NAME_08', 'LAST_NAME_08', trunc(sysdate) - 365*25 from dual union all
  select  9, 'FIRST_NAME_09', 'MIDDLE_NAME_09', 'LAST_NAME_09', trunc(sysdate) - 365*25 from dual union all
  select 10, 'FIRST_NAME_10', 'MIDDLE_NAME_10', 'LAST_NAME_10', trunc(sysdate) - 365*25 from dual union all
  select 11, 'FIRST_NAME_11', 'MIDDLE_NAME_11', 'LAST_NAME_11', trunc(sysdate) - 365*25 from dual union all
  select 12, 'FIRST_NAME_12', 'MIDDLE_NAME_12', 'LAST_NAME_12', trunc(sysdate) - 365*25 from dual
/
truncate table nlmk_employee_t
/
insert into nlmk_employee_t(
  person_id, dept_id, tab_num, salary
) select 1,  1, '1001', 6000  from dual union all
  select 2,  1, '1002', 20000 from dual union all
  select 3,  1, '1003', 9000  from dual union all
  select 4,  2, '1004', 10000 from dual union all
  select 5,  2, '1005', 20000 from dual union all
  select 6,  2, '1006', 3000  from dual union all
  select 7,  3, '1007', 5000  from dual union all
  select 8,  3, '1008', 15000 from dual union all
  select 9,  3, '1009', 18000 from dual union all
  select 10, 4, '1010', 20000 from dual union all
  select 11, 4, '1011', 3000  from dual union all
  select 12, 4, '1012', 1000  from dual 
/
commit
/
select d.dept_name, p.first_name || ' ' || p.middle_name || ' ' || p.last_name full_name
from   nlmk_dept_t d,
       nlmk_employee_t emp,
       nlmk_person_t p
where  p.person_id = emp.person_id
and    emp.dept_id = d.dept_id
order by d.dept_name, full_name
/
select emp.*, emp.salary * .03 pct_3, emp.salary * .05 pct_5
from   nlmk_employee_t emp
/
begin
  dbms_output.put_line(nlmk_hr_pkg.grow_salary_and_get_total());
  nlmk_hr_pkg.show_total_salary();
  dbms_output.put_line(nlmk_hr_pkg.get_last_name('1001'));
  dbms_output.put_line(nlmk_hr_pkg.get_last_name('1101'));
end;