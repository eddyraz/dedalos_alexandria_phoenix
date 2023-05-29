defmodule DedalosPhoenixWeb.CarrouselLive do
  use DedalosPhoenixWeb, :live_component


  def mount(_params, _session, socket) do
        {:ok, assign(socket, score: 0, message: "Hooola")}
    end

end
