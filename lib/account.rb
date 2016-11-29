require_relative 'statement'
require 'time'

class Account

  attr_reader :balance, :transactions_log

  def initialize(starting_balance = 0)
    @balance = starting_balance
    @transactions_log = Hash.new
    @start_date = Time.new
    @statement_class = Statement
  end

  def make_transaction(amount, time=Time.now)
    unless @start_date > time
      @balance += amount
      add_transaction_to_log(amount, time)
    else
      puts 'Cannot make apply transaction dated prior to account creation'
    end
  end

  def add_transaction_to_log(amount, time)
    check_date_time_format(time)
    @transactions_log[time] = amount
  end

  def set_up_statement(start_date = @start_date, end_date = Time.new)
    check_date_time_format(start_date)
    check_date_time_format(end_date)
    statement_hash = @transactions_log.select do | key, value|
      key >= start_date && key <= end_date
    end
    create_statement_object(@statement_class, statement_hash)
    statement_hash
  end

  def check_date_time_format(time_to_check)
    if time_to_check.class == String
      Time.parse(time_to_check)
    else
      time_to_check
    end
  end

  def create_statement_object(statement_class, statement_hash)
    duplicate_statement_hash = statement_hash.dup
    statement = @statement_class.new(duplicate_statement_hash, @balance)
    statement.create_statement
  end

end
