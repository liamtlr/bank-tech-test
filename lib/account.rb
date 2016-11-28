
class Account

  attr_reader :balance, :transactions_log

  def initialize
    @balance = 0
    @transactions_log = Hash.new
  end

  def make_transaction(amount)
    @balance += amount
    @transactions_log[format_time] = amount
  end

  def format_time
    Time.new.strftime("%d-%b-%Y")
  end

end
