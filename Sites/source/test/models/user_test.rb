require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save when user is blank" do
    assert_equal User.new.save, false
  end


  test "should save if user is full" do
    @user = users(:beth)

    assert_equal @user.save, true
  end

  test "should save and subscribe" do
      @user = users(:beth)

      assert_equal @user.save_and_subscribe, true
  end


  test "should not save and subscribe with invalid plan" do
    @user = users(:beth)

    @user.subscription_plan = "fakeplan"

    assert_equal @user.save_and_subscribe, false
  end

  test "should not charge if card declined" do
    @user = users(:bethtest)

    assert_equal @user.save_and_subscribe, false
    assert_equal @user.errors[:stripe_token], ["Your card was declined."]
  end

end
