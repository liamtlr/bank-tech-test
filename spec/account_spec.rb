require 'account'
require 'timecop'

describe Account do

  subject { described_class.new }

  describe '#initialization' do
    it 'initializes with zero balance when nothing is passed' do
      expect(subject.balance).to eq 0
    end
    it 'initializes with a start balance when a value is passed' do
      account = Account.new(40)
      expect(account.balance).to eq 40
    end
    it 'initializes an empty transactions hash' do
      expect(subject.transactions_log).to eq Hash.new
    end
  end

  describe '#make_transaction' do
    before do
      subject.make_transaction(5)
    end
    it 'applies a credit to the balance when passed a positive integer' do
      subject.make_transaction(20)
      expect(subject.balance).to eq 25
    end
    it 'applies a debit to the balance when passed a negative integer' do
      subject.make_transaction(-5)
      expect(subject.balance).to eq 0
    end
    it 'specifies a date when passed one' do
      time = Timecop.freeze(Time.now)
      allow(subject).to receive(:check_date_time_format).with(time)
      subject.make_transaction(-5, time)
      expect(subject.transactions_log).to include({time=>-5})
    end
    it " does not allows transactions to be made specifying a date before the account's start date" do
      expect{subject.make_transaction(20, "01/01/1900")}.to raise_error(RuntimeError)
    end
    it " does not allows transactions to be that would result in a negative balance" do
      expect{subject.make_transaction(-20)}.to raise_error(RuntimeError)
    end
  end

  # describe '#add_transaction_to_log' do
  #   it 'pushes the transaction and a timestamp to the transactions log hash' do
  #     time = Timecop.freeze(Time.now)
  #     allow(subject).to receive(:check_date_time_format).with(time) {"05-01-2017"}
  #     subject.add_transaction_to_log(5, time)
  #     expect(subject.transactions_log).to include({"05-01-2017"=>5})
  #   end
  # end
  #
  # describe '#check_date_time_format' do
  #   it 'does nothing to a time object' do
  #     time = Timecop.freeze(Time.now)
  #     expect(subject.check_date_time_format(time)).to eq time
  #   end
  #   it 'converts a string date to a date object' do
  #     expect(subject.check_date_time_format("20-02-2000")).to eq Time.parse("20-02-2000")
  #   end
  # end


  describe '#request' do
    it 'provides a new hash based on the dates provided' do
      account = Account.new(400, "14/02/2015")
      account.make_transaction(-300, '15/02/2015')
      account.make_transaction(-300, '17/02/2015')
      expect(account.request_statement('16-02-2016')).length.to eq(1)
    end
  end


end
