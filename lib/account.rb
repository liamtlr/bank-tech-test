require_relative 'statement'
require 'time'

class Account

  attr_reader :balance, :transactions_log

  OVERDRAFT_LIMIT = 0

  def initialize(starting_balance = 0, start_date = Time.new)
    @starting_balance = starting_balance
    @balance = starting_balance
    @transactions_log = Hash.new
    @start_date = check_date_time_format(start_date)
    @statement_class = Statement
  end

  def make_transaction(amount, date=Time.new)
    if valid_date?(date) && valid_transaction?(amount)
      @balance += amount
      add_transaction_to_log(amount, date)
    else
      raise 'The transaction was declined'
    end
  end

  def request_statement(start_date = @start_date, end_date = Time.new)
    start_date = check_date_time_format(start_date)
    end_date = check_date_time_format(end_date)
    create_statement_hash(start_date, end_date)
  end

  def request_balance
    puts @balance
  end

  private


  def valid_date?(date)
    formatted_date = check_date_time_format(date)
    @start_date <= formatted_date
  end

  def valid_transaction?(amount)
    (amount + @balance) >= (0 + OVERDRAFT_LIMIT)
  end

  def add_transaction_to_log(amount, date)
    formatted_date = check_date_time_format(date)
    @transactions_log[formatted_date] = amount
  end

  def check_date_time_format(time_to_check)
    if time_to_check.class == String
      date = Time.parse(time_to_check)
      time = Time.now
      date_time = Time.new(date.year, date.month, date.day, time.hour, time.min, time.sec)
    else
      time_to_check
    end
  end

  def create_statement_hash(start_date,end_date)
    statement_hash = @transactions_log.select do | key, value|
      key >= start_date && key <= end_date
    end
    calculate_starting_balance(statement_hash, start_date)
  end

  def calculate_starting_balance(statement_hash, start_date)
    previous_statements_hash = @transactions_log.select do | key, value|
      key < start_date
    end
    interim_balance = previous_statements_hash.values.inject(:+)
    unless interim_balance.nil?
      starting_balance = interim_balance + @starting_balance
    else
      starting_balance = @starting_balance
    end
    create_statement_object(statement_hash, starting_balance)
  end

  def create_statement_object(statement_hash, starting_balance)
    duplicate_statement_hash = statement_hash.dup
    statement = @statement_class.new(duplicate_statement_hash, starting_balance)
    statement.calculate_running_total
  end

end
