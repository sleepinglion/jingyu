json.extract! notice, :id, :title, :enable, :created_at, :updated_at
json.url admin_notice_url(notice, format: :json)
