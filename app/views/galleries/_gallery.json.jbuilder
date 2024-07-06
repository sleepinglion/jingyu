json.created_date get_dt_format(gallery.created_at.to_date)
json.extract! gallery, :id, :title, :content, :photo, :created_at, :updated_at
json.url gallery_url(gallery, format: :json)
