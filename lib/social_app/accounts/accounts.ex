defmodule SocialApp.Accounts do
  use Ash.Api, extensions: [AshJsonApi.Api]

  resources do
    resource SocialApp.Accounts.User
    resource SocialApp.Accounts.Token
  end
end
