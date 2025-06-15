// archivo: juego.wlk

// Importamos los módulos necesarios para manejar la pantalla y el teclado
import wollok.game.*       // Todo lo necesario para mostrar el juego en el tablero
import pantalla.*          // Pantalla de presentación, instrucciones, victoria y derrota
import teclado.*           // Configuración de teclas (ENTER, C, etc.)

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
    var estado = "inicio"

    // Este método se ejecuta al comienzo del juego
    // También se puede usar para reiniciar completamente desde cero
    method iniciar() {
        estado = "inicio"                       // Reiniciamos el estado manualmente

        // Configuración del tablero de juego
        game.width(9)                           // 9 columnas
        game.height(9)                          // 9 filas
        game.cellSize(64)                       // Cada casilla tiene 64px de lado
        game.title("Walter y la Receta Final")  // Nombre visible en la ventana del juego

        // Fondo negro inicial (antes de mostrar cualquier pantalla)
        game.boardGround("fondoNegro.png")

        // Mostramos la pantalla de presentación (imagen de bienvenida)
        pantalla.mostrarPresentacion()

        // Activamos la configuración del teclado (ENTER, C, etc.)
        teclado.configuracion()

        // Finalmente iniciamos el juego visual (abre la ventana del tablero)
        game.start()
    }

    // Este método permite cambiar el estado actual del juego
    // Por ejemplo: pasar de "inicio" a "instrucciones"
    // También se encarga de limpiar la pantalla y mostrar lo nuevo
    method cambiarEstado(nuevoEstado) {
        estado = nuevoEstado                   // Actualizamos el estado

        pantalla.limpiarPantalla()             // Limpiamos todo lo anterior del tablero

        // Según el estado nuevo, mostramos lo que corresponda
        if (estado == "instrucciones") {
            pantalla.mostrarInstrucciones()
        }

        // Ojolos demás estados como "nivel1", "ganaste", etc.
        // se manejan desde otros archivos (como nivel1.wlk, nivel2.wlk)
    }

    // Método getter devuelve el estado actual del juego
    method estado() = estado

    // Método setter permite cambiar el estado desde otros objetos
    method estado(nuevoEstado) {
        estado = nuevoEstado
    }
}
