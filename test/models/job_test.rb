# frozen_string_literal: true

require 'test_helper'

class JobTest < ActiveSupport::TestCase
  test 'is valid with valid attributes' do
    assert jobs(:shell).valid?
  end

  test '#expires_in_future? returns true if expires at is in the future' do
    assert jobs(:shell).expires_in_future?
  end
end
