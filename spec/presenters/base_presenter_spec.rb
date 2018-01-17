require 'require_all'

require_all 'presenters'

describe NinetySeconds::Presenters::Base do
  subject { NinetySeconds::Presenters::Base }
  describe '#present' do
    context 'when valid hash' do
      it 'return value from to_s' do
        object = { key: 'value', key_2: 'value 2'}
        expect(subject.present(object)).to eq(
          '{:key=>"value", :key_2=>"value 2"}'
        )
      end
    end

    context 'when nil' do
      it 'return empty' do
        expect(subject.present(nil)).to eq('')
      end
    end
  end

end
