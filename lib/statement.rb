class Statement

  def initialize(statement_hash, current_balance)
    @statement_hash = statement_hash
    @balance = current_balance
  end

  def create_statement
    puts @balance
    puts "date       ||  credit  ||  debit   ||  balance "
    @reverse_chronological_statements = @statement_hash.sort.reverse.to_h
    @reverse_chronological_statements.each do |key, value|
      # key = format_time(key)
      @balance += value
      if value < 0
        value = value * -1
        puts "#{key}||               ||#{value} || #{@balance} "
      else
        puts "#{key}||#{value} ||               || #{@balance} "
      end
    end
  end

  # def format_dates(statement_hash)
  #   statement_hash.each do |key, value|
  #     formatted_date = key.format_time
  #     formatted_date
  #   end
  # end
  #
  # def format_time(time)
  #   time.strftime("%d-%b-%Y")
  # end
end
