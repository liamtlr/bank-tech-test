class Statement

  def initialize(statement_hash, starting_balance)
    @statement_hash = statement_hash
    @balance = starting_balance
    @running_balance = []
  end

  def calculate_running_total
    @statement_hash = @statement_hash.sort.to_h
    @statement_hash.each do |key, value|
      @running_balance << @balance += value
    end
    @running_balance = @running_balance.reverse
    format_statement_hash
  end

  private

  def format_statement_hash
    @statement_hash = @statement_hash.sort.reverse.to_h
    create_statement
  end

  def format_date(time)
    time.strftime("%d-%b-%Y")
  end

  def create_statement
    puts "date       ||credit    ||debit     ||balance"
    index = 0
    @statement_hash.each do |key, value|
      key = format_date(key)
      if value < 0
        value = value * -1
        print "#{key}||          || #{value}      || #{@running_balance[index]} "
      else
        puts "#{key}|| #{value}      ||          || #{@running_balance[index]} "
      end
        index += 1
    end
  end
end
