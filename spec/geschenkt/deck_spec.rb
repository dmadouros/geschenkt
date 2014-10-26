require 'geschenkt'

module Geschenkt

  describe Deck do
    let(:deck) { Deck.new }

    describe '#initialize' do
      it 'should create a deck of cards containing 33 cards' do
        expect(deck.count).to eq 33
      end

      it 'should create a deck of cards with values ranging from 3 to 33' do
        expect(deck.cards.map(&:value)).to eq (3..35).to_a
      end

      it 'should not be empty' do
        expect(deck).to_not be_empty
      end
    end

    describe '#shuffle' do
      it 'should randomize the deck of cards' do
        original_order = deck.cards.map(&:value)
        10.times do
          deck.shuffle
          new_order = deck.cards.map(&:value)

          expect(new_order).to_not eq original_order
          original_order = new_order
        end
      end
    end

    describe '#flip_card' do
      it 'should deal a card from the deck' do
        card = deck.flip_card

        expect(deck.count).to eq 32
        expect(card.value).to eq 35
      end

      it 'should return nil when no more cards' do
        33.times { deck.flip_card}

        expect(deck.flip_card).to be_nil
      end
    end

    describe '#remove_nine_cards' do
      it 'should remove 9 cards from the deck' do
        deck = Deck.new
        deck.remove_nine_cards

        expect(deck.count).to eq 24
      end
    end

    describe '#empty?' do
      it 'should be true when no more cards left' do
        deck = Deck.new
        33.times { deck.flip_card }

        expect(deck).to be_empty
      end
    end
  end
end