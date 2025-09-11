key = "jingyu_app_session"

if Rails.env.production?
  session_url = 'redis://127.0.0.1:6379/1/session'
  secure = Rails.env.production?
  domain = 'www.jingyu.pe.kr'

  Rails.application.config.session_store :redis_store,
                                         url: session_url,
                                         expire_after: nil,
                                         key: key,
                                         domain: domain,
                                         threadsafe: true,
                                         secure: secure,
                                         same_site: :lax,
                                         httponly: true
else
  Rails.application.config.session_store :cookie_store,  key: key, expire_after: nil
end