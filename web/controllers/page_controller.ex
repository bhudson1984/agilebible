defmodule Agilebible.PageController do
  use Agilebible.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
