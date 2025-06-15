
import wollok.game.*
import juego.*

object pantalla {

    // Visuales estáticos
    const presentacion = new Fondo(img = "presentacion.png")
    const instrucciones = new Fondo(img = "instrucciones.png")
    const victoria = new Fondo(img = "ganaste.png")
    const derrota = new Fondo(img = "gameOver.png")

    // Limpia todo el tablero y coloca fondo neutro
    method limpiarPantalla() {
        game.clear()
        game.boardGround("fondoNegro.png")
    }

    // Pantalla de título
    method mostrarPresentacion() {
        game.addVisual(presentacion)
    }

    // Instrucciones del juego
    method mostrarInstrucciones() {
        game.addVisual(instrucciones)
    }

    // Pantalla de victoria
    method mostrarVictoria() {
        game.addVisual(victoria)
    }

    // Pantalla de derrota
    method mostrarGameOver() {
        game.addVisual(derrota)
    }
}

// Clase visual básica para mostrar una imagen en el tablero
class Fondo {
    var property position = game.at(0, 0)
    const img
    method image() = img
}
