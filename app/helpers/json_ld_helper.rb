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

  def json_ld_for_profile()
    {
      "@context": "https://schema.org",
      "@type": "ProfilePage",
      "mainEntity": {
        "@type": "Person",
        "name": "정진규",
        "url": 'https://www.jingyu.pe.kr',
        "image": asset_url('intro.jpg'),
        "jobTitle": "은퇴자",
        "birthDate": "1953-11-02"
      }
    }
  end
end