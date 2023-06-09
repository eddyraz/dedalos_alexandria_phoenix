defmodule DedalosPhoenixWeb.ResultsTableLive do
  use DedalosPhoenixWeb, :live_view
  use Phoenix.HTML

  alias DedalosPhoenixWeb.{OpacLive, NavBarLive}

  def mount(params, _session, socket) do
    {:ok,
     assign(socket,
       page_number: 1,
       page_size: 10,
       results_qty: 100,
       query_params: params,
       pagination_page: "",
       filtered_results: []
     )}
  end

  def handle_params(params, _uri, socket) do
    {:noreply, get_results(params, socket)}
  end

  def get_results(params, socket) do
    results =
      process_request(params, socket)
      |> Map.fetch!(:results_records)
      |> paginate_response(%{page: params["page_number"], page_size: params["page_size"]})

    assign(socket,
      filtered_results:
        results
        |> Enum.map(fn x -> x |> to_keyword_list() end)
    )
  end

  def build_elastic_index(terms, socket) do
    if terms |> Map.has_key?("QUERY_OPERATOR") do
      %{filter_term: "QUERY_OPERATOR", search_index: "_all"}
    else
      %{filter_term: "choice", search_index: terms["choice"]}
    end
  end

  def process_request(terms, socket) do
    index_terms = build_elastic_index(terms, socket)

    uri_q =
      terms
      |> Enum.reject(fn {k, _v} -> k == index_terms.filter_term end)
      |> Enum.map(fn x -> elem(x, 0) <> ": " <> elem(x, 1) <> " " end)
      |> Enum.intersperse(terms[index_terms.filter_term] <> " ")
      |> to_string()

    p_body = %{query: %{query_string: %{query: uri_q}}}
    body = Jason.encode(p_body) |> elem(1)
    body

    raw_response =
      Tesla.post!(
        'http://biblioteca.ccpadrevarela.org:19200/#{index_terms.search_index}/_search?size=10000',
        body,
        headers: ["User-Agent": "Dedalos", "Content-Type": "application/json"]
      )

    total_res =
      raw_response.body
      |> Jason.decode!()
      |> Map.fetch("hits")
      |> elem(1)
      |> Map.fetch("total")
      |> elem(1)

    results_rec =
      raw_response.body
      |> Jason.decode!()
      |> Map.fetch("hits")
      |> elem(1)
      |> Map.fetch("hits")
      |> elem(1)

    Map.new(total_results: total_res, results_records: results_rec)
  end

  def get_total_pages(assigns, qty_res) do
    #    (assigns.results_qty / assigns.page_size)
    (qty_res / assigns.page_size)
    |> Float.ceil()
    |> round()
  end

  def paginate_response(resp_map, config) do
    Scrivener.paginate(resp_map, config)
  end

  def to_keyword_list(map) do
    Enum.map(map, fn {k, v} ->
      v =
        cond do
          is_map(v) -> to_keyword_list(v)
          true -> v
        end

      {String.to_atom("#{k}"), v}
    end)
  end

  @impl true
  def handle_event("page_change", params, socket) do
    socket = assign(socket, page_number: params["page_number"] |> String.to_integer())

    {:noreply, socket}
  end

  def fa_icon_generator(id) do
    case id do
      "opac_libros" -> %{name: "book", label_text: "Libro"}
      "opac_articulos_revistas" -> %{name: "newspaper", label_text: "Artículo de Revista"}
      "opac_docs_dig" -> %{name: "file-pdf", label_text: "Documento Digital"}
      "opac_tesis" -> %{name: "graduation-cap", label_text: "Tesis o Tesina"}
      _ -> ""
    end
  end

  def handle_event("reload_search", params, socket) do
    {:noreply, push_navigate(socket, to: ~p"/opac", replace: true)}
  end

  def truncate_text(str) do
    str_len = str |> String.length()

    if str_len > 150 do
      str
      |> String.slice(0..150)
      |> String.pad_trailing(153, ".")
    else
      str
    end
  end

  def render(assigns) do
    total_results =
      process_request(assigns.query_params, @socket)
      |> Map.fetch!(:total_results)

    results =
      process_request(assigns.query_params, @socket)
      |> Map.fetch!(:results_records)
      |> paginate_response(%{page: assigns.page_number, page_size: assigns.page_size})

    filtered_results =
      results
      |> Enum.map(fn x -> x |> to_keyword_list() end)

    ~H"""
    <div>
      <%= live_component(@socket, DedalosPhoenixWeb.NavbarLive) %>
    </div>
    <br />
    <br />
    <br />

    <button
      phx-click="reload_search"
      type="button"
      class="inline-block ml-4 my-10 hover:bg-gray-200 hover:text-light-golden-rod-yellow px-6 py-2.5 bg-gray-800 text-white font-medium text-xs leading-tight uppercase rounded shadow-md hover:bg-gray-900 hover:shadow-lg focus:bg-gray-900 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-gray-900 active:shadow-lg transition duration-150 ease-in-out"
    >
      Volver a Buscar
    </button>

    <div class="localResults mx-4 py-1">
      <h4>Se han obtenido <%= total_results %> resultados</h4>
    </div>

    <div class="remoteResults mx-4 py-1">
      <h4>
        Para resultados en otras bibliotecas pulse
        <a href="http://biblioteca.ccpafrevarela.org:4007/results/#RemoteTable">aquí</a>
      </h4>
    </div>

    <div class="flex justify-left">
      <div class="ml-4 mb-3 xl:w-96">
        <input
          type="input"
          class="
        form-control
        block
        w-full
        px-3
        py-1.5
        text-base
        font-normal
        text-gray-700
        bg-white bg-clip-padding
        border border-solid border-gray-300
        rounded
        transition
        ease-in-out
        m-0
        focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none
      "
          phx-hook="searchFilter"
          id="fzf"
          placeholder="Filtre los Resultados"
        />

        <div class="text-sm text-gray-500 mt-1"></div>
      </div>
    </div>

    <div class="flex justify-center">
      <table class="table-auto min-w-full  border border-gray:900 " id="results_table">
        <thead class="bg-dedalos-green h-10 text-whitesmoke">
          <tr class="min-h-auto">
            <th class="p-2 border-r cursor-pointer">Signatura</th>
            <th class="p-2 border-r cursor-pointer">Tipo de Recurso</th>
            <th class="p-2 border-r cursor-pointer">Titulo</th>
            <th class="p-2 border-r cursor-pointer">Autor</th>
            <th class="p-2 border-r cursor-pointer">Autor2</th>
            <th class="p-2 border-r cursor-pointer">Resumen</th>
            <th class="p-2 border-r cursor-pointer">ISBN</th>
          </tr>
        </thead>
        <tbody>
          <%= for y <- filtered_results do %>
            <tr id="dedalos_tr" class="border-b-gray-300 even:bg-white odd:bg-gray-200 hover:bg-gray-600 hover:text-light-golden-rod-yellow">
              <td class="p-2 border-r border-gray-300"><%= y[:_source][:signatura] %></td>
              <td class="p-2 border-r border-gray-300">
                <section>
                  <span class="resource_icon_text">
                    <FontAwesome.LiveView.icon
                      name={fa_icon_generator(y[:_index]).name}
                      type="solid"
                      class="h-4 w-4"
                    /> <%= fa_icon_generator(y[:_index]).label_text %>
                  </span>
                </section>
              </td>
              <td class="p-2 border-r border-gray-300"><%= y[:_source][:título] %></td>
              <td class="p-2 border-r border-gray-300"><%= y[:_source][:autor][:nombre_autor] %></td>
              <td class="p-2 border-r border-gray-300"><%= y[:_source][:autor2][:nombre_autor] %></td>

              <td class="p-2 border-r border-gray-300">
                <div class="tooltip tooltip-warning" data-tip={y[:_source][:resumen]}>
                  <%= y[:_source][:resumen] |> truncate_text() %>
                </div>
              </td>

              <td class="p-2 border-r border-gray-300"><%= y[:_source][:isbn] %></td>
            </tr>
          <% end %>
        </tbody>
      </table>
    </div>





    <div class="flex justify-center my-10">
      <nav aria-label="Page navigation example">
        <ul class="flex list-style-none">
          <li class="page-item disabled">
            <a
              class="page-link relative block py-1.5 px-3 rounded border-0 bg-transparent outline-none transition-all duration-300 rounded text-gray-500 pointer-events-none focus:shadow-none"
              href="#"
              tabindex="-1"
              aria-disabled="true"
            >
              Anterior
            </a>
          </li>

          <%= if  get_total_pages(assigns,total_results)  <= 15   do %>
            <%= for i <- 1..get_total_pages(assigns,total_results) do %>
              <li class="page-item">
                <a
                  phx-click="page_change"
                  phx-value-page_number={i}
                  class="page-link relative block py-1.5 px-3 rounded border-0 bg-transparent outline-none transition-all duration-300 rounded text-gray-800 hover:text-gray-800 hover:bg-gray-200 focus:shadow-none"
                  href="#"
                >
                  <%= i %>
                </a>
              </li>
            <% end %>
          <% else %>
            <%= for i <- 1..15 do %>
              <li class="page-item">
                <a
                  phx-click="page_change"
                  phx-value-page_number={i}
                  class="page-link relative block py-1.5 px-3 rounded border-0 bg-transparent outline-none transition-all duration-300 rounded text-gray-800 hover:text-gray-800 hover:bg-gray-200 focus:shadow-none"
                  href="#"
                >
                  <%= i %>
                </a>
              </li>
            <% end %>
          <% end %>

          <li class="page-item">
            <a phx-click="page_change" class="page-link relative block py-1.5 px-3 rounded border-0 bg-transparent outline-none transition-all duration-300 rounded text-gray-800 hover:text-gray-800 hover:bg-gray-200 focus:shadow-none"
              href="#" >
              Siguiente
            </a>
          </li>
        </ul>
      </nav>
    </div>
    """
  end
end
