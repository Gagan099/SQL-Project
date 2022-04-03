create  database Bank_Marketing1;

 use Bank_Marketing1;
 
 select * from  Bank;
 
 #data Job wise
select job,count(job) as totalJB from bank
group by job;

# Data_Marital status wise
select Marital,count(Marital) as cnt from bank
group by Marital;

#Data_Education
select Education,count(Education) as cnt from bank
group by Education;


#How many peopel had a defula credit
select Defaults,count(defaults) as cnt from bank
group by defaults;

# How many people as taken houseing loan 
 select housing,count(housing) as cnt from bank
group by housing;

#How many people had taken personal loan
select loan,count(loan) as cnt from bank
group by loan;

#Mode of communication
select contact,count(contact) as cnt from bank
group by contact;

#Data by months
select Month,count(Month) as cnt from bank
group by Month;

#Data by days
select day,count(day) as cnt from bank
group by day;

#outcome of the previous marketing campaign
select Poutcome,count(Poutcome) as cnt from bank
group by Poutcome;

#outcome of the balance
select balance,count(balance) as cnt from bank
group by balance;

#number of days that passed by after the client was last contacted from a previous campaign
select pdays,count(pdays) as cnt from bank
group by Pdays;

#number of contacts performed during this campaign and for this client
select campaign,count(campaign) as cnt from bank
group by campaign;

#number of contacts performed before this campaign and for this client
select previous,count(previous) as cnt from bank
group by previous;


select * from bank;

# Values for deposits
select deposit,count(deposit) from bank
group by deposit;

# Values Job tilte wise and people who have made the deposit
select job,count(job) as yes from bank
where deposit ="yes"
group by job
order by count(job);

# Values Job tilte wise and people who have not made the deposit
select job,count(job) as "No" from bank
where deposit ="No"
group by job
order by count(job);

# Values Marital status wise and people who have made the deposit
select marital, deposit,count(marital) from bank
where deposit ="Yes"
group by marital;


# Values Marital status wise and people who have not made the deposit
select marital, deposit,count(marital) from bank
where deposit="No"
group by marital;


# Values  eduation status wise and people who have made the deposit
select education, deposit,count(education) from bank
where deposit="yes"
group by education;

# Values  eduation status wise and people who have not made the deposit
select education, deposit,count(education) from bank
where deposit="No"
group by education;

select * from bank;

# Values  contact status wise and people who have not made the deposit
select contact, deposit,count(contact) from bank
where deposit="Yes"
group by contact;

# Values  contact status wise and people who have not made the deposit
select contact, deposit,count(contact) from bank
where deposit="No"
group by contact;

select contact, deposit,count(*) as totalcnt, count(if(deposit="Yes",1,0)) as Yes, count(if(deposit="No",1,0)) as "No"
from bank;




# Balance depost 
	select balance,deposit,count(balance),avg(balance),min(balance),max(balance) from bank
    where deposit ="Yes"
	group by deposit;
    
    select balance,deposit,count(balance),avg(balance),min(balance),max(balance) from bank
    where deposit ="No"
	group by deposit;
    
# Age wise deposite    
select age,deposit,count(age),avg(age),min(age),max(age) from bank
where deposit="Yes"
	group by age;   


select age,deposit,count(age),avg(age),min(age),max(age) from bank
where deposit="No"
	group by age;    
 
 #number of contacts performed during previous campaign ('previous') and deposit
select previous,deposit,count(previous),avg(previous),min(previous),max(previous) from bank
where deposit="yes"
group by Previous;   
    
select previous,deposit,count(previous),avg(previous),min(previous),max(previous) from bank
where deposit="No"
group by Previous;     


#Number of contacts performed during this campaign and deposit statistics
select campaign,deposit,stddev(count(campaign))as stdv,avg(campaign),min(campaign),max(campaign) from bank
where deposit="No" 
group by campaign;   

select campaign,deposit,count(campaign),avg(campaign),min(campaign),max(campaign) from bank
where deposit="Yes"
group by campaign; 





