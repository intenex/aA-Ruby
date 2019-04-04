# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        if user
            return user if user.is_password?(password) # return the user if the passed in password is correct
            false
        end # this will return nil if no user was found, and false if the password was incorrect awesome
    end

    attr_reader :password

    validates :password, length: { minimum: 6, allow_nil: true } # fuck you can crush it all love it so lucky to just remember all the stuff
    validates :email, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true

    after_initialize :ensure_session_token

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def ensure_session_token
        @session_token ||= generate_session_token
    end

    def generate_session_token
        SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        @session_token = generate_session_token
        self.save!
    end

end
