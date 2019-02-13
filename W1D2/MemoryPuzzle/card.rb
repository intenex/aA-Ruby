class Card
    attr_reader :face_value
    attr_accessor :face_down, :revealed

    def initialize(face_value)
        @face_value = face_value
        @face_down = true
        @revealed = false
    end

    def display
        @face_value if !@face_down # display the face_value of the card if it is face up
    end

    def hide
        @face_down = true
    end

    def reveal
        @face_down = false
    end

    def ==(other_card)
        self.face_value == other_card.face_value
    end
end