xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @application_name
    xml.author 'Jingyu'
    xml.description @meta_description
    xml.link 'https://www.jingyu.pe.kr'
    xml.language I18n.locale.to_s

    for article in @blogs
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ''
        end
        xml.author 'Jingyu'
        xml.pubDate article.created_at.strftime("%a, %d %b %Y %H:%M:%S %z")
        xml.link 'https://www.jingyu.pe.kr/blog/' + article.id.to_s
        xml.guid article.id

        text = article.content.to_plain_text
		# if you like, do something with your content text here e.g. insert image tags.
		# Optional. I'm doing this on my website.
        unless article.blog_pictures_count.to_i == 0
            image_url = article.blog_picture.picture.large_thumb.to_s
            image_caption = article.title
            image_align = ""
            image_tag = "
                <p><img src='" + image_url +  "' alt='" + image_caption + "' title='" + image_caption + "' /></p>
              "
            text = text.sub('{image}', image_tag)
        end
        xml.description "<p>" + text + "</p>"

      end
    end
  end
end
