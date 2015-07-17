class Account < ActiveRecord::Base
  def self.to_csv
    attributes = %w{ip twitter_login twitter_pass email twitter_username twitter_name bio location website profile_img header_img}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |account|
        csv << [account.ipaddress, account.dummy, account.password, account.email,account.username,account.name,account.bio,account.location,account.website,account.profile_img,account.header_img]
      end
    end
  end

end
