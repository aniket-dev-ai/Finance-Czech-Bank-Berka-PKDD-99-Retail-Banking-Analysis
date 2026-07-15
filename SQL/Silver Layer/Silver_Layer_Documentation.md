# Silver Layer — Data Cleaning & Standardization

> **Purpose:** Transform raw Bronze data into analytics-ready, standardized, and validated datasets while preserving the original source data.

------------------------------------------------------------------------

## Architecture Overview

> **Image Placeholder**

![Silver Layer Overview](./Silver%20Layer%20Overview.png)

------------------------------------------------------------------------

## ✨ Silver Layer Objectives

- Standardize raw data
- Remove duplicate records
- Validate business rules
- Handle missing values
- Normalize text fields
- Validate numeric and date values
- Prepare clean datasets for the Gold Layer

------------------------------------------------------------------------

## 📊 Cleaning Checklist

| Category | Applied |
|---|:---:|
| Remove duplicate rows | ✅ |
| Trim whitespace | ✅ |
| Remove blank primary keys | ✅ |
| Remove blank foreign keys | ✅ |
| Standardize text casing | ✅ |
| Handle missing values | ✅ |
| Validate numeric ranges | ✅ |
| Validate dates | ✅ |
| Validate string length | ✅ |
| Email validation | ✅ |
| Standardize categorical values | ✅ |
| Replace invalid values | ✅ |

------------------------------------------------------------------------

## 🏦 Accounts

### Transformations

- Trimmed Account ID and Customer ID
- Removed blank primary/foreign keys
- Standardized Account Type
- Replaced NULL balances with `0`
- Prevented negative balances
- Corrected future dates
- Removed duplicate rows

------------------------------------------------------------------------

## 🏢 Branches

### Transformations

- Trimmed Branch ID
- Standardized Branch Name
- Standardized Manager Name
- Replaced missing values
- Removed duplicates

------------------------------------------------------------------------

## 💳 Cards

### Transformations

- Trimmed IDs
- Standardized Card Type
- Handled missing expiration dates
- Removed duplicate records

------------------------------------------------------------------------

## 👤 Customers

### Transformations

- Standardized names
- Validated email format
- Converted email to lowercase
- Validated Credit Score (300–850)
- Replaced missing values
- Corrected future dates
- Removed duplicates

------------------------------------------------------------------------

## 💰 Loans

### Transformations

- Trimmed IDs
- Prevented negative loan amounts
- Restricted interest rate (0–100%)
- Corrected future dates
- Removed duplicates

------------------------------------------------------------------------

## 🏪 Merchants

### Transformations

- Standardized Merchant Name
- Standardized City
- Replaced missing values
- Removed duplicate rows

------------------------------------------------------------------------

## 🎯 Silver Layer Output

The Silver Layer produces high-quality, standardized datasets that are:

- ✅ Clean
- ✅ Consistent
- ✅ Validated
- ✅ Deduplicated
- ✅ Analytics Ready

These datasets become the trusted source for dimensional modeling and business reporting in the Gold Layer.

------------------------------------------------------------------------