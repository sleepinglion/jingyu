namespace :account do
  desc "Update admin account from ENV"
  task update_admin: :environment do
    email = ENV["ADMIN_EMAIL"]
    password = ENV["ADMIN_PASSWORD"]

    unless email.present? && password.present?
      puts "❌ ADMIN_EMAIL or ADMIN_PASSWORD missing"
      exit 1
    end

    user = User.find_by_id(1)

    unless user
      puts "❌ User not found: #{email}"
      exit 1
    end

    user.password = password
    user.password_confirmation = password if user.respond_to?(:password_confirmation)

    if user.save
      puts "✅ Admin account updated: #{email}"
    else
      puts "❌ Failed to update user"
      puts user.errors.full_messages
      exit 1
    end
  end
end
