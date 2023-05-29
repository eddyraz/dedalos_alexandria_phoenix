defmodule AuthHelper do
  import Phoenix.LiveView

  def check_token(socket) do
    case socket.assigns[:live_storage] do
      %{token: token} ->
        if token != "" do
          socket
        else
          redirect(socket, to: "/login")
        end

      _ ->
        redirect(socket, to: "/login")
    end
  end
end
