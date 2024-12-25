select * from bank_loan_data ;

-- TOTAL LOAN APPLICATIONS --

select count(id) as total_loan_application from bank_loan_data ;


-- (Month-To Date) --

select count(id) as Total_Loan_Applications from bank_loan_data
where extract(month from issue_date) = 12 
and extract(year from issue_date) = 2021 ;




-- TOTAL LOAN AMOUNT --

select sum(loan_amount) as Total_Funded_Amount from bank_loan_data ;

--  by ( Month_On_Month) --

select sum(loan_amount) as Total_Funded_Amount from bank_loan_data 
where extract (month from issue_date) = 12
and extract (year from issue_date) = 2021 ;

select sum(loan_amount) as Total_Funded_Amount from bank_loan_data 
where extract (month from issue_date) = 11
and extract (year from issue_date) = 2021 ;




-- TOTAL RECIEVED AMOUNT --

select sum(total_payment) Total_Amoun_Recieved from bank_loan_data ;

--  by (Month_T0_Date)

Select sum(total_payment) as  MTD_Total_AMount_Recieved from bank_loan_data
where extract (month from issue_date) = 12
and extract (year from issue_date) = 2021 ;




-- AVERAGE INTEREST RATE --

 select round(avg(int_rate)*100,2) as Avg_Interest_Rate from bank_loan_data ;
 
 
-- Average Interest Rate (Month_To_Date) --

select round(avg(int_rate)*100,2) as MTD_Avg_Interest_Rate from bank_loan_data
where extract (month from issue_date) = 12
and extract (year from issue_date) = 2021 ;




-- AVERAGE OF  DEBT TO INCOME --

select round(avg(dti)*100,2) as Avg_DTI from bank_loan_data ;

--  ( MOnth_To_Date) --

select round(avg(dti)*100,2) as Avg_DTI from bank_loan_data 
where extract (month from issue_date) = 12
and extract (year from issue_date) = 2021 ;


--- GOOG LOAN --

select
    round((count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100)/
    count(id)) as good_loan_ercetage
from bank_loan_data ;

-- Good Loan Applications--

select count(loan_status) as Total_Good_Loan_Applications from bank_loan_data
where loan_status in ('Fully Paid','Current') ;

-- Good Loan Funded Amount--

select sum(loan_amount) as Total_Good_Loan_Funded_Amount from bank_loan_data
where loan_status in ('Fully Paid','Current') ;




-- BAD LOAN --

select
    round((count(case when loan_status = 'Charged Off' then id end)*100)/
    count(id))||'%' as good_loan_ercetage
from bank_loan_data ;

-- Bad Loan Applications--

select count(loan_status) as Bad_Good_Loan_Applications from bank_loan_data
where loan_status = 'Charged Off' ;

-- Bad Loan Funded Amount--

select sum(loan_amount) as Bad_Good_Loan_Funded_Amount from bank_loan_data
where loan_status = 'Charged Off' ;





-- LOAN STATUS -- 

select
    loan_status,
    count(id) as LoanCount,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_Recieved_Amount,
    avg(int_rate) * 100 as Interest_Rate,
    avg(dti) * 100 as DTI
from
    bank_loan_data
group by
    loan_status ;
    
    
    
    
-- MONTHLY VIEW -- 

select
    to_char (issue_date,'Month') as Month_name,
    count(id) as Total_Loan_Appications,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_Recieved_Amount
from
    bank_loan_data
group by
    to_char (issue_date,'Month') 
order by
    to_date (to_char(issue_date,'Month'),'Month') desc ;
    
    
    

--  VIEW BY ADDRESS STATE -- 

select
    address_state,
    count(id) as Total_Loan_Appications,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_Recieved_Amount
from
    bank_loan_data
group by
    address_state
order by
    count(id) desc ;
    
    
    
--  VIEW BY TERM  -- 

select
    term,
    count(id) as Total_Loan_Appications,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_Recieved_Amount
from
    bank_loan_data
group by
    term
order by
    term ;
    
    
    
    
--  VIEW BY PURPOSE  -- 

select
    purpose,
    count(id) as Total_Loan_Appications,
    sum(loan_amount) as Total_Funded_Amount,
    sum(total_payment) as Total_Recieved_Amount
from
    bank_loan_data
group by
    purpose
order by
    count(id) desc ;
