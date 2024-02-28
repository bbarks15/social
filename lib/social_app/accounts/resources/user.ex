defmodule SocialApp.Accounts.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication, AshJsonApi.Resource]

  attributes do
    uuid_primary_key :id
    attribute :email, :ci_string, allow_nil?: false
    attribute :hashed_password, :string, allow_nil?: false, sensitive?: true
  end

  authentication do
    api SocialApp.Accounts

    strategies do
      password :password do
        identity_field :email
        sign_in_tokens_enabled? true
      end
    end

    tokens do
      enabled? true
      token_resource SocialApp.Accounts.Token

      signing_secret SocialApp.Accounts.Secrets
    end
  end

  postgres do
    table "users"
    repo SocialApp.Repo
  end

  identities do
    identity :unique_email, [:email]
  end

  json_api do
    type "user"

    routes do
      base("/user")

      post(:register_with_password, route: "/register")
      get(:sign_in_with_token_for_password)
      # index (:read)
      # post(:create)
    end
  end

  # If using policies, add the following bypass:
  # policies do
  #   bypass AshAuthentication.Checks.AshAuthenticationInteraction do
  #     authorize_if always()
  #   end
  # end
end
