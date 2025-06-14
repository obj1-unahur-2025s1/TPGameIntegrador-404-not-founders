import wollok.game.*

// ---------------------------
// CONFIGURACIÓN DEL JUEGO
// ---------------------------
// Guarda la partida actual para poder acceder fácilmente
//a ella desde cualquier archivo
// ---------------------------
// CONFIGURACIÓN DEL JUEGO
// ---------------------------
// Este objeto se usa como "oficina central" del juego.
// Sirve para saber en qué partida (nivel) estamos, y acceder al personaje
// o a cualquier otra cosa general desde otros archivos sin repetir lógica.
//
// Por ejemplo, si estamos en el nivel 1, partidaActual es partida1,
// y al pasar de nivel, cambia a partida2 automáticamente.
// Así podemos decir:
// configuracion.personaje() y no importa el nivel.
object configuracion {
  var property partidaActual = partida1 // Empezamos por partida1

  method personaje() = partidaActual.personaje() // Acceso directo a Gualter
}


// ---------------------------
// CLASE PARTIDA
// ---------------------------
// Representa un nivel del juego. Controla:
// - Cuántos ingredientes hay que entregar
// - Cuántos se entregaron
// - Qué pasa al entregar todos
// - Cómo reiniciar
class Partida {
  const siguientePartida
  var property personaje
  var property objetivo       // Cantidad total a entregar
  var property entregados = 0 // Contador

  method iniciar() {
    // Cuando arranca el nivel, se agregan todos los objetos al juego
    game.addVisual(personaje)
  }

  method entregarIngrediente() {
    entregados += 1
    game.say(personaje, "¡Entregaste un ingrediente! Total: " + entregados)

    if (entregados == objetivo) {
      self.pasarDeNivel()
    }
  }

  method reiniciar() {
    // Borra todo y vuelve a empezar
    game.allVisuals().forEach({v => game.removeVisual(v)})
    entregados = 0
    personaje.reiniciar()
    self.iniciar()
  }

  method pasarDeNivel() {
    game.say(personaje, "¡Nivel completo!")
    game.allVisuals().forEach({v => game.removeVisual(v)})
    configuracion.partidaActual(siguientePartida)
    siguientePartida.iniciar()
  }
}


// ---------------------------
// PERSONAJE PRINCIPAL: GUALTER
// ---------------------------
object gualter {
  var property position = game.at(1,1)
  var property llevaIngrediente = false

  method image() = "gualter.png"

  method reiniciar() {
    position = game.at(1,1)
    llevaIngrediente = false
  }

  method agarrarIngrediente(ingrediente) {
    llevaIngrediente = true
    ingrediente.eliminar()
    game.say(self, "Agarraste un ingrediente")
  }

  method entregarIngrediente() {
    if (llevaIngrediente) {
      configuracion.partidaActual().entregarIngrediente()
      llevaIngrediente = false
    } else {
      game.say(self, "¡No estás llevando nada!")
    }
  }
}


// ---------------------------
// CLASE INGREDIENTE
// ---------------------------
class Ingrediente {
  const x
  const y
  var property position = game.at(x, y)

  method image() = "ingrediente.png"

  method iniciar() {
    game.addVisual(self)
    game.whenCollideDo(self, {jugador => jugador.agarrarIngrediente(self)})
  }

  method eliminar() {
    game.removeVisual(self)
  }
}


// ---------------------------
// OBJETO CONTENEDOR
// ---------------------------
object contenedor {
  var property position = game.at(16,1)

  method image() = "contenedor.png"

  method iniciar() {
    game.addVisual(self)
    game.whenCollideDo(self, {jugador => jugador.entregarIngrediente()})
  }
}
