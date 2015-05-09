require 'spec_helper'
require 'space'

describe GameEngine do
  let(:game) do
    double(:game, {
      width: 640, height: 480
    })
  end

  subject do
    GameEngine.new(game)
  end

  context '#step' do
    it 'should update models' do
      expect(subject).to receive(:update_model).exactly(subject.models.count).times
      subject.step
    end
  end
  
  context '#render' do
    let(:viewport) do
      Viewport.new(game.width, game.height)
    end

    let(:visible_models) do
      subject.models.select { |m| viewport.should_draw?(m) }
    end

    it 'should have some visible models' do
      expect(visible_models.count).to be > 0
    end

    it 'should update visible models' do
      expect(subject).to receive(:render_model).exactly(visible_models.count).times
      subject.render
    end
  end
end
