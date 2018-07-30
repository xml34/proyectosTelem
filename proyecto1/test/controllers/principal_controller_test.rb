require 'test_helper'

class PrincipalControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get principal_login_url
    assert_response :success
  end

end
