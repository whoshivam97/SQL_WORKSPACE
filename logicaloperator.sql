select first_name, last_name, age from customer_table where age>20 And age<30; 
// TO FETCH FIRST_NAME, LAST_NAME AND AGE FROM THE TABLE WHERE AGE IS GREATER THAN 20 AND LESS THAN 30 

select * from customer_table where not age=25 AND   not first_name= 'Jay';  
// TO FETCH ALL THE COLUMNS FROM THE TABLE WHERE AGE IS NOT 25 AND FIRST_NAME IS NOT 'Jay'