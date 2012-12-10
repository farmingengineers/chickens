require 'spec_helper'
require 'support/fake_association'

describe Feeder do
  subject { feeder.build params }
  let(:feeder) { Feeder.new flock, current_user }
  let(:flock) { mock_model('Flock', :id => 4, :feedings => fake_feedings_association) }
  let(:fake_feedings_association) { FakeAssociation.new Feeding, :flock_id => 4 }
  let(:current_user) { mock_model('User', :id => 3) }

  let(:params) { { :data_type_id => data_type_id, :points => points } }
  let(:points) { { '1' => { :date => '2012-12-12', :quantity => '1' }, '2' => { :date => '2012-12-13', :quantity => '2' }, '3' => { :date => '2012-12-15', :quantity => '3' } } }
  let(:data_type_id) { '' }

  it('generates 3 records') { subject.map(&:class).should == [Feeding, Feeding, Feeding] }
  it('sets flock_id') { subject.map(&:flock_id).should == [4,4,4] }
  it('sets data_type_id') { subject.map(&:data_type_id).should == [nil,nil,nil] }
  it('sets entered_by_id') { subject.map(&:entered_by_id).should == [3,3,3] }
  it('has first point')  { subject.should satisfy { |a| a.any? { |r| r.occurred_on.to_date == '2012-12-12'.to_date && r.quantity == 1 } } }
  it('has second point') { subject.should satisfy { |a| a.any? { |r| r.occurred_on.to_date == '2012-12-13'.to_date && r.quantity == 2 } } }
  it('has third point')  { subject.should satisfy { |a| a.any? { |r| r.occurred_on.to_date == '2012-12-15'.to_date && r.quantity == 3 } } }

  context 'no points' do
    let(:points) { nil }
    it('generates 0 records') { should be_empty }
  end

  context 'partially-filled points' do
    let(:frequency) { 'weekly' }
    let(:points) { { '1' => { :date => '', :quantity => '1' }, '2' => { :date => '2012-12-13', :quantity => '' }, '3' => { :date => nil } } }
    it('generates 0 records') { should be_empty }
  end

  context 'with a data type' do
    let(:data_type_id) { '1' }
    it('sets data_type_id') { subject.map(&:data_type_id).should == [1,1,1] }
  end
end
