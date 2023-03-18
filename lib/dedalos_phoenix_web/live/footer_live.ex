defmodule DedalosPhoenixWeb.FooterLive do

  use DedalosPhoenixWeb, :live_component

  def mount(_params, _sessions, socket) do
    {:ok, assign(socket, message: "Hie")}
    

    end

  def render(assigns) do

    ~H"""
      <div>
          <footer>
          
            <div className="container">
          
              <div className="row section">
          
                <div className="footer-widget col-md-4 col-xs-12 wow fadeIn">
                  <h3 className="small-title">
                    NUESTRA BIBLIOTECA EN LOS MEDIOS
                  </h3>
                  <p>
                    Tenemos presencia en las redes sociales para una mayor visibilidad, 
                  </p> 
                  <p>Allí tambien podrá encontrar boletines, nuestras ultimas 
                     adquisiciones y acceso a eventos públicos.</p>
                  <div className="social-footer">
                    <a href="#cosmetics"><i className="fa fa-facebook icon-round"></i></a>
                    <a href="https://twitter.com/ccpfv"><i className="fa fa-twitter icon-round"></i></a>
                    <a href="#cosmetics"><i className="fa fa-instagram icon-round"></i></a>
                    <a href="#cosmetics"><i className="fa fa-youtube icon-round "></i></a>
                  </div>           
                </div>
                
                
                <div className="footer-widget col-md-4 col-xs-12 wow fadeIn" data-wow-delay=".8s">
                  <h3 className="small-title">
                    SUSCRIBASE A NUESTRO BOLETÍN
                  </h3>
                <div className="contact-us">
                    <p>Contáctenos para enviarle nuestro boletín</p>
                    <form>
                    <div className="form-group">
                      <input type="text" className="form-control" id="exampleInputName2" placeholder="Nombre y Apellidos"/>
                    </div>
                    <div className="form-group">
                      <input type="email" className="form-control" id="exampleInputEmail2" placeholder="correo electrónico"/>
                    </div>
                    <button type="submit" className="btn btn-common">Suscribirse</button>
                    </form>
                  </div>
                </div>

		
                <div className="footer-widget col-md-4 col-xs-12 wow fadeIn" data-wow-delay=".8s">

		  <h3 className="small-title"> DONDE ESTAMOS  </h3>
		  <div className="images">

		   <img src={~p"/images/MapaCCPFV.jpg"} alt="Mapa de la biblioteca CCPFV" />   


     
		  </div>
		</div>

		
              </div>
            </div>
            
            
            <div id="copyright">
              <div className="container">
                <div className="row">
                  <div className="col-md-12 col-sm-12">
                    <p className="copyright-text">
                      ©  2020 <a href="https://www.miraliasoft.com">MIRALIASOFT.</a> Todos los derechos reservados.
                    </p>
                  </div>
                </div>
              </div>
            </div>
            
            
          </footer>
         
      
            </div>

 
     """

    end


  end
