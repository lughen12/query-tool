require 'require_all'

require_all 'models'

describe NinetySeconds::Models::Base do
  subject { NinetySeconds::Models::Base }

  describe '#all' do
    before do
      stub_const('NinetySeconds::Models::Base::FILE_PATH', 'path')
    end

    it 'read file and parse json' do
      expect(File).to receive(:read).with('path').and_return('file')
      expect(JSON).to receive(:parse).with('file').and_return(['something'])
      expect(subject.all).to eq ['something']
    end

    context 'when parse error' do
      it 'return empty array' do
        expect(File).to receive(:read).with('path').and_return('file')
        expect(JSON).to receive(:parse).with('file').and_raise(JSON::ParserError)
        expect(subject.all).to eq []
      end
    end
  end

  describe '#where' do
    let(:all) do
      [
        {
          'name' => 'Le Hung'
        },
        {
          'name' => 'Sergio Aguero'
        },
        {
          'name' => 'David Silva'
        },
        {
          'name' => 'Gabriel Jesus'
        }
      ]
    end

    before do
      allow(subject).to receive(:all).and_return(all)
    end

    context 'when valid options' do
      it 'return correct values' do
        results = subject.where(name: 'Le Hung')
        expect(results).to eq all[0..0]
      end
    end

    context 'when there is unkown param' do
      it 'return empty' do
        results = subject.where(name: 'Le Hung',
                                random: 'random')
        expect(results).to eq []
      end
    end

    context 'when no options' do
      it 'return all valid records' do
        results = subject.where({})
        expect(results).to eq all
      end
    end

    context 'when there is limit' do
      it 'return only limit number of records' do
        results = subject.where({}, limit: 2)
        expect(results).to eq all[0..1]
      end
    end

    context 'when there is offset' do
      it 'return only limit number of records from offset' do
        results = subject.where({}, limit: 2, offset: 1)
        expect(results).to eq all[1..2]
      end
    end
  end

  describe '#safe_compare_string' do
    context 'when compare with a string' do
      context 'and match' do
        it 'return true' do
          is_equal = subject.safe_compare_string('text', 'text')
          expect(is_equal).to eq true
        end
      end

      context 'and not match' do
        it 'return false' do
          is_equal = subject.safe_compare_string('text', 'random')
          expect(is_equal).to eq false
        end
      end
    end

    context 'when compare with a number' do
      context 'and match' do
        it 'return true' do
          is_equal = subject.safe_compare_string('2', 2)
          expect(is_equal).to eq true
        end
      end

      context 'and not match' do
        it 'return false' do
          is_equal = subject.safe_compare_string('2', 3)
          expect(is_equal).to eq false
        end
      end
    end

    context 'when compare with a boolean' do
      context 'and match' do
        it 'return true' do
          is_equal = subject.safe_compare_string('false', false)
          expect(is_equal).to eq true
        end
      end

      context 'and not match' do
        it 'return false' do
          is_equal = subject.safe_compare_string('false', true)
          expect(is_equal).to eq false
        end
      end
    end

    context 'when compare with an array' do
      context 'and array includes string' do
        it 'return true' do
          is_equal = subject.safe_compare_string('text', %w[text text2])
          expect(is_equal).to eq true
        end
      end

      context 'and array does not include stringh' do
        it 'return false' do
          is_equal = subject.safe_compare_string('random', %w[text text2])
          expect(is_equal).to eq false
        end
      end
    end

    context 'when compare with nil' do
      it 'return false' do
        is_equal = subject.safe_compare_string('random', nil)
        expect(is_equal).to eq false
      end
    end
  end
end
