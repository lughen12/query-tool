require 'require_all'

require_all 'models'

describe NinetySeconds::Models::Project do
  subject { NinetySeconds::Models::Project }

  describe 'class variables' do
    it 'return correct value' do
      expect(subject::FILE_PATH).to eq 'data/projects.json'
    end
  end
end
