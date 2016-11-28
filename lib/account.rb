
class Account

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def make_transaction(amount)
    @balance += amount
  end

end
