require 'spec_helper'

describe "Question pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "question creation" do
    before { visit new_question_path }

    describe "with invalid information" do

      it "should not create a question" do
        expect { click_button "Submit" }.not_to change(Question, :count)
      end

      describe "error messages" do
        before { click_button "Submit" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'question[title]', with: "Lorem ipsum" }
      it "should create a question" do
        expect { click_button "Submit" }.to change(Question, :count).by(1)
      end
    end
  end

  describe "question destruction" do
    before { FactoryGirl.create(:question, user: user) }

    describe "as correct user" do
      before { visit user_path(user) }

      it "should delete a question" do
        expect { click_link "delete" }.to change( Question, :count).by(-1)
      end
    end
  end
end

