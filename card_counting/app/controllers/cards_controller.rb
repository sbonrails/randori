class CardsController < ApplicationController
  cattr_accessor :shoe
  
  def index
#    self.class.shoe ||= Shoe.new(4)
    @@shoe ||= Shoe.new(4)
    @card = @@shoe.deal
    @cards_left = @@shoe.cards.size
  end
end
