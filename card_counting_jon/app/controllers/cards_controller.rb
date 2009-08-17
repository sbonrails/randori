class CardsController < ApplicationController
  cattr_accessor :shoe
  
  def index
    @@shoe ||= Shoe.new(1)
    @card = @@shoe.deal
    @cards_left = @@shoe.cards.size
    @count = @@shoe.count
  end
end
