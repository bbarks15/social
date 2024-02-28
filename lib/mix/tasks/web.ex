defmodule Mix.Tasks.Web do
  @moduledoc """
    React frontend compilation and bundling for production.
  """
  use Mix.Task
  require Logger
  # Path for the frontend static assets that are being served
  # from our Phoenix router when accessing /app/* for the first time
  @public_path "./priv/static/web"

  @shortdoc "Compile and bundle React frontend for production"
  def run(_) do
    Logger.info("📦 - Installing NPM packages")
    System.cmd("bun", ["install", "--quiet"], cd: "./web")

    Logger.info("⚙️  - Compiling React frontend")
    System.cmd("bun", ["run", "build"], cd: "./web")

    Logger.info("🚛 - Moving dist folder to Phoenix at #{@public_path}")
    # First clean up any stale files from previous builds if any
    System.cmd("rm", ["-rf", @public_path])
    System.cmd("cp", ["-R", "./web/dist", @public_path])

    Logger.info("⚛️  - React frontend ready.")
  end
end
