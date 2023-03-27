defmodule DedalosPhoenixWeb.AboutLive do
  use DedalosPhoenixWeb, :live_component

  def mount(_params, _sessions, socket) do
    {:ok, assign(socket, score: 10, message: "system loaded")}
    end

  def render(assigns) do
    ~H"""
      <div>
       <section>
        <div>
          <br>
          <br>
          <br>
          <%= live_component(@socket,DedalosPhoenixWeb.NavbarLive)%>
        </div>
         <div>
        <section className="split section">
      <div className="container">
        <div className="row">
          <div className="col-md-4 col-sm-6 col-xs-12 wow animated fadeInLeft" data-wow-delay=".3s">
            <div className="images">
              <img src={ChoiceImg} alt=""/>
            </div>
          </div>
          <div className="col-md-8 col-sm-6 col-xs-12 wow animated fadeInRight" data-wow-delay=".3s">
            <div className="content-inner">
              <h2 className="title">Reseña de la Biblioteca del Centro Cultural Padre Félix Varela</h2>
              <p className="lead">La Biblioteca del Centro Cultural P. Félix Varela surge a partir 
              del acervo de valiosas colecciones donadas al Centro entre las que se encuentran la Biblioteca 
              del Arzobispado de La Habana, La Biblioteca de la Casa Laical, La Biblioteca personal de 
              S.E.R. Cardenal Jaime Ortega Alamino y la sala cubana del Seminario San Carlos y San Ambrosio, 
              siendo esta última considerada la segunda más valiosa en Cuba por los fondos que atesora sobre la cultura 
              e historia de nuestro país.</p>
              
              

              <p>
                Es una biblioteca Académica, establecida, mantenida y administrada por una administración de enseñanza
                , con el fin de cubrir las necesidades de información de los estudiantes y aportar programas educativos 
                de investigación y demás servicios.                
              </p>

             <p>
              El 9 de marzo del 2015 la Biblioteca abrió sus puertas con 1500 volúmenes (libros y folletos) a usuarios internos. Actualmente está abierta al público en general,
               y contiene más de 14000 volúmenes..

              </p>


             <h3 className="title">OBJETIVOS</h3> 
              <p>
                 Apoyar los programas educativos y de investigación del Instituto de Estudios Ecleciásticos
                 , a través de un fondo bibliográfico de carácter general, con colecciones orientadas a los programas de estudios.
              </p>
              
              <p>
                  Ofrecer servicios tradicionales y especializados con valor agregados, que respondan a las necesidades de información de los usuarios
                  del Centro Cultural Padre Félix Varela.
              </p>

              

            </div>
          </div>
        </div>
        <hr/>

                 <hr/>

      </div>
    </section>
      </div>
          

         <div>
        <%= live_component(@socket,DedalosPhoenixWeb.ServicesLive,id: 3 )%>
        
        </div>


       <div>
        <%= live_component(@socket,DedalosPhoenixWeb.DutiesLive,id: 3 )%>
       </div>


             <div>
          <%= live_component(@socket,DedalosPhoenixWeb.FooterLive )%>
        </div>

       </section>
       </div>

     """

    end

  end
