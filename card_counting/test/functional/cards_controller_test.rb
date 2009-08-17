require 'test_helper'

class CardsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_response :success
    card = assigns(:card)
    assert_not_nil card
    assert @response.body[card.filename], @response.body
    cards_left = assigns(:cards_left)
    assert_not_nil cards_left
    assert @response.body[cards_left.to_s], @response.body
  end
  
end
