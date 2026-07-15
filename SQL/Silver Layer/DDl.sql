CREATE TABLE silver.accounts (
    account_id      VARCHAR(50),
    customer_id     VARCHAR(50),
    account_type    VARCHAR(50),
    balance_usd     NUMERIC(12,2),
    open_date       DATE
);

CREATE TABLE silver.branches (
    branch_id      VARCHAR(20),
    branch_name    VARCHAR(100),
    manager_name   VARCHAR(100)
);

CREATE TABLE silver.cards (
    card_id          VARCHAR(20),
    account_id       VARCHAR(20),
    card_type        VARCHAR(20),
    expiration_date  DATE
);

CREATE TABLE silver.customers (
    customer_id     VARCHAR(20),
    first_name      VARCHAR(50),
    last_name       VARCHAR(50),
    email           VARCHAR(100),
    city            VARCHAR(100),
    credit_score    INT,
    created_at      DATE
);

CREATE TABLE silver.loans (
    loan_id         VARCHAR(20),
    customer_id     VARCHAR(20),
    loan_amount     NUMERIC(12,2),
    interest_rate   NUMERIC(5,2),
    start_date      DATE
);

CREATE TABLE silver.merchants (
    merchant_id      VARCHAR(20),
    merchant_name    VARCHAR(150),
    city             VARCHAR(100)
);