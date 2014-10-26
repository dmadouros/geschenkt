require 'geschenkt'

module Geschenkt
  describe Player do
    let(:player) { Player.new('David') }

    describe '#initialize' do
      it 'should assign 11 chips to the player' do
        expect(player.chips).to eq 11
      end

      it 'should assign no cards to the player' do
        expect(player.cards).to be_empty
      end
    end

    describe '#name' do
      it "should return the player's name" do
        expect(player.name).to eq 'David'
      end
    end

    describe '#pass_card' do
      let(:card) { Card.new(42) }

      it "should decrement the player's chips by 1" do
        player.pass_card(card)

        expect(player.chips).to eq 10
      end

      it "should increment the card's chips by 1" do
        player.pass_card(card)

        expect(card.chips).to eq 1
      end
    end

    describe '#take_card' do
      let(:card) { Card.new(42) }

      before do
        5.times { card.add_chip }
      end

      it "should add the card to the player's cards" do
        player.take_card(card)

        expect(player.cards).to eq [card]
      end

      it 'should remove the chips from the card' do
        player.take_card(card)

        expect(card.chips).to eq 0
      end

      it "should add the chips from to the player's chips" do
        player.take_card(card)

        expect(player.chips).to eq 16
      end
    end

    describe '#score' do
      it 'should add the score of the cards minus the number of tokens' do
        [5, 6, 7, 9, 10, 12, 13, 14, 17, 18, 19, 21, 22, 24, 26, 29, 30, 31, 33, 34, 35].each do |card_value|
          player.take_card(Card.new(card_value))
        end

        expect(player.score).to eq (5 + 9 + 12 + 17 + 21 + 24 + 26 + 29 + 33 - 11)
      end
    end

    describe '#can_pass_card?' do
      it 'should be true when chips is greater than 0' do
        expect(player.can_pass_card?).to eq true
      end

      it 'should be false when chips is equal to 0' do
        card = Card.new(3)

        11.times { player.pass_card(card) }

        expect(player.can_pass_card?).to eq false
      end
    end
  end
end