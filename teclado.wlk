import wollok.game.*               // Biblioteca principal de Wollok Game
import juego.*                     // Accedemos al estado del juego
import instrucciones.*             // Para mostrar la pantalla de instrucciones
import nivel1.*                    // (todavía no usado acá, pero sirve si después queremos avanzar al juego)

// Objeto que se encarga de configurar los controles del teclado
object teclado {

    // Método que asigna acciones a teclas
    method configuracion() {

        // Acción para cuando el jugador presiona la tecla ENTER
        keyboard.enter().onPressDo({

            // Guardamos el estado actual del juego en una variable
            const estadoActual = juego.estado()

            // Si el estado es "inicio" (pantalla de presentación):
            if (estadoActual == "inicio") {
                juego.estado("instrucciones")    // Cambiamos el estado a "instrucciones"
                game.clear()                     // Limpiamos el tablero visual
                instrucciones.mostrar()          // Mostramos las instrucciones 
            }
        })
    }
}
