require 'spec_helper'
require 'space'

describe Space do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end
end

describe Viewport do
  it 'should have an offset' do
    expect(subject.x).to eql(-320)
    expect(subject.y).to eql(-240)
  end

  it 'should recenter its offset' do
    subject.recenter(100,100)
    expect(subject.x).to eql(-220)
    expect(subject.y).to eql(-140)
  end

  it 'should adjust positions accordingly' do
    image = mock(:sprite)
    expect(image).to receive(:draw_rot).with(330,250,1,0)
    subject.render(image,10,10)
  end
end

describe Ship do
  it 'should have a location' do
    expect(subject.x).to eql(0)
    expect(subject.y).to eql(0)
  end

  it 'should have an angle' do
    expect(subject.theta).to eql(0)
  end

  describe '#turn' do
    it 'should change the angle by the given rate' do
      subject.turn(:left)
      expect(subject.theta).to eql(6)

      subject.turn(:right,12)
      expect(subject.theta).to eql(-6)
    end
  end

  describe '#accelerate' do
    it 'should increase the velocity by the given increment' do
      subject.accelerate(1.0)
      expect(subject.velocity).to eql(1.0)
    end
  end

  describe '#move' do
    let(:accel) { 1 }
    let(:decel) { 0.1 }

    before do 
      subject.turn(:left)
      subject.accelerate(accel)
      subject.move(decel) 
    end

    it 'should decay velocity' do
      expect(subject.velocity).to eql(accel - decel)
    end

    it 'should change position' do
      expect(subject.x).to eql(Gosu::offset_x(subject.theta, subject.velocity))
      expect(subject.y).to eql(Gosu::offset_y(subject.theta, subject.velocity))
    end
  end
end

# describe ShipView do; end
# describe GameEngine do; end
