require 'account'

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
      allow(subject).to receive(:format_time) {"05-01-2017"}
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
    it 'pushes the transaction and a timestamp to the transactions log hash' do
      subject.make_transaction(5)
      expect(subject.transactions_log).to include({'05-01-2017'=>5})
    end
  end

end
