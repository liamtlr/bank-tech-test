require 'account'
require 'timecop'

describe Account do

  subject { described_class.new }


  describe '#initialization' do
    it 'initializes with zero balance' do
      expect(subject.balance).to eq 0
    end
    it 'initializes an emtpy transactions hash' do
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
  end

  describe '#add_transaction_to_log' do
    it 'pushes the transaction and a timestamp to the transactions log hash' do
      time = Timecop.freeze(Time.now)
      allow(subject).to receive(:check_date_time_format).with(time) {"05-01-2017"}
      subject.add_transaction_to_log(5, time)
      expect(subject.transactions_log).to include({time=>5})
    end
    it 'allows a date to be specified if the transaction is not made now' do
      subject.add_transaction_to_log(5, '01-01-1911')
      expect(subject.transactions_log).to include({'01-01-1911'=>5})
    end

    describe '#check_date_time_format' do
      it 'does nothing to a time object' do
        time = Timecop.freeze(Time.now)
        expect(subject.check_date_time_format(time)).to eq time
      end
      it 'converts a string date to a date object' do
        expect(subject.check_date_time_format("20-02-2000")).to eq Time.parse("20-02-2000")
      end
    end

  end

  describe '#set_up_statement' do
    before do

    end
    it 'provides a new hash based on the dates provided' do
      account = Account.new
      transaction_amount = 10
      transaction_1_date = "12-02-2016"
      transaction_2_date = "14-02-2016"

      account.make_transaction(transaction_amount, transaction_1_date)
      account.add_transaction_to_log(transaction_amount, transaction_1_date)
      account.make_transaction(transaction_amount, transaction_2_date)
      account.add_transaction_to_log(transaction_amount, transaction_1_date)
      puts account.check_date_time_format(transaction_1_date)
      expect(account.set_up_statement('11-02-2016', '13-02-2016')).to eq({ Time.parse("12-02-2016")=>10})

    end
  end


end
