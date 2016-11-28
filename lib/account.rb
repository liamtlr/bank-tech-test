
class Account

  attr_reader :balance, :transactions_log

  def initialize
    @balance = 0
    @transactions_log = Hash.new
  end

  def make_transaction(amount)
    @balance += amount
    add_transaction_to_log(amount)
  end

  def add_transaction_to_log(amount, time=Time.now)
    if time.class == Time
      time = format_time(time)
    end
    @transactions_log[time] = amount
  end

  def format_time(time)
    time.strftime("%d-%b-%Y")
  end


end
