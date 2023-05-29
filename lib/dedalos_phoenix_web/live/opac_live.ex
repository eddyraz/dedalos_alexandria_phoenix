defmodule DedalosPhoenixWeb.OpacLive do
  use DedalosPhoenixWeb, :live_view

  alias DedalosPhoenixWeb.{NavBarLive, LoginLive}

  @impl true
  def mount(_params, _sessions, socket) do
    {:ok, assign(socket, query_p: %{}, is_authenticated: false, redirect: false)}
  end

  @impl true
  defp query_builder(qt) do
    qt
    |> Enum.map(fn {k, v} -> k <> "=" <> v end)
    |> Enum.reduce(fn qterm, acc -> qterm <> "&" <> acc end)
  end

  @impl true
  def handle_event("basic_search", params, socket) do
    filtered_query_params = filter_query_fields(params)

    {:noreply, assign(socket, query_p: filtered_query_params, redirect: true)}

    qterms =
      filtered_query_params
      |> query_builder()

    url_query_parameters = ~p"/results" <> "?" <> qterms

    {:noreply, push_navigate(socket, to: url_query_parameters, replace: false)}
  end

  @impl true
  def handle_event("advanced_search", params, socket) do
    filtered_query_params = filter_query_fields(params)

    {:noreply, assign(socket, query_p: filtered_query_params, redirect: true)}

    qterms =
      filtered_query_params
      |> query_builder()

    url_query_parameters = ~p"/results" <> "?" <> qterms
    {:noreply, push_navigate(socket, to: url_query_parameters, replace: false)}
  end

  defp filter_query_fields(qp) do
    qp
    |> Map.filter(fn {k, v} -> v != "" end)
  end

  def check_profile(usr, pwd, socket) do
    token = get_login_token(usr, pwd, socket)

    {:ok, raw_response} =
      Tesla.get('http://biblioteca.ccpadrevarela.org:8006/auth/users/me/',
        headers: [
          "User-Agent": "Dedalos",
          "Content-Type": "application/json",
          Authorization: "Token #{token}"
        ]
      )

    raw_response.body
    |> Jason.decode()
    |> elem(1)
  end

  @impl true
  def handle_event("check_login_credentials", params, socket) do
    login_token = get_login_token(params["user_name"], params["password"], socket)
    check_profile("eddyraz", "Kotorro4004*", socket)
    send_token_to_browser(socket, params, login_token)
  end

  def send_token_to_browser(socket, params, login_token) do
    if login_token do
      socket = socket |> assign(:is_authenticated, true)
      {:noreply, push_event(socket, "save_login_token", %{payload: login_token})}
    else
      {:noreply, assign(socket, params: params)}
    end
  end

  def blur_component(js \\ %JS{}, tag) do
    js
    |> JS.add_class("blur-sm", to: tag)
  end

  def unblur_component(js \\ %JS{}, tag) do
    js
    |> JS.remove_class("blur-sm", to: tag)
  end

  def get_login_token(usr, pwd, socket) do
    p_body = %{username: usr, password: pwd}

    body = Jason.encode(p_body) |> elem(1)

    raw_response =
      Tesla.post!('http://biblioteca.ccpadrevarela.org:8006/auth/token/login', body,
        headers: ["User-Agent": "Dedalos", "Content-Type": "application/json"]
      )

    raw_response
    |> IO.inspect

    raw_response.body
    |> Jason.decode()
    |> elem(1)
    |> Map.get("auth_token")
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <section>
        <div>
          <%= live_component(@socket, DedalosPhoenixWeb.NavbarLive) %>
        </div>

        <%= if @is_authenticated == false do %>
          <div>
            <%= live_component(@socket, DedalosPhoenixWeb.LoginLive) %>
          </div>
        <% else %>
          <div>
            <%= live_component(@socket, DedalosPhoenixWeb.SearchBarLive, id: 3) %>
          </div>
        <% end %>
        <div>
          <%= live_component(@socket, DedalosPhoenixWeb.FooterLive) %>
        </div>
      </section>
    </div>
    """
  end
end
