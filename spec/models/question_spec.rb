require 'spec_helper'

describe Question do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @question = user.questions.build(title: "How many kids do you have?") }

  subject { @question }

  it { should respond_to(:title) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @question.user_id = nil }
    it { should_not be_valid }
  end

  describe "when title is blank" do
    before { @question.title = " " }
    it { should_not be_valid }
  end

  describe "when title is too long" do
  	before { @question.title = "a" * 151 }
  	it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Question.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end
