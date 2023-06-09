defmodule DedalosPhoenixWeb.LoginLive do
  use DedalosPhoenixWeb, :live_component
  alias ElixirSense.Plugin
  alias Phoenix.HTML
  alias Phoenix.Plug.Conn

  alias Phoenix.LiveView.JS

  def mount(_params, _sessions, socket) do
    {:ok, assign(socket, message: "Hi", id: 4)}
  end





  def render(assigns) do
    ~H"""
    <section class="h-screen">
    <div class="px-6 h-full text-gray-800">
    <div
      class="flex xl:justify-center lg:justify-between justify-center items-center flex-wrap h-full g-6"
    >
      <div
        class="grow-0 shrink-1 md:shrink-0 basis-auto xl:w-6/12 lg:w-6/12 md:w-9/12 mb-12 md:mb-0"
    >

    <span>

    <img class="block h-200 w-auto " src={~p"/images/slider/bg-1.jpg"} alt="biblioteca CCPFV"/>

    </span>
         </div>
      <div class="xl:ml-20 xl:w-5/12 lg:w-5/12 md:w-8/12 mb-12 md:mb-0">


        <form phx-submit="check_login_credentials"  id="login_form">

          <div class="flex flex-row items-center justify-center lg:justify-start">
            <p class="font-extrabold text-lg font-serif mb-0 mr-4  ">Biblioteca Centro Cultural Padre Félix Varela</p>
              </div>

          <div
            class="flex items-center my-4 before:flex-1 before:border-t before:border-gray-300 before:mt-0.5 after:flex-1 after:border-t after:border-gray-300 after:mt-0.5"
          >
            <p class="text-center font-semibold mx-4 mb-0"></p>
          </div>

          <!-- Username input -->
          <div class="mb-6">



         <input type="text" name="user_name" class="form-control block w-full px-4 py-2 text-xl font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
              id="exampleFormControlInput1"
              placeholder="Nombre de usuario"
            />


           </div>

          <!-- Password input -->
          <div class="mb-6">
            <input
              type="password" name="password"
              class="form-control block w-full px-4 py-2 text-xl font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
              id="exampleFormControlInput2"
              placeholder="Contraseña"
            />
          </div>

          <div class="flex justify-between items-center mb-6">
            <div class="form-group form-check">
    <!--              <input
                type="checkbox"
                class="form-check-input appearance-none h-4 w-4 border border-gray-300 rounded-sm bg-white checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain float-left mr-2 cursor-pointer"
                id="exampleCheck2"
              />
              <label class="form-check-label inline-block text-gray-800" for="exampleCheck2">Remember me</label>  -->
            </div>
    <!--            <a href="#!" class="text-gray-800">Forgot password?</a> -->
          </div>


          <div class="text-center lg:text-left">
            <button
              type="submit"
              class="inline-block px-7 py-3 bg-gray-600 text-white font-medium text-sm leading-snug uppercase rounded shadow-md hover:bg-green-700 hover:shadow-lg focus:bg-green-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-green-800 active:shadow-lg transition duration-150 ease-in-out"
            >
              Entrar
            </button>
            <p class="text-sm font-semibold mt-2 pt-1 mb-0">
              ¿No tiene una cuenta?
              <a
                href="http://biblioteca.ccpadrevarela.org:8006/register"
                class="text-red-600 hover:text-red-700 focus:text-red-700 transition duration-200 ease-in-out"
                >Registrese</a>
            </p>
          </div>
        </form>
      </div>
    </div>
    </div>
    </section>





    """
  end
end
