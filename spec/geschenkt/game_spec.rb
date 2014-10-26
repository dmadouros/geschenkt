require 'geschenkt'

module Geschenkt

  describe Game do
    describe '#add_player' do
      it 'should create and add a player' do
        game = Game.new
        game.add_player('David')

        expect(game.players.first.name).to eq 'David'
      end
    end

    describe '#start' do
      let(:deck) { double(:deck).as_null_object }
      let(:game) { Game.new(deck) }

      before { game.add_player('David') }

      it 'should setup the deck of cards' do
        expect(deck).to receive(:shuffle)

        game.start
      end

      it 'should remove 9 cards from the deck' do
        expect(deck).to receive(:remove_nine_cards)

        game.start
      end

      it 'should set the current player' do
        game = Game.new

        game.add_player('David')
        game.add_player('Kavita')
        game.add_player('Kim')

        game.start

        expect(['David', 'Kavita', 'Kim']).to include game.current_player.name
      end

      it 'should set the current card' do
        card = Card.new(42)

        allow(deck).to receive(:flip_card).and_return(card)

        game.start

        expect(game.current_card).to eq card
      end
    end

    describe '#pass_card' do
      let(:game) { Game.new }

      before do
        game.add_player('David')
        game.add_player('Kavita')
        game.start
      end

      it 'should move a chip from the current player to the current card' do
        original_player = game.current_player

        game.pass_card

        expect(original_player.chips).to eq 10
        expect(game.current_card.chips).to eq 1
      end

      it 'should set the current player to the next player' do
        original_player = game.current_player

        game.pass_card

        expect(game.current_player).to_not eq original_player
      end
    end

    describe '#take_card' do
      let(:card) { Card.new(42) }
      let(:deck) { double(:deck).as_null_object }
      let(:game) { Game.new(deck) }

      before do
        allow(deck).to receive(:flip_card).and_return(card)

        game.add_player('David')
        game.start
      end

      it "should add the card to the player's cards" do
        game.take_card

        expect(game.current_player.cards).to eq [card]
      end

      it 'should set the current card' do
        another_card = Card.new(43)
        allow(deck).to receive(:flip_card).and_return(another_card)

        game.take_card

        expect(game.current_card).to eq another_card
      end

      it 'should leave the current player as is' do
        original_player = game.current_player

        game.take_card

        expect(game.current_player).to eq original_player
      end
    end

    describe '#over?' do
      it 'should return true when last card is taken' do
        deck = double(:deck).as_null_object
        allow(deck).to receive(:flip_card).and_return(Card.new(42), nil)

        game = Game.new(deck)
        game.add_player('David')

        game.start

        game.take_card

        expect(game).to be_over
      end

      it 'should return false when more cards can be taken' do
        deck = double(:deck).as_null_object
        allow(deck).to receive(:flip_card).and_return(Card.new(42))
        allow(deck).to receive(:flip_card).and_return(Card.new(43))

        game = Game.new(deck)
        game.add_player('David')

        game.start

        game.take_card

        expect(game).to_not be_over
      end
    end

    describe '#cards_remaining' do
      it 'should return the number of cards remaining in the deck' do
        deck = double(:deck)
        allow(deck).to receive(:count).and_return(16)

        game = Game.new(deck)

        expect(game.cards_remaining).to eq 16
      end
    end

    describe '#has_minimum_players?' do
      let(:game) { Game.new }

      it 'should not have the minimum players when less than 3 players' do
        2.times { game.add_player 'player' }

        expect(game).to_not have_minimum_players
      end

      it 'should have the minimum players when exactly 3 players' do
        3.times { game.add_player 'player' }

        expect(game).to have_minimum_players
      end

      it 'should have the minimum players when more than 3 players' do
        4.times { game.add_player 'player' }

        expect(game).to have_minimum_players
      end
    end

    describe '#has_maximum_players?' do
      let(:game) { Game.new }

      it 'should not have the maximum players when less than 5 players' do
        4.times { game.add_player 'player' }

        expect(game).to_not have_maximum_players
      end

      it 'should have the maximum players when exactly 5 players' do
        5.times { game.add_player 'player' }

        expect(game).to have_maximum_players
      end
    end

    describe '#can_pass_card?' do
      it 'should ask the player if it can pass a card' do
        player = double(:player)
        allow(player).to receive(:can_pass_card?).and_return(true)
        allow(Player).to receive(:new).and_return(player)

        game = Game.new
        game.add_player 'player'
        game.start

        expect(game.can_pass_card?).to eq true
      end
    end
  end
end