defmodule DedalosPhoenixWeb.SearchBarLive do
  use DedalosPhoenixWeb, :live_component

  alias Phoenix.LiveView.JS

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query_params: %{})}
  end

  def get_query_params(qp) do
    # IO.inspect(qp)
    qp
  end


  defp show_content_and_make_tab_visible(js \\ %JS{}, to,tab) do
    js
    |> JS.hide(to: "div.tab-content")
    |> JS.show(to: to)
    |> JS.remove_class("tab-active", to: "a.tab-active")
    |> JS.add_class("tab-active", to: tab)
  end
  
  defp show_active_content(js \\ %JS{}, to) do
    js
    |> JS.hide(to: "div.tab-content")
    |> JS.show(to: to)
  end

  defp set_active_tab(js \\ %JS{}, tab) do
    js
    |> JS.remove_class("tab-active", to: "a.tab-active")
    |> JS.add_class("tab-active", to: tab)
  end

  def render(assigns) do
    ~H"""

    <div>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>

 

  <div class="container">
    <div class="tab_header">
   <div class="tabs">
       <a id="tab_1" class="tab tab-lifted tab-active" phx-click={show_content_and_make_tab_visible("#content_tab_1","#tab_1")}>Busqueda Simple</a> 


        <a id="tab_2" class="tab tab-lifted"  phx-click={show_content_and_make_tab_visible("#content_tab_2","#tab_2")}>Busqueda Avanzada</a> 

   </div>
    </div>

    <div id="content" class="tab_body">
    <div id="content_tab_1" class="tab-content">

      <form class="BasicSearch" phx-submit="basic_search" id="basic_search_form">
 
       <div className="row">
         <div form-group-col col-md-6>   
           <div className="form-group">


             <input type="hidden" id="former_page_login_token"  phx-hook="saveLoginToken"/>
             
             <input type="text" name="título" placeholder="Título" id="search_input_titulo" />
             <br/>
             <input type="text" name="autor.nombre_autor" placeholder="Autor" />
             <br/> 
           </div>   
           
           <div className="form-group">
             <input type="text" name="editorial.nombre_editorial" placeholder="Editorial" />
             <br/>
             <input type="text" name="signatura" placeholder="Signatura" />
             <br/>
             <input type="text" name="descriptor.nombre_descriptor" placeholder="Descriptor" />
             <br/>
           </div>
         </div>

         <div className="radio-group col-md-4 ">
           <p>Defina el criterio de busqueda segun su elección.</p>      
           <br/>
           <input type="radio" id="AND_OP_CHOICE"  name="QUERY_OPERATOR" value="AND" />
           <br/>
           <label htmlFor="AND_OP_CHOICE">Buscar usando todos los términos</label>
           <br/>
           <input type="radio" id="OR_OP_CHOICE" name="QUERY_OPERATOR" checked="OR" value="OR"  />
           <br/>
           <label htmlFor="OR_OP_CHOICE">Buscar usando al menos un término</label>
         </div>
         </div>
      <div className="form-group">
                 <button type="submit" className="btn btn-common" value=""> 
                  <i className="fa fa-search" />
                    Buscar
                 </button>  
      </div>

     </form>

    </div>


    <div id="content_tab_2" class="tab-content hidden">
    <form className="AdvancedSearch" phx-submit="advanced_search" id="advanced_search_form">
                <div className="form-group">
                  <div className="index-selection col-md-3 col-sm-12">
                  <label htmlFor="choice">Tipo de Recurso</label>
                  <br/>
                  <select name="choice"  className="search-index-control">
                    <option value="opac_libros" selected>Libros</option>
                    <option value="opac_articulos_revistas">Artículos de Revistas</option>
                    <option value="opac_tesis">Tesis y Tesinas</option>
                    <option value="opac_docs_dig">Documentos Digitales</option>
                  </select>
                  </div>

                    <div class="search-notes col-md-6 col-sm-12">Para busqueda de terminos exactos poner el texto entre comillas Ej  para editorial "VANGUARDIA CUBANA" o en ISBN "978-959-7126-52-2"</div>  
                    
                </div>
                <br/>
               
                
      <div className="for-group-container row"> 
      <div className="form-group col-md-3">
      
      <input type="text" name="título" placeholder="Título" />
      <br/>
      <input type="text" name="autor.nombre_autor" placeholder="Autor" />
      <br/>
      <input type="text" name="autor2.nombre_autor" placeholder="Autor2" />
      <br/>
      <input type="text" name="autor3.nombre_autor" placeholder="Autor3" />
      <br/>
      </div>   

      <div className="form-group col-md-3">
      <input type="text" name="editorial" placeholder="Editorial" />
      <br/>
      <input type="text" name="signatura" placeholder="Signatura" />
      <br/>
      <input type="text" name="descriptores" placeholder="Descriptor" />
      <br/>

      <input type="text" name="lugar_de_impresión.nombre_ciudad" placeholder="Lugar de Impresion" />
      <br/>
      </div>



      <div className="form-group col-md-3">
              <input type="text" name="resumen" placeholder="Resumen" />
      <br/>

      <input type="text" name="isbn" placeholder="ISBN" />
      <br/>

      <input type="text" name="localización" placeholder="Localización" />
      <br/>
      </div>

      </div>
      <br/>
      <br/>
      <div className="form-group">
                 <button type="submit" className="btn btn-common" value=""> 
                  <i className="fa fa-search" />
                  Buscar
                 </button>  
      </div>

     

                <button type="submit" class="btn btn-common" ><i class="fa fa-search"></i>Buscar Titulo</button>

      </form>
     </div>

    </div>
    </div>

           <button type="submit" class="btn btn-common" ><i class="fa fa-search"></i>Buscar Titulo</button>
      <br>
     
      <div>
        <%= live_component(@socket,DedalosPhoenixWeb.FooterLive) %>
       </div> 

    </div>
    	
    """
  end
end
