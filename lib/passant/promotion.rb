
module Passant
  
  # Pawn promotion.
  class Promotion < Move
    def initialize(piece, move_to)
      super
      @promo_type = Pawn.promotion_piece(:white)
    end
    
    
    def apply
      super
      @piece.board.remove_piece(@piece)
      @promo_piece = @promo_type.new(@piece.board,
                                     @piece.position,
                                     @piece.color)
      self
    end
  
    def take_back
      super
      @piece.board.remove_piece(@promo_piece)
      @piece.board.add_piece(@piece)
      self
    end
  
    def to_s
      super + "=" + 
        @piece.board.letter_for_piece_class_and_color(@promo_type,
                                                      @piece.color)
    end

    def to_uci
      super + @piece.board.letter_for_piece_class_and_color(@promo_type, @piece.color).downcase
    end

    def to_alg
      super + @piece.board.letter_for_piece_class_and_color(@promo_type, @piece.color).upcase
    end

    def participants; [@piece, @promo_piece, @capture_piece].compact end

  end

end
