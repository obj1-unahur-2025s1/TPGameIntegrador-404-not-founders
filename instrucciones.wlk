// archivo: instrucciones.wlk

// Importamos todo lo necesario
import wollok.game.*           // Motor del juego (para mostrar imágenes, posiciones, teclado, etc.)
import nivel1.*                // Importamos el nivel 1, porque se activa cuando cerramos instrucciones
import juego.*                 // Importamos el juego para poder cambiar su estado

// Este objeto representa la pantalla de instrucciones del juego
object instrucciones {

    // Posición fija donde se va a mostrar la imagen de instrucciones (esquina superior izquierda)
    var property position = game.at(0, 0)

    // Imagen que se va a usar como fondo de instrucciones
    method image() = "instruccionInicio.png"   // Este archivo debe estar en la carpeta assets del proyecto

    // Este método agrega la imagen al juego y configura la tecla para continuar
    method mostrar() {
        game.addVisual(self)                           // Muestra la imagen en pantalla
        configInstrucciones.habilitarTeclaParaCerrar() // Activa que la tecla "C" cierre la pantalla
    }

    // Este método se llama cuando se presiona "C"
    // Limpia el tablero, cambia el estado a "nivel1", e inicia el primer nivel del juego
    method cerrar() {
        game.clear()               // Borra todo lo que estaba en pantalla
        juego.estado("nivel1")     // Cambia el estado del juego a "nivel1"
        nivel1.iniciarNivel()      // Llama al método que arranca el primer nivel
    }
}

// Este objeto configura el comportamiento del teclado para las instrucciones
object configInstrucciones {

    // Este método asocia la tecla "C" con la acción de cerrar las instrucciones
    method habilitarTeclaParaCerrar() {
        keyboard.enter().onPressDo({               // Cuando el jugador presiona la tecla "C"...
            instrucciones.cerrar()             // ...se ejecuta el método cerrar del objeto instrucciones
        })
    }
}


