require "test_helper"

class DotfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dotfile = dotfiles(:one)
  end

  test "should get index" do
    get dotfiles_url
    assert_response :success
  end

  test "should get new" do
    get new_dotfile_url
    assert_response :success
  end

  test "should create dotfile" do
    assert_difference("Dotfile.count") do
      post dotfiles_url, params: { dotfile: { config_type: @dotfile.config_type, description: @dotfile.description, title: @dotfile.title } }
    end

    assert_redirected_to dotfile_url(Dotfile.last)
  end

  test "should show dotfile" do
    get dotfile_url(@dotfile)
    assert_response :success
  end

  test "should get edit" do
    get edit_dotfile_url(@dotfile)
    assert_response :success
  end

  test "should update dotfile" do
    patch dotfile_url(@dotfile), params: { dotfile: { config_type: @dotfile.config_type, description: @dotfile.description, title: @dotfile.title } }
    assert_redirected_to dotfile_url(@dotfile)
  end

  test "should destroy dotfile" do
    assert_difference("Dotfile.count", -1) do
      delete dotfile_url(@dotfile)
    end

    assert_redirected_to dotfiles_url
  end
end
