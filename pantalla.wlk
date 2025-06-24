import wollok.game.*
import juego.*

object pantalla {
  // Visuales estáticos
  const presentacion = new Fondo(img = "PrWalter.png")
  const victoria = new Fondo(img = "ganador.png")
  const derrota = new Fondo(img = "perder3.png")
  const instruccion = new Fondo (img= "instruccionInicio.png")
  
  // Limpia todo el tablero y coloca fondo neutro
  method limpiarPantalla() {
    game.clear()
    game.boardGround("Tablero.jpeg")
  }
  
  // Pantalla de título
  method mostrarPresentacion() {
    game.addVisual(presentacion)
  }
  
  // Instrucciones del juego
  method mostrarInstrucciones() {
    game.addVisual(instruccion)
  }
  
  // Pantalla de victoria
  method mostrarVictoria() {
    game.addVisual(victoria)
  }
  
  // Pantalla de derrota
  method mostrarGameOver() {
    game.addVisual(derrota)
  }
} // Clase visual básica para mostrar una imagen en el tablero

class Fondo {
  var property position = game.at(0, 0)
  const img
  
  method image() = img
}