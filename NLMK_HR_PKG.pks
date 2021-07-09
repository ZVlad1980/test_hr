CREATE OR REPLACE 
PACKAGE NLMK_HR_PKG AS 

  procedure grow_salary;
  
  procedure show_total_salary;
  
  function grow_salary_and_get_total return number;
  
  function get_last_name(p_tab_num varchar2) return varchar2;

END NLMK_HR_PKG;