defmodule DedalosPhoenixWeb.HomeLive do
  use DedalosPhoenixWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a Guess")}
  end

  def render(assigns) do
    ~H"""
     <div>
        <%= live_component(DedalosPhoenixWeb.NavbarLive)%>
      </div>

     <div class="py-20">

        <%= live_component(DedalosPhoenixWeb.CarrouselLive)%>
      </div>

      <div>
        <%= live_component(DedalosPhoenixWeb.AboutLive)%>
      </div>

      <div>
        <%= live_component(DedalosPhoenixWeb.DutiesLive)%>
      </div>
     

    <div>
        <%= live_component(DedalosPhoenixWeb.MembersLive)%>
      </div>

      <div>
        <%= live_component(DedalosPhoenixWeb.FooterLive)%>
      </div>


    """
  end
end
