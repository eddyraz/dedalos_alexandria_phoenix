defmodule DedalosPhoenixWeb.LogoutLive do

  use DedalosPhoenixWeb, :live_view
  
  def mount(_params, _sessions, socket) do
    {:ok, assign(socket, message: Hi, "auth_token": "", is_authenticated: false)}

    
    
  end



  def relocation(socket) do
    push_navigate(socket, to: ~p"/home", replace: false)
    end
  
def render(assigns) do
      ~H"""
      
      """
    end
  end
