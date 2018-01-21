require 'require_all'

require_all 'services'

describe NinetySeconds::Services::CommandService do
  subject { NinetySeconds::Services::CommandService }

  describe '#from_args' do
    context 'when valid args' do
      let(:args) { ['-r', 'user', '-f', 'json', '-q', 'a=b', '-l', '1', '-o', '1', '-h'] }
      it 'return correct options' do
        options = subject.from_args(args)
        expect(options).to eq(resource: 'user',
                              format: 'json',
                              queries: ['a=b'],
                              limit: 1,
                              offset: 1)
      end
    end

    context 'when invalid args' do
      it 'exit' do
        expect(-> { subject.from_args(['-k', 'user']) }).to raise_error SystemExit
      end
    end
  end
end
