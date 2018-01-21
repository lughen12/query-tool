require 'require_all'

require_all 'models'

describe NinetySeconds::Models::User do
  subject { NinetySeconds::Models::User }

  describe 'class variables' do
    it 'return correct value' do
      expect(subject::FILE_PATH).to eq 'data/users.json'
    end
  end
end
