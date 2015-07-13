class Account < ActiveRecord::Base
	attr_accessor :provider, :uid
	def self.update_from_user_hash(auth_hash)
		account = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
		account.update(
			dummy: auth_hash.info.nickname,
			username: auth_hash.info.nickname,
			name: auth_hash.info.name,
			email: auth_hash.info.email,
			token: auth_hash.credentials.token,
			secret: auth_hash.credentials.secret
		)
		account
	end
end
