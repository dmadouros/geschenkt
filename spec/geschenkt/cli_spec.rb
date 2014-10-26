require 'geschenkt'

module Geschenkt
  describe Cli do
    let(:out) { StringIO.new }

    subject { Cli.new(out) }

    describe '#start' do
      it 'should present a welcome message' do
        # allow(subject).to receive(:get_user_response).and_return('David')

        # subject.start

        # expect(true)to be_true

        # expect(out.string.split("\n")).to eq(
        #   [
        #     'Welcome to Geschenkt',
        #     'Please add a player:'
        #   ]
        # )
      end
    end
  end
end