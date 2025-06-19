// archivo: walter.wlk
// Importamos Wollok Game para poder usar cosas como game.at()
import wollok.game.*
import nivel1.*

// Este objeto representa al personaje principal: Walter
object walter {
  // Propiedad que indica en qué casilla del tablero está Walter
  // Es necesaria para que game.addVisualCharacter(walter) funcione correctamente
  var property position = game.at(0, 0) // Empieza en la posición (0,0)
  // Lista que representa la mochila de Walter
  // Se usa para guardar los ingredientes recolectados
  const mochila = []
  
  method mochila() = mochila
  
  // Método que devuelve el nombre del archivo de imagen que representa a Walter
  // Este archivo debe estar en la carpeta assets del proyecto
  method image() = "walter.png"
  
  // Método para que Walter recolecte un ingrediente
  // Agrega el ingrediente que recibe por parámetro a su mochila
  method recolectar(ingrediente) {
    mochila.add(ingrediente)
  }
  
  // Método que indica si Walter ya recolectó los 3 ingredientes del Nivel 1
  // Es usado para permitir el paso al siguiente nivel
  method tieneTodosLosIngredientes() = mochila.size() == 5
  
  // Método que devuelve cuántos ingredientes tiene actualmente en su mochila
  // Este método se usa en el Nivel 2 (donde se requieren 5 ingredientes)
  method mochilaSize() = mochila.size()
  
  // Método que vacía la mochila (por ejemplo, cuando empieza un nuevo nivel)
  // Se usa tanto al iniciar el nivel 1 como el nivel 2
  method resetearRecoleccion(nivel) {
    nivel.resetearIngredientes(mochila)
    mochila.clear()
  }
}