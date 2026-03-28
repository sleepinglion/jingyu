# config/initializers/content_security_policy.rb

Rails.application.configure do
  # 사이트 전용 CSP 설정
  config.content_security_policy do |policy|
    # 기본 리소스 허용: 자기 도메인 + HTTPS
    policy.default_src :self, :https

    # 이미지: 자기 도메인 + HTTPS + base64(data:) + 외부 이미지 호스팅
    policy.img_src :self, :https, :data, 'https://jedaeroweb.blob.core.windows.net'

    # 스크립트: 자기 도메인 + HTTPS + CDN + AdSense 도메인
    policy.script_src :self, :https,
                      'https://cdn.jsdelivr.net',
                      'https://cdnjs.cloudflare.com',
                      'https://pagead2.googlesyndication.com',
                      'https://www.googletagservices.com'

    # 스타일: 자기 도메인 + HTTPS + CDN
    policy.style_src :self, :https, 'https://fonts.googleapis.com', 'https://cdn.jsdelivr.net'

    # 폰트: 자기 도메인 + HTTPS + base64 + Google Fonts
    policy.font_src :self, :https, :data, 'https://fonts.gstatic.com'

    # 객체, 플러그인 사용 금지
    policy.object_src :none

    # 클릭재킹 방지
    policy.frame_ancestors :none

    # CSP 위반 보고 필요 시 (선택)
    # policy.report_uri "/csp-violation-report-endpoint"
  end

  # 인라인 스크립트/스타일용 nonce 생성 (Importmap, Turbo, inline script/style 대응)
  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w(script-src style-src)

  # 테스트용: 정책 위반 보고만 하고 실제 적용 안함
  # config.content_security_policy_report_only = true
end