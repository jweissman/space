require 'spec_helper'
require 'space/model'

describe Model do
  it 'should have a position' do
    expect(subject.x).to eql(0)
    expect(subject.y).to eql(0)
  end

  it 'should have angle/velocity' do
    expect(subject.theta).to eql(0)
    expect(subject.velocity).to eql(0)
  end

  it 'should have width/height' do
    expect(subject.width).to eql(16)
    expect(subject.height).to eql(16)
  end

  describe '#overlaps?' do
    let(:overlapping_model) { Model.new(6,6) }
    let(:another_overlapping_model) { Model.new(-6,6) }
    let(:non_overlapping_model) { Model.new(100,100) }

    it 'should indicate collisions' do
      expect(subject.overlap?(overlapping_model)).to eql(true)
      expect(overlapping_model.overlap?(subject)).to eql(true)

      expect(subject.overlap?(another_overlapping_model)).to eql(true)
      expect(another_overlapping_model.overlap?(subject)).to eql(true)

      expect(subject.overlap?(non_overlapping_model)).to eql(false)
      expect(non_overlapping_model.overlap?(subject)).to eql(false)
    end
  end
end
