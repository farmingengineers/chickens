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

describe Feeder do
  subject { feeder.build params }
  let(:feeder) { Feeder.new flock, current_user }
  let(:flock) { mock_model('Flock', :id => 4, :feedings => fake_feedings_association) }
  let(:fake_feedings_association) { FakeAssociation.new Feeding, :flock_id => 4 }
  let(:current_user) { mock_model('User', :id => 3) }
  let(:params) { { :start_on => start_on, :frequency => frequency, :pounds => pounds, :data_type_id => data_type_id } }
  let(:data_type_id) { '' }
  let(:start_on) { '2012-09-12' }
  let(:frequency) { 'daily' }
  let(:pounds) { "1\r\n2\r\n3" }

  it('generates 3 feedings') { subject.size.should == 3 }
  it('generates 3 feedings') { subject.map(&:class).should == [Feeding, Feeding, Feeding] }
  it('sets flock_id') { subject.map(&:flock_id).should == [4,4,4] }
  it('sets data_type_id') { subject.map(&:data_type_id).should == [nil,nil,nil] }
  it('sets entered_by_id') { subject.map(&:entered_by_id).should == [3,3,3] }
  it('sets occurred_on') { subject.map(&:occurred_on).should == ['2012-09-12', '2012-09-13', '2012-09-14'].map(&:to_date) }
  it('sets quantity') { subject.map(&:quantity).should == [1,2,3] }

  context 'weekly' do
    let(:frequency) { 'weekly' }
    it('sets occurred_on') { subject.map(&:occurred_on).should == ['2012-09-12', '2012-09-19', '2012-09-26'].map(&:to_date) }
  end

  context 'with a data type' do
    let(:data_type_id) { '1' }
    it('sets data_type_id') { subject.map(&:data_type_id).should == [1,1,1] }
  end

  context 'all sorts of separators' do
    let(:pounds) { " 1\t2,3\r\n4    5 6 " }
    it('sets quantity') { subject.map(&:quantity).should == [1,2,3,4,5,6] }
  end

  context 'zeroes' do
    let(:pounds) { "0\r\n10\r\n20.0\r\n0.30\r\n.4" }
    it('sets quantity') { subject.map(&:quantity).should == [0,10,20,0.3,0.4] }
  end

  context 'floating point' do
    let(:pounds) { "1.1\r\n2.2" }
    it('sets quantity') { subject.map(&:quantity).should == [1.1, 2.2] }
  end
end
