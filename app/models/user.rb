class User < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  # == Relationships ========================================================
  has_many :activities, dependent: :destroy

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================
  before_save :ensure_authentication_token

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

end
