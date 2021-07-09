CREATE OR REPLACE TRIGGER NLMK_EMPLYEE_CHK_SALARY_TRG 
BEFORE INSERT OR UPDATE OF SALARY ON NLMK_EMPLOYEE_T 
REFERENCING OLD AS OLD NEW AS NEW 
FOR EACH ROW 
BEGIN
  if mod(:new.salary, 100) > 0 then
    raise_application_error(-20000, 'Сумма зарплаты должна быть кратна 100 руб.');
  end if;
END;