# config/initializers/content_security_policy.rb

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https

    # 스크립트
    policy.script_src :self, :https,
                      :unsafe_inline,
                      'https://pagead2.googlesyndication.com',
                      'https://partner.googleadservices.com',
                      'https://googleads.g.doubleclick.net',
                      'https://www.googletagservices.com',
                      'https://www.google-analytics.com',
                      'https://www.googletagmanager.com',
                      'https://cdn.jsdelivr.net',
                      'https://cdnjs.cloudflare.com'

    # 스타일
    policy.style_src :self, :https,
                     :unsafe_inline,
                     'https://fonts.googleapis.com',
                     'https://cdn.jsdelivr.net'

    # 이미지
    policy.img_src :self, :https, :data,
                   'https://jedaeroweb.blob.core.windows.net',
                   'https://pagead2.googlesyndication.com',
                   'https://googleads.g.doubleclick.net',
                   'https://tpc.googlesyndication.com',
                   'https://www.google.com',
                   'https://www.google.co.kr'

    # 프레임 (광고 iframe 핵심)
    policy.frame_src :self, :https,
                     'https://googleads.g.doubleclick.net',
                     'https://tpc.googlesyndication.com',
                     'https://pagead2.googlesyndication.com'

    # XHR / fetch / beacon (광고 요청 핵심)
    policy.connect_src :self, :https,
                       'https://pagead2.googlesyndication.com',
                       'https://googleads.g.doubleclick.net',
                       'https://www.google-analytics.com',
                       'https://www.googletagmanager.com'

    # 폰트
    policy.font_src :self, :https, :data, 'https://fonts.gstatic.com'

    policy.object_src :none

    # 이건 광고 표시랑 직접 관계 적음. 유지 가능
    policy.frame_ancestors :self
  end

  # nonce는 일단 AdSense 안정화 전까지 꺼두는 것도 방법
  # config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  # config.content_security_policy_nonce_directives = %w(script-src style-src)
end