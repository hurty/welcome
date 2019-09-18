defmodule WelcomeWeb.PageController do
  use WelcomeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
