require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: @user.email, name: @user.name }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { email: @user.email, name: @user.name }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
  
  # User sign up validation 
  before do
     @user = User.new(name: "Example User", email: "user@example.com")
   end

   subject { @user }

   it { should respond_to(:name) }
   it { should respond_to(:email) }
   # it { should respond_to(:password_digest) }
   it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
   it { should respond_to(:authenticate) }

   it { should be_valid }

   describe "when name is not present" do
     before { @user.name = " " }
     it { should_not be_valid }
   end

   describe "when email is not present" do
     before { @user.email = " " }
     it { should_not be_valid }
   end

   describe "when email format is invalid" do
     it "should be invalid" do
       addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
       addresses.each do |invalid_address|
         @user.email = invalid_address
         @user.should_not be_valid
       end      
     end
   end

   describe "when email format is valid" do
     it "should be valid" do
       addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
       addresses.each do |valid_address|
         @user.email = valid_address
         @user.should be_valid
       end      
     end
   end

   describe "when email address is already taken" do
     before do
       user_with_same_email = @user.dup
       user_with_same_email.email = @user.email.upcase
       user_with_same_email.save
     end

     it { should_not be_valid }
   end

   describe "when password is not present" do
          before { @user.password = @user.password_confirmation = " " }
          it { should_not be_valid }
        end
       
        describe "when password confirmation is nil" do
          before { @user.password_confirmation = nil }
          it { should_not be_valid }
        end
       
        describe "when password doesn't match confirmation" do
          before { @user.password_confirmation = "mismatch" }
          it { should_not be_valid }
        end
     
       describe "when name is too long" do
         before { @user.name = "a" * 51 }
         it { should_not be_valid }
       end
       describe "with a password that's too short" do
                before { @user.password = @user.password_confirmation = "a" * 5 }
                it { should be_invalid }
              end
    
     describe "return value of authenticate method" do
       before { @user.save }
       let(:found_user) { User.find_by_email(@user.email) }

       describe "with valid password" do
              it { should == found_user.authenticate(@user.password) }
            end
       
            describe "with invalid password" do
              let(:user_for_invalid_password) { found_user.authenticate("invalid") }
       
              it { should_not == user_for_invalid_password }
              specify { user_for_invalid_password.should be_false }
            end
     end
end
