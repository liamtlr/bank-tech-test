# Bank Tech Test

## Setup

* Clone this repo

```
git clone https://github.com/wirsindpapst/bank-tech-test.git

```
* Open your REPL of choice, requiring the account.rb file:

```
irb -r ./lib/account.rb
```

## Using the programme

1) Create account

The account can be created with an optional start balance and date (in the format DD/MM/YYYY), if these are left blank they will be set to zero and today's date respectively

```
account_name = Account.new(start_balance, start_date)
```

2) Make a transaction

Credits and can be made as follows

```
account_name.make_transaction(value)
```
Debits can be made in a similar fashion by using using a negative integer

3) Viewing statements

Tailored statements can be provided by specifying the dates (format DD/MM/YYYY) for which you wish to see transactions (if no dates are provided all transactions will be displayed)

```
account_name.request_statement(start_date, end_date)
```
