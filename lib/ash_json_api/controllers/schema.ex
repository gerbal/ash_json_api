defmodule AshJsonApi.Controllers.Schema do
  @moduledoc false
  def init(options) do
    options
  end

  # sobelow_skip ["XSS.SendResp"]
  def call(conn, opts) do
    api = opts[:api]

    schema =
      api
      |> AshJsonApi.JsonSchema.generate()
      |> Jason.encode!()

    # TODO: Return as `application/vnd.api+json`?
    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> Plug.Conn.send_resp(200, schema)
    |> Plug.Conn.halt()
  end
end
