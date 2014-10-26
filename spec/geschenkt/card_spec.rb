require 'geschenkt'

module Geschenkt

  describe Card do
    let(:card) { Card.new(42) }

    describe '#initialize' do
      it 'should assign 0 chips to the card' do
        expect(card.chips).to eq 0
      end
    end

    describe '#value' do
      it 'should return the value of the card' do
        expect(card.value).to eq 42
      end
    end

    describe '#add_chip' do
      it "should increase the card's chips by 1" do
        card.add_chip

        expect(card.chips).to eq 1
      end
    end

    describe '#remove_chips' do
      it 'should remove all chips from card' do
        5.times { card.add_chip }

        expect(card.remove_chips).to eq 5
        expect(card.chips).to eq 0
      end
    end
  end
end