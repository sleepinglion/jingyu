module JsonLdHelper
  def json_ld_for_blog(post)
    {
      "@context": "https://schema.org",
      "@type": "BlogPosting",
      "mainEntityOfPage": {
        "@type": "WebPage",
        "@id": blog_url(post)
      },
      "headline": post.title,
      "description": post.description || truncate(strip_tags(post.content), length: 160),
      "image": post.blog_picture ? sl_get_thumb(post.blog_picture.picture.to_s,'medium') : '-',
      "author": {
        "@type": "Person",
        "name": post.user&.name || "익명"
      },
      "publisher": {
        "@type": "Organization",
        "name": "My Blog",
        "logo": {
          "@type": "ImageObject",
          "url": asset_url("favicon.ico")
        }
      },
      "genre": post.blog_category.title || "블로그",
      "datePublished": post.created_at.iso8601,
      "dateModified": post.updated_at.iso8601
    }
  end

  def json_ld_for_gallery(gallery)
    {
      "@context": "https://schema.org",
      "@type": "ImageGallery",
      "name": gallery.title,
      "url": gallery_url(gallery),
      "image": {
          "@type": "ImageObject",
          "url": gallery.photo.url,
          "caption": gallery.title,
          "thumbnail": sl_get_thumb(gallery.photo.to_s,'medium')
        },
      "datePublished": gallery.created_at.iso8601,
      "dateModified": gallery.updated_at.iso8601
    }
  end

  def json_ld_for_faq_page(faqs)
    {
      "@context": "https://schema.org",
      "@type": "FAQPage",
      "mainEntity": faqs.map do |faq|
        {
          "@type": "Question",
          "name": faq.title,
          "acceptedAnswer": {
            "@type": "Answer",
            "text": faq.content.to_plain_text
          }
        }
      end
    }
  end

  def json_ld_for_profile()
    {
      "@context": "https://schema.org",
      "@type": "ProfilePage",
      "mainEntity": {
        "@type": "Person",
        "name": "정진규",
        "url": t(:site_full_url),
        "image": asset_url('intro.jpg'),
        "jobTitle": "은퇴자",
        "birthDate": "1953-11-02"
      }
    }
  end


  def qa_page_jsonld(obj)
    entities =
      if obj.is_a?(ActiveRecord::Relation) || obj.is_a?(Array)
        obj.map { |q| build_question_entity(q) }
      else
        [build_question_entity(obj)]
      end

    {
      "@context": "https://schema.org",
      "@type": "QAPage",
      "mainEntity": entities
    }
  end

  private

  def build_question_entity(question)
    answers  = question.answers
    accepted = answers.find_by(accepted: true)
    others   = accepted ? answers.where.not(id: accepted.id) : answers

    # 질문/답변 텍스트를 순수 문자열로
    question_text = if question.respond_to?(:content) && question.content.respond_to?(:to_plain_text)
                      question.content.to_plain_text.squish
                    else
                      strip_tags(question.content.to_s).squish
                    end

    entity = {
      "@type": "Question",
      "name": question.title.to_s.squish,
      "text": question_text,
      "answerCount": answers.size
    }

    if accepted.present?
      accepted_text = if accepted.content.respond_to?(:to_plain_text)
                        accepted.content.to_plain_text.squish
                      else
                        strip_tags(accepted.content.to_s).squish
                      end

      entity["acceptedAnswer"] = {
        "@type": "Answer",
        "text": accepted_text
      }
    end

    if others.any?
      entity["suggestedAnswer"] = others.map do |answer|
        answer_text = if answer.content.respond_to?(:to_plain_text)
                        answer.content.to_plain_text.squish
                      else
                        strip_tags(answer.content.to_s).squish
                      end
        { "@type": "Answer", "text": answer_text }
      end
    end

    entity
  end
end