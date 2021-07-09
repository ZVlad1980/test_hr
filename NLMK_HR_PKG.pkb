CREATE OR REPLACE
PACKAGE BODY NLMK_HR_PKG AS

  procedure grow_salary(
    p_min_salary number,
    p_max_salary number,
    p_shift_pct  number
  ) AS
    l_koef number;
  BEGIN
    l_koef := 1 + p_shift_pct / 100;
    for emp in (
      select emp.employee_id, emp.salary
      from   nlmk_employee_t emp
      where  emp.salary between p_min_salary and coalesce(p_max_salary, emp.salary)
    ) loop
      emp.salary := round(emp.salary * l_koef / 100) * 100;
      update nlmk_employee_t e
      set    e.salary = emp.salary
      where  e.employee_id = emp.employee_id;
    end loop;
  END grow_salary;

  procedure grow_salary AS
  BEGIN
    grow_salary(0, 14900, 5);
    grow_salary(15000, null, 3);
    commit;
  END grow_salary;
  
  function get_total_salary return number is
    l_result number;
  begin
    select sum(emp.salary)
    into   l_result
    from   nlmk_employee_t emp;
    
    return l_result;
  end get_total_salary;

  procedure show_total_salary AS
  BEGIN
    dbms_output.put_line(get_total_salary());
  END show_total_salary;

  function grow_salary_and_get_total return number AS
  BEGIN
    grow_salary();
    RETURN get_total_salary();
  END grow_salary_and_get_total;

  function get_last_name(p_tab_num varchar2) return varchar2 AS
    l_result nlmk_person_t.last_name%type;
  BEGIN
    select p.last_name
    into   l_result
    from   nlmk_employee_t emp,
           nlmk_person_t   p
    where  p.person_id = emp.person_id
    and    emp.tab_num = p_tab_num;
    
    return l_result;
  exception
    when no_data_found then
      return null;
  END get_last_name;

END NLMK_HR_PKG;