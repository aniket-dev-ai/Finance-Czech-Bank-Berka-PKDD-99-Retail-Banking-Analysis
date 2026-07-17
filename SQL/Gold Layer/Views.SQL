create view gold.customer_360 as
select
  c.customer_id,
  c.first_name,
  c.last_name,
  c.email,
  c.city,
  c.credit_score,
  c.created_at,
  COUNT(distinct a.account_id) as total_accounts,
  SUM(a.balance_usd) as total_balance_usd,
  COUNT(distinct l.loan_id) as total_loans,
  SUM(l.loan_amount) as total_loan_amount
from
  silver.customers c
  left join silver.accounts a on a.customer_id = c.customer_id
  left join silver.loans l on l.customer_id = c.customer_id
group by
  c.customer_id,
  c.first_name,
  c.last_name,
  c.email,
  c.city,
  c.credit_score,
  c.created_at;

create view gold.transactions as
select
  t.transaction_id,
  t.transaction_date,
  t.amount_usd,
  a.account_id,
  a.account_type,
  a.customer_id,
  c.first_name,
  c.last_name,
  c.city as customer_city,
  c.credit_score,
  m.merchant_id,
  m.merchant_name,
  m.city as merchant_city
from
  silver.transactions t
  join silver.accounts a on t.account_id = a.account_id
  join silver.customers c on a.customer_id = c.customer_id
  left join silver.merchants m on t.merchant_id = m.merchant_id;

DROP VIEW IF EXISTS gold.cards;

create view gold.cards as
select
  cd.card_id,
  cd.card_type,
  cd.expiration_date,
  a.account_id,
  a.account_type,
  a.customer_id,
  c.first_name,
  c.last_name
from
  silver.cards cd
  join silver.accounts a on cd.account_id = a.account_id
  join silver.customers c on a.customer_id = c.customer_id;

create view gold.loan_portfolio as
select
  l.loan_id,
  l.loan_amount,
  l.interest_rate,
  l.start_date,
  c.customer_id,
  c.first_name,
  c.last_name,
  c.city as customer_city,
  c.credit_score,
  case
    when c.credit_score >= 750 then 'Excellent'
    when c.credit_score >= 700 then 'Good'
    when c.credit_score >= 650 then 'Fair'
    else 'Poor'
  end as credit_band
from
  silver.loans l
  join silver.customers c on l.customer_id = c.customer_id;

create view gold.loan_summary as
select
  case
    when c.credit_score >= 750 then 'Excellent'
    when c.credit_score >= 700 then 'Good'
    when c.credit_score >= 650 then 'Fair'
    else 'Poor'
  end as credit_band,
  c.city as customer_city,
  COUNT(*) as loan_count,
  SUM(l.loan_amount) as total_loan_amount,
  AVG(l.interest_rate) as avg_interest_rate
from
  silver.loans l
  join silver.customers c on l.customer_id = c.customer_id
group by
  case
    when c.credit_score >= 750 then 'Excellent'
    when c.credit_score >= 700 then 'Good'
    when c.credit_score >= 650 then 'Fair'
    else 'Poor'
  end,
  c.city;