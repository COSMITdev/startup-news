class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook],
         authentication_keys: [:username]

  has_many :comments, dependent: :destroy
  has_many :news, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_one :authentication, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[A-Za-z\d]+[A-Za-z\d_]*\z/ }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: username.downcase }]).first
    else
      where(conditions).first
    end
  end

  # def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  #   user = User.where(:provider => auth.provider, :uid => auth.uid).first
  #   unless user
  #     password = Devise.friendly_token[0,20]
  #     user = User.create!(username:auth.info.nickname.gsub('.', ''),
  #                        provider:auth.provider,
  #                        email:auth.info.email,
  #                        uid:auth.uid,
  #                        password:password,
  #                        password_confirmation:password
  #                       )
  #   end
  #   user
  # end 

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["info"]
        user.email = data["email"] if user.email.blank?
        user.username = data["nickname"].gsub('.', '') if user.username.blank?
      end
    end
  end
end
