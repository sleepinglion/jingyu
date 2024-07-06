crumb :root do
  link t(:home), root_path
end

crumb :intro do
   link t('activerecord.models.intro'), intro_index_path
end

crumb :blogs do
   link t('activerecord.models.blog'), blogs_path
end

crumb :blog do |blog|
   link blog.title, blog_path(blog)
   parent :blogs
end

crumb :galleries do
   link t('activerecord.models.gallery'), galleries_path
end

crumb :gallery do |gallery|
   link gallery.title, gallery_path(gallery)
   parent :galleries
end

crumb :questions do
   link t('activerecord.models.question'), questions_path
end

crumb :question do |question|
   link question.title, question_path(question)
   parent :questions
end

crumb :guest_books do
   link t('activerecord.models.guest_book'), guest_books_path
end

crumb :guest_book do |guest_book|
   link guest_book.title, guest_book_path(guest_book)
   parent :guest_books
end

crumb :faqs do
   link t('activerecord.models.faq'), faqs_path
end

crumb :faq do |faq|
   link faq.title, faq_path(faq)
   parent :faqs
end

crumb :notices do
   link t('activerecord.models.notice'), notices_path
end

crumb :notice do |notice|
   link notice.title, notice_path(notice)
   parent :notices
end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
