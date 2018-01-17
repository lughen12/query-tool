require 'require_all'

require_all 'presenters'

describe NinetySeconds::Presenters::JsonPresenter do
  subject { NinetySeconds::Presenters::JsonPresenter }
  describe '#present' do
    context 'when valid hash' do
      it 'return json format' do
        object = { key: 'value', key_2: 'value 2'}
        expect(subject.present(object)).to eq(
          "{\n  \"key\": \"value\",\n  \"key_2\": \"value 2\"\n}"
        )
      end
    end

    context 'when not a hash' do
      it 'return itself' do
        object = '<xml></xml>'
        expect(subject.present(object)).to eq('"<xml></xml>"')
      end
    end

    context 'when nil' do
      it 'return empty' do
        expect(subject.present(nil)).to eq('')
      end
    end
  end

end
