import Config

config :rito_pls,
  api_key: System.get_env("RIOT_API_KEY")

import_config "#{config_env()}.exs"
