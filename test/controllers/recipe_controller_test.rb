require 'test_helper'

class RecipeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get recipe_index_url
    assert_response :success
  end

  test 'should get show' do
    get recipe_show_url
    assert_response :success
  end

  test 'should get new' do
    get recipe_new_url
    assert_response :success
  end

  test 'should get create' do
    get recipe_create_url
    assert_response :success
  end

  test 'should get destroy' do
    get recipe_destroy_url
    assert_response :success
  end
end
