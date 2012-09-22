require 'spec_helper'

class FakeAssociation
  def initialize klass, attributes
    @klass = klass
    @attributes = attributes
  end

  def build attributes = {}
    @klass.new @attributes.merge(attributes)
  end
end

describe EggCollector do
  subject { collector.build params }
  let(:collector) { EggCollector.new flock, current_user }
  let(:flock) { mock_model('Flock', :id => 4, :egg_collections => fake_association) }
  let(:fake_association) { FakeAssociation.new EggCollection, :flock_id => 4 }
  let(:current_user) { mock_model('User', :id => 3) }
  let(:params) { { :start_on => start_on, :frequency => frequency, :eggs => eggs } }
  let(:start_on) { '2012-09-12' }
  let(:frequency) { 'daily' }
  let(:eggs) { "1\r\n2\r\n3" }

  it('generates 3 records') { subject.size.should == 3 }
  it('generates 3 records') { subject.map(&:class).should == [EggCollection, EggCollection, EggCollection] }
  it('sets flock_id') { subject.map(&:flock_id).should == [4,4,4] }
  it('sets entered_by_id') { subject.map(&:entered_by_id).should == [3,3,3] }
  it('sets occurred_on') { subject.map(&:occurred_on).should == ['2012-09-12', '2012-09-13', '2012-09-14'].map(&:to_date) }
  it('sets quantity') { subject.map(&:quantity).should == [1,2,3] }

  context 'weekly' do
    let(:frequency) { 'weekly' }
    it('sets occurred_on') { subject.map(&:occurred_on).should == ['2012-09-12', '2012-09-19', '2012-09-26'].map(&:to_date) }
  end

  context 'all sorts of separators' do
    let(:eggs) { " 1\t2,3\r\n4    5 6 " }
    it('sets quantity') { subject.map(&:quantity).should == [1,2,3,4,5,6] }
  end

  context 'zeroes' do
    let(:eggs) { "0\r\n10\r\n20.0\r\n" }
    it('sets quantity') { subject.map(&:quantity).should == [0,10,20] }
  end
end
