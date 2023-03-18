defmodule DedalosPhoenixWeb.PaginatorLive do

  
  use DedalosPhoenixWeb, :live_component
  
  def mount(_params, _sessions, socket) do
   {:ok, assign(socket, response_params: [],)}

    end

   def paginate_reponse(resp) do
     :ok
     end
  
  def render(assigns) do
    ~H"""
     <div>
     Hi
    </div>
     """
    end

  end
