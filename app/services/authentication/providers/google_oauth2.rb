module Authentication
  module Providers
    # GitHub authentication provider, uses omniauth-github as backend
    class GoogleOauth2 < Provider
      OFFICIAL_NAME = "Google".freeze
      SETTINGS_URL = "https://google.com/settings/applications".freeze

      def new_user_data
        name = raw_info.name.presence || info.name

        {
          email: info.email.to_s,
          name: name,
          googleoauth2_username: info.nickname
        }
      end

      def self.official_name
        OFFICIAL_NAME
      end

      def existing_user_data
        {
          googleoauth2_username: info.nickname
        }
      end

      def self.settings_url
        SETTINGS_URL
      end

      def self.sign_in_path(**kwargs)
        ::Authentication::Paths.sign_in_path(
          provider_name,
          **kwargs,
        )
      end

      protected

      def cleanup_payload(auth_payload)
        auth_payload.tap do |auth|
          # Twitter sends the server side access token keys in the payload
          # for each authentication. We definitely do not want to store those
          auth.extra.delete("access_token")
        end
      end
    end
  end
end
