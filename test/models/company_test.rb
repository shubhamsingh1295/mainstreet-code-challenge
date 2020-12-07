require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'Pass if name is blank' do
    assert_not companies(:peter_painting).valid?
  end

  test 'Pass if email domain is @getmainstreet.com' do
    assert companies(:hometown_painting).valid?
  end

  test 'Pass if email is invalid' do
    refute companies(:brown_painting).valid?
    msg = companies(:brown_painting).errors.full_messages.to_sentence
    assert_equal msg, 'Email is invalid'
  end

  test 'Pass if email is blank' do
    assert_not companies(:marcus_painting).valid?
  end

  test 'Pass if phone is blank' do
    assert companies(:downtown_painting).valid?
  end

  test 'Pass if phone is invalid' do
    refute companies(:joy_painting).valid?
    msg = companies(:joy_painting).errors.full_messages.to_sentence
    assert_equal msg, 'Phone is too short (minimum is 10 characters)'
  end
end
