require 'spec_helper'

describe FlockBuilder do
  let(:flock_builder) { FlockBuilder.new current_user }
  let(:current_user) { mock_model('User', :farms => farms) }
  let(:params) { { :flock => { :name => 'New flock' } }.with_indifferent_access }
  subject { flock_builder.build params }

  shared_examples 'flock' do
    it('associates the flock with the farm') { flock.farm.should == farm }
    it('assigns flock name') { flock.name.should == 'New flock' }
  end

  context 'no farms' do
    let(:farms) { [] }
    it('builds two records') { subject.size.should == 3 }
    it('builds a farm record') { subject[0].should be_a Farm }
    it('builds a farmer record') { subject[1].should be_a Farmer }
    it('sets the farmer user') { subject[1].user.should == current_user }
    it('sets the farmer farm') { subject[1].farm.should == subject[0] }
    it('builds a flock record') { subject[2].should be_a Flock }
    it_behaves_like 'flock' do
      let(:farm) { subject[0] }
      let(:flock) { subject[2] }
    end
  end

  context 'one farm' do
    let(:farms) { [ farm ] }
    let(:farm) { mock_model('Farm', :id => 2) }
    it('builds one record') { subject.size.should == 1 }
    it('builds a flock record') { subject[0].should be_a Flock }
    it_behaves_like 'flock' do
      let(:flock) { subject[0] }
    end
  end
end
