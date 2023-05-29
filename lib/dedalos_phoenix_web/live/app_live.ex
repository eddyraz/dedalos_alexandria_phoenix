defmodule DedalosPhoenixWeb.AppLive do

  use DedalosPhoenixWeb, :live_view ;

  def mount(_params, _sessions, socket) do
    {:ok, assign(socket, score: 0, message: "system Loaded")}
    end

  def render(assigns) do

    ~H"""
     <div>
        <%= live_component(@socket,DedalosPhoenixWeb.NavbarLive)%>
      </div>

     <div>
        <%= live_component(@socket,DedalosPhoenixWeb.CarrouselLive)%>
      </div>

      <div>
        <%= live_component(@socket,DedalosPhoenixWeb.AboutLive)%>
      </div>
     """
    
    end

  end
