module ModelHelper
  shared_examples 'invalid' do
    it 'is invalid' do
      expect(record).not_to be_valid
    end
  end
end