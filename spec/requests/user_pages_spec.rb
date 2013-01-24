require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user)  { FactoryGirl.create(:user) }
    let!(:q1)   { FactoryGirl.create(:question, user: user, title: "How old are you?") }
    let!(:q2)   { FactoryGirl.create(:question, user: user, title: "Where are you from?") }

    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }

    describe "questions" do
      it { should have_content(q1.title) }
      it { should have_content(q2.title) }
      it { should have_content(user.questions.count) }
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('title', text: full_title('Sign up')) }
    
    let(:submit) { "Sign up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in 'user[name]',                   with: "tanya"
        fill_in 'user[email]',                  with: "tanya1@gmail.com"
        fill_in 'user[password]',               with: "1234567890"
        fill_in 'user[password_confirmation]',  with: "1234567890"
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('tanya1@gmail.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out') }
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user) 
    end

    describe "page" do
      it { should have_selector('h2',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end
    
    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in 'user[name]',             with: new_name
        fill_in 'user[email]',            with: new_email
        fill_in 'user[password]',         with: user.password
        fill_in 'user[password_confirmation]', with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
  end
end
