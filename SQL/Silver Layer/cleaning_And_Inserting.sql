INSERT INTO silver.accounts (
    account_id,
    customer_id,
    account_type,
    balance_usd,
    open_date
)

SELECT DISTINCT

    /* Primary Key Cleaning */
    NULLIF(TRIM(account_id), '') AS account_id,

    /* Foreign Key Cleaning */
    NULLIF(TRIM(customer_id), '') AS customer_id,

    /* Standardize Account Type */
    CASE
        WHEN LOWER(TRIM(account_type)) IN ('saving','savings') THEN 'Savings'
        WHEN LOWER(TRIM(account_type)) = 'current' THEN 'Current'
        WHEN LOWER(TRIM(account_type)) = 'business' THEN 'Business'
        WHEN LOWER(TRIM(account_type)) = 'loan' THEN 'Loan'
        ELSE 'Unknown'
    END AS account_type,

    /* Numeric Validation */
    CASE
        WHEN balance_usd IS NULL THEN 0
        WHEN balance_usd < 0 THEN 0
        ELSE ROUND(balance_usd,2)
    END AS balance_usd,

    /* Date Validation */
    CASE
        WHEN open_date IS NULL THEN CURRENT_DATE
        WHEN open_date > CURRENT_DATE THEN CURRENT_DATE
        ELSE open_date
    END AS open_date

FROM bronze.accounts

WHERE
    /* Remove Empty Rows */
    account_id IS NOT NULL
    AND customer_id IS NOT NULL

    /* Remove Blank Keys */
    AND TRIM(account_id) <> ''
    AND TRIM(customer_id) <> ''

    /* Remove Invalid String Lengths */
    AND LENGTH(TRIM(account_id)) <= 50
    AND LENGTH(TRIM(customer_id)) <= 50

    /* Remove Impossible Balances */
    AND (balance_usd IS NULL OR balance_usd >= 0);

INSERT INTO silver.branches (
    branch_id,
    branch_name,
    manager_name
)

SELECT DISTINCT

    /* Primary Key Cleaning */
    NULLIF(TRIM(branch_id), '') AS branch_id,

    /* Branch Name Cleaning */
    CASE
        WHEN branch_name IS NULL OR TRIM(branch_name) = '' THEN 'Unknown Branch'
        ELSE INITCAP(TRIM(branch_name))
    END AS branch_name,

    /* Manager Name Cleaning */
    CASE
        WHEN manager_name IS NULL OR TRIM(manager_name) = '' THEN 'Unassigned'
        ELSE INITCAP(TRIM(manager_name))
    END AS manager_name

FROM bronze.branches

WHERE
    branch_id IS NOT NULL
    AND TRIM(branch_id) <> ''
    AND LENGTH(TRIM(branch_id)) <= 20;


INSERT INTO silver.cards (
    card_id,
    account_id,
    card_type,
    expiration_date
)

SELECT DISTINCT

    /* Primary Key */
    NULLIF(TRIM(card_id), '') AS card_id,

    /* Foreign Key */
    NULLIF(TRIM(account_id), '') AS account_id,

    /* Card Type Standardization */
    CASE
        WHEN LOWER(TRIM(card_type)) = 'visa' THEN 'Visa'
        WHEN LOWER(TRIM(card_type)) = 'mastercard' THEN 'MasterCard'
        WHEN LOWER(TRIM(card_type)) = 'rupay' THEN 'RuPay'
        WHEN LOWER(TRIM(card_type)) = 'amex' THEN 'Amex'
        ELSE 'Unknown'
    END AS card_type,

    /* Expiration Date Validation */
    CASE
        WHEN expiration_date IS NULL THEN CURRENT_DATE
        ELSE expiration_date
    END AS expiration_date

FROM bronze.cards

WHERE
    card_id IS NOT NULL
    AND account_id IS NOT NULL

    AND TRIM(card_id) <> ''
    AND TRIM(account_id) <> ''

    AND LENGTH(TRIM(card_id)) <= 20
    AND LENGTH(TRIM(account_id)) <= 20;


INSERT INTO silver.cards (
    card_id,
    account_id,
    card_type,
    expiration_date
)

SELECT DISTINCT

    /* Primary Key */
    NULLIF(TRIM(card_id), '') AS card_id,

    /* Foreign Key */
    NULLIF(TRIM(account_id), '') AS account_id,

    /* Card Type Standardization */
    CASE
        WHEN LOWER(TRIM(card_type)) = 'visa' THEN 'Visa'
        WHEN LOWER(TRIM(card_type)) = 'mastercard' THEN 'MasterCard'
        WHEN LOWER(TRIM(card_type)) = 'rupay' THEN 'RuPay'
        WHEN LOWER(TRIM(card_type)) = 'amex' THEN 'Amex'
        ELSE 'Unknown'
    END AS card_type,

    /* Expiration Date Validation */
    CASE
        WHEN expiration_date IS NULL THEN CURRENT_DATE
        ELSE expiration_date
    END AS expiration_date

FROM bronze.cards

WHERE
    card_id IS NOT NULL
    AND account_id IS NOT NULL

    AND TRIM(card_id) <> ''
    AND TRIM(account_id) <> ''

    AND LENGTH(TRIM(card_id)) <= 20
    AND LENGTH(TRIM(account_id)) <= 20;

INSERT INTO silver.customers (
    customer_id,
    first_name,
    last_name,
    email,
    city,
    credit_score,
    created_at
)

SELECT DISTINCT

    /* Primary Key */
    NULLIF(TRIM(customer_id), '') AS customer_id,

    /* First Name */
    CASE
        WHEN first_name IS NULL OR TRIM(first_name) = '' THEN 'Unknown'
        ELSE INITCAP(TRIM(first_name))
    END AS first_name,

    /* Last Name */
    CASE
        WHEN last_name IS NULL OR TRIM(last_name) = '' THEN 'Unknown'
        ELSE INITCAP(TRIM(last_name))
    END AS last_name,

    /* Email */
    CASE
        WHEN email IS NULL THEN NULL
        WHEN TRIM(email) ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
            THEN LOWER(TRIM(email))
        ELSE NULL
    END AS email,

    /* City */
    CASE
        WHEN city IS NULL OR TRIM(city) = '' THEN 'Unknown'
        ELSE INITCAP(TRIM(city))
    END AS city,

    /* Credit Score Validation */
    CASE
        WHEN credit_score IS NULL THEN 300
        WHEN credit_score < 300 THEN 300
        WHEN credit_score > 850 THEN 850
        ELSE credit_score
    END AS credit_score,

    /* Created Date */
    CASE
        WHEN created_at IS NULL THEN CURRENT_DATE
        WHEN created_at > CURRENT_DATE THEN CURRENT_DATE
        ELSE created_at
    END AS created_at

FROM bronze.customers

WHERE
    customer_id IS NOT NULL
    AND TRIM(customer_id) <> ''
    AND LENGTH(TRIM(customer_id)) <= 20;

INSERT INTO silver.loans (
    loan_id,
    customer_id,
    loan_amount,
    interest_rate,
    start_date
)

SELECT DISTINCT

    /* Loan ID */
    NULLIF(TRIM(loan_id), '') AS loan_id,

    /* Customer ID */
    NULLIF(TRIM(customer_id), '') AS customer_id,

    /* Loan Amount */
    CASE
        WHEN loan_amount IS NULL THEN 0
        WHEN loan_amount < 0 THEN 0
        ELSE ROUND(loan_amount,2)
    END AS loan_amount,

    /* Interest Rate */
    CASE
        WHEN interest_rate IS NULL THEN 0
        WHEN interest_rate < 0 THEN 0
        WHEN interest_rate > 100 THEN 100
        ELSE ROUND(interest_rate,2)
    END AS interest_rate,

    /* Start Date */
    CASE
        WHEN start_date IS NULL THEN CURRENT_DATE
        WHEN start_date > CURRENT_DATE THEN CURRENT_DATE
        ELSE start_date
    END AS start_date

FROM bronze.loans

WHERE
    loan_id IS NOT NULL
    AND customer_id IS NOT NULL
    AND TRIM(loan_id) <> ''
    AND TRIM(customer_id) <> ''
    AND LENGTH(TRIM(loan_id)) <= 20
    AND LENGTH(TRIM(customer_id)) <= 20;

INSERT INTO silver.merchants (
    merchant_id,
    merchant_name,
    city
)

SELECT DISTINCT

    /* Merchant ID */
    NULLIF(TRIM(merchant_id), '') AS merchant_id,

    /* Merchant Name */
    CASE
        WHEN merchant_name IS NULL OR TRIM(merchant_name) = '' THEN 'Unknown Merchant'
        ELSE INITCAP(TRIM(merchant_name))
    END AS merchant_name,

    /* City */
    CASE
        WHEN city IS NULL OR TRIM(city) = '' THEN 'Unknown'
        ELSE INITCAP(TRIM(city))
    END AS city

FROM bronze.merchants

WHERE
    merchant_id IS NOT NULL
    AND TRIM(merchant_id) <> ''
    AND LENGTH(TRIM(merchant_id)) <= 20;