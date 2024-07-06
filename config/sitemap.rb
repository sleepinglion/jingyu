# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.jingyu.pe.kr"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
 # Add '/blogs'
  add intro_index_path, :priority => 0.9, :changefreq => 'monthly'
  add galleries_path, :priority => 0.7, :changefreq => 'weekly'
  Gallery.find_each do |gallery|
    add gallery_path(gallery), :priority => 0.5, :lastmod => gallery.updated_at
  end

  add blogs_path, :priority => 0.9, :changefreq => 'daily'

  Blog.find_each do |blog|
    add blog_path(blog), :priority => 0.9, :lastmod => blog.updated_at
  end

  add questions_path

  Question.find_each do |question|
    add question_path(question), :lastmod => question.updated_at
  end

  add guest_books_path

  GuestBook.find_each do |guest_book|
    add guest_book_path(guest_book), :lastmod => guest_book.updated_at
  end

  add notices_path

  Notice.find_each do |notice|
    add notice_path(notice), :lastmod => notice.updated_at
  end

  add faqs_path, :priority => 0.9, :changefreq => 'monthly'

  Faq.find_each do |faq|
    add faq_path(faq), :lastmod => faq.updated_at
  end

  Tag.find_each do |tag|
    next if tag.taggings_count.zero?

    add tag_path(:tag => tag.name), :lastmod => tag.taggings.first.created_at
  end
end
