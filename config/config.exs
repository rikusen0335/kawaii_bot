import Mix.Config

config :kawaii_bot,
  prefix: ".ka"

import_config "#{Mix.env()}.exs"
