require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.create(name: 'User2', email: 'user2@gmail.com',  password: 'password', password_confirmation: 'password')
    @user.save
  end

  describe 'Validations' do
    it 'user should be created when the password and confirmation match' do
      expect(@user).to be_valid
    end

    it 'user should not be created when the password and confirmation don\'t match' do
      @user.password_confirmation = "passwrd"
      expect(@user).to_not be_valid
    end

    it "should not be valid without a password confirmation" do
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
    end

    it "should not be valid with a password length less than 6 char" do
      @user = User.create(name: 'User4', email: 'user4@gmail.com',  password: 'pass', password_confirmation: 'pass')
      @user.save
      expect(@user).to_not be_valid
    end
    
    it "should not be valid without a name" do
      @user.name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "should not be valid without an email" do
      @user.email = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'each user should have a unique email' do
      @user_with_same_email = User.create(name: 'User_new', email: 'user2@gmail.com',  password: 'password', password_confirmation: 'password')
      expect(@user_with_same_email).not_to be_valid
      expect(@user_with_same_email.errors.full_messages).to include("Email has already been taken")
    end

  end


  describe '.authenticate_with_credentials' do

    it 'should authenticate a user with valid email and password' do
      @user = User.create(name: 'User4', email: 'user4@gmail.com',  password: 'passing', password_confirmation: 'passing')
      @session = User.authenticate_with_credentials(@user.email, @user.password)
      expect(@user).to eql(@session)
    end

    it 'should not authenticate a user without valid email' do
      @user = User.create(name: 'User4', email: 'user4@gmail.com',  password: 'passing', password_confirmation: 'passing')
      @session = User.authenticate_with_credentials('@user.email', @user.password)
      expect(@user).to_not eql(@session)
    end

    it 'should not authenticate a user without valid password' do
      @user = User.create(name: 'User4', email: 'user4@gmail.com',  password: 'passing', password_confirmation: 'passing')
      @session = User.authenticate_with_credentials(@user.email, 'password1')
      expect(@user).to_not eql(@session)
    end

    it 'should authenticate an email typed with surrounding spaces' do
      @user.email = ' user2@gmail.com  '
      @session = User.authenticate_with_credentials(@user.email, @user.password)
      expect(@user).to eql(@session)
    end

    it 'should authenticate an email typed with wrong case' do
      @user.email = 'User2@gmail.COM'
      @session = User.authenticate_with_credentials(@user.email, @user.password)
      expect(@user).to eql(@session)
    end


  end
  after (:all) { @user.destroy }
end