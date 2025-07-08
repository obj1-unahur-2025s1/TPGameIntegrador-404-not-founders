import nivel2.*
// archivo: juego.wlk
// Importamos los módulos necesarios para manejar la pantalla y el teclado
import wollok.game.* // Todo lo necesario para mostrar el juego en el tablero
import pantalla.* // Pantalla de presentación, instrucciones, victoria y derrota
import teclado.* 
import nivel1.*// Configuración de teclas (ENTER, C, etc.)
import reloj.*


// 🎮 Este objeto controla el flujo general del juego
object juego {
  // Variable que guarda el estado actual del juego
  // Los posibles valores son:
  // - "inicio" → pantalla de presentación
  // - "instrucciones" → muestra cómo jugar
  // - "nivel1" → primer nivel (fácil)
  // - "nivel2" → segundo nivel (difícil, con enemigos)
  // - "ganaste" → pantalla de victoria
  // - "perdiste" → pantalla de derrota
  var estado = estadoInstrucciones
  
  // Este método se ejecuta al comienzo del juego
  // También se puede usar para reiniciar completamente desde cero
  method iniciar() {
    // estado = estadoInicio // Reiniciamos el estado manualmente
    self.cambiarEstado(estadoInicio)
    
    // Configuración del tablero de juego
    game.width(9) // 9 columnas
    game.height(9) // 9 filas
    game.cellSize(64) // Cada casilla tiene 64px de lado
    game.title("Walter")
    // Nombre visible en la ventana del juego
    // Fondo negro inicial (antes de mostrar cualquier pantalla)
    game.boardGround("Tablero.jpeg")
    
    // Mostramos la pantalla de presentación (imagen de bienvenida)
    // pantalla.mostrarPresentacion()
    
    // Activamos la configuración del teclado (ENTER, C, etc.)
    teclado.configuracion()
    
    // Finalmente iniciamos el juego visual (abre la ventana del tablero)
    game.start()
  }
  
  // Este método permite cambiar el estado actual del juego
  // Por ejemplo: pasar de "inicio" a "instrucciones"
  // También se encarga de limpiar la pantalla y mostrar lo nuevo
  method cambiarEstado(nuevoEstado) {
    estado = nuevoEstado // Actualizamos el estado
    estado.activar()
  }
  
  // Método getter devuelve el estado actual del juego
  method estado() = estado
  
  // Método setter permite cambiar el estado desde otros objetos
  method estado(nuevoEstado) {
    estado = nuevoEstado
  }
}

object configReinicio {

    // Este método asocia la tecla "Enter" con la acción de cerrar las instrucciones
    method habilitarTeclaParaCerrar() {
        keyboard.enter().onPressDo({  // Cuando el jugador presiona la tecla "ENTER"...
          game.clear()               // Borra todo lo que estaba en pantalla
          nivel1.iniciarNivel()      // Llama al método que arranca el primer nivel  
        })
    }
}



class EstadoDeJuego {
  method activar()
}

object estadoInicio inherits EstadoDeJuego {
  override method activar() {
    pantalla.mostrarPresentacion()
    keyboard.enter().onPressDo({
      juego.cambiarEstado(estadoInstrucciones)
    })
  }
}

object estadoInstrucciones inherits EstadoDeJuego {
    override method activar() {
      pantalla.limpiarPantalla()
      pantalla.mostrarInstrucciones()
      keyboard.enter().onPressDo({
      juego.cambiarEstado(estadoNivel1)
    })
    }
}

object estadoNivel1 inherits EstadoDeJuego {
    override method activar() {
        nivel1.iniciarNivel()
    }
    method colisionConEnemigo() {
    nivel1.perder()
}
}

object estadoNivel2 inherits EstadoDeJuego {
  override method activar() {
    // Limpiamos la pantalla y arrancamos el nivel 2
    pantalla.limpiarPantalla()
    nivel2.iniciarNivel()
  }
  method colisionConEnemigo() {
    nivel2.perder()
}
}

object estadoPerdiste inherits EstadoDeJuego {
    override method activar() {
        pantalla.mostrarGameOver()
        configReinicio.habilitarTeclaParaCerrar()
    }
}

object estadoGanaste inherits EstadoDeJuego{
  override method activar() {
    pantalla.mostrarVictoria()
  }
}