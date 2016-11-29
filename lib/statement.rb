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
    create_statement
  end

  private

  def create_statement
    puts "date       ||credit    ||debit     ||balance"
    reverse_chronological_statements = @statement_hash.sort.reverse.to_h
    index = 0
    reverse_chronological_statements.each do |key, value|
      key = format_date(key)
      if value < 0
        value = value * -1
        puts "#{key}||          || #{value}      || #{@running_balance[index]} "
      else
        puts "#{key}|| #{value}      ||          || #{@running_balance[index]} "
      end
        index += 1
    end
  end

  def format_date(time)
    time.strftime("%d-%b-%Y")
  end
end
