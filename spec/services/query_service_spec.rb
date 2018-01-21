require 'require_all'

require_all 'services'

describe NinetySeconds::Services::QueryService do
  subject { NinetySeconds::Services::QueryService }
  let(:query_service) { subject.new(resource: 'user') }

  describe '#valid?' do
    context 'when valid' do
      it 'return true' do
        expect(query_service.valid?).to eq true
      end
    end

    context 'when invalid resource' do
      let(:query_service) { subject.new(resource: 'random') }
      it 'return false' do
        expect(query_service.valid?).to eq false
      end
    end

    context 'when resource is nill' do
      let(:query_service) { subject.new(resource: nil) }
      it 'return false' do
        expect(query_service.valid?).to eq false
      end
    end

    context 'when invalid format' do
      let(:query_service) { subject.new(resource: 'random', format: 'wrong') }
      it 'return false' do
        expect(query_service.valid?).to eq false
      end
    end

    context 'when invalid query format' do
      let(:query_service) { subject.new(resource: 'random', queries: ['wrong']) }
      it 'return false' do
        expect(query_service.valid?).to eq false
      end
    end
  end

  describe '#presenter' do
    context 'when valid format' do
      it 'return correct presenter' do
        expect(subject.new(resource: 'user', format: 'text').presenter)
          .to eq NinetySeconds::Presenters::TextPresenter
        expect(subject.new(resource: 'user', format: 'json').presenter)
          .to eq NinetySeconds::Presenters::JsonPresenter
      end
    end

    context 'when invalid format' do
      it 'return nil' do
        expect(subject.new(resource: 'user', format: 'aa').presenter).to be_nil
      end
    end
  end

  describe '#execute' do
    let(:query_service) do
      subject.new(
        resource: 'user',
        queries: ['key=val', 'key2=val2'],
        limit: 10,
        offset: 1
      )
    end

    it 'call model #where with queries hash' do
      expect(NinetySeconds::Models::User).to receive(:where).with(
        {
          'key' => 'val',
          'key2' => 'val2'
        },
        limit: 10,
        offset: 1
      ).and_return('results')
      expect(query_service.execute).to eq 'results'
    end
  end
end
