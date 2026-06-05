namespace :account do
  desc "Update admin account from ENV"
  task update_admin: :environment do
    email = ENV["ADMIN_EMAIL"]
    password = ENV["ADMIN_PASSWORD"]

    unless email.present? && password.present?
      puts "❌ ADMIN_EMAIL or ADMIN_PASSWORD missing"
      exit 1
    end

    admin = Admin.find_by_id(1)

    unless admin
      puts "❌ Admin not found: 1"
      exit 1
    end

    Admin.transaction do
      admin.update!(email: email)
      admin.update!(password: password)
    end

    puts "✅ Admin email & password updated"
  end
end
