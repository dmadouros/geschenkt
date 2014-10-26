require 'geschenkt'

module Geschenkt

  describe ScoreCalculator do
    describe '#execute' do

      it 'should 0 when no cards' do
        expect(ScoreCalculator.new([]).execute).to eq 0
      end

      describe 'single cards' do
        it 'should calculate the score for a single card' do
          expect(ScoreCalculator.new([3]).execute).to eq 3
        end

        it 'should calculate the score for three single cards' do
          expect(ScoreCalculator.new([11, 13, 15]).execute).to eq (11 + 13 + 15)
        end
      end

      describe 'runs' do
        it 'should calculate the score for a single run of cards' do
          expect(ScoreCalculator.new([3, 4, 5]).execute).to eq 3
        end

        it 'should calculate the score for two runs of cards' do
          expect(ScoreCalculator.new([3, 4, 5, 7, 8, 9]).execute).to eq (3 + 7)
        end
      end

      describe 'mix of single cards and runs' do
        it 'should calculate the score for a single run and a single card' do
          expect(ScoreCalculator.new([3, 4, 5, 10]).execute).to eq (3 + 10)
        end

        it 'should calculate the score for multiple runs and multiple single cards' do
          expect(ScoreCalculator.new([3, 4, 5, 7, 8, 9, 11, 13, 15]).execute).to eq (3 + 7 + 11 + 13 + 15)
          expect(ScoreCalculator.new([5, 6, 7, 9, 10, 12, 13, 14, 17, 18, 19, 21, 22, 24, 26, 29, 30, 31, 33, 34, 35]).execute).to eq (5 + 9 + 12 + 17 + 21 + 24 + 26 + 29 + 33)
        end
      end
    end
  end
end