defmodule SocialApp.Accounts.Secrets do
  use AshAuthentication.Secret


  def secret_for([:authentication, :tokens, :signing_secret], SocialApp.Accounts.User, _) do
    case Application.fetch_env(:example, SocialAppWeb.Endpoint) do
      {:ok, endpoint_config} ->
        Keyword.fetch(endpoint_config, :secret_key_base)
      :error ->
        :error
    end
  end
end
