defmodule WelcomeWeb.BoardControllerTest do
  use WelcomeWeb.ConnCase

  test "get applicant board", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Applicants Board"
  end
end
