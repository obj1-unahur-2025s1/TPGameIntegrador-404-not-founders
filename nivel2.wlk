// archivo: nivel2.wlk

// Importamos todo lo necesario para el nivel 2
import wollok.game.*         // Motor visual del juego
import juego.*               // Controlador de estados del juego
import walter.*              // Personaje principal
import ingrediente.*         // Ingredientes a recolectar
import contenedor.*          // Contenedor final donde se entregan los ingredientes
import dea.*                 // Enemigos DEA
import reloj.*               // Cronómetro del segundo nivel
import pantalla.*            // Para mostrar la pantalla de derrota o victoria

// Objeto que representa el segundo nivel del juego
object nivel2 {

    // Ingredientes que Walter debe juntar (5 en total, en distintas posiciones)
    const ingredientes = [
        new Ingrediente(position = game.at(2,2)),
        new Ingrediente(position = game.at(4,3)),
        new Ingrediente(position = game.at(6,1)),
        new Ingrediente(position = game.at(1,6)),
        new Ingrediente(position = game.at(5,5))
    ]

    // Contenedor final al que Walter debe llegar con los 5 ingredientes
    const elContenedor = new Contenedor(position = game.at(8,8))

    // Lista de enemigos DEA, que se mueven aleatoriamente por el tablero
    var enemigos = [
        new DEA(position = game.at(0,8)),
        new DEA(position = game.at(8,0)),
        new DEA(position = game.at(4,0)),
        new DEA(position = game.at(0,4))
    ]

    // Método que inicia el Nivel 2
    method iniciarNivel() {
        juego.estado("nivel2")                 // Cambiamos el estado global del juego
        game.clear()                           // Limpiamos el tablero de lo anterior
        game.boardGround("nivel2.png")         // Fondo personalizado para el nivel 2

        // Posicionamos a Walter en el origen y vaciamos su mochila
        walter.position(game.at(0,0))
        walter.resetearRecoleccion()
        game.addVisualCharacter(walter)        // Walter se puede mover con las flechas

        // Agregamos los ingredientes al tablero
        ingredientes.forEach({ i => game.addVisual(i) })

        // Agregamos el contenedor al tablero
        game.addVisual(elContenedor)

        // Agregamos visualmente los enemigos
        enemigos.forEach({ e => game.addVisual(e) })

        // Reiniciamos e iniciamos el reloj del nivel
        reloj.reiniciar()                      // Vuelve a 20 segundos
        reloj.iniciar()                        // Comienza a descontar

        // Hacemos que se muevan cada 800ms "movimientoDea" es un nombre que le damos a esta acción (por si después queremos detenerla).
        game.onTick(800, "movimientoDea", { //800 es el tiempo en milisegundos o sea, cada 0.8 segundos.
            enemigos.forEach({ e => e.moverAleatorio() }) //Lo que hace es recorrer la lista de enemigos y a cada uno le manda el mensaje moverAleatorio
        })

        // Colisiones entre Walter y otros elementos
        game.whenCollideDo(walter, { otro =>
            // Si toca un ingrediente → lo recolecta y lo saca del tablero
            if (ingredientes.contains(otro)) {
                ingredientes.remove(otro)
                walter.recolectar(otro)
                game.removeVisual(otro)
            }
            else if (enemigos.contains(otro)) {
                self.perder("¡DEA te atrapó!") // Si toca un DEA → pierde el juego

            }
            else if (otro == elContenedor and walter.mochilaSize() == 5) {
                self.ganar() // Si toca el contenedor y tiene los 5 ingredientes → gana

            }
        })
    }

    // Método para perder el juego, con un mensaje personalizado (DEA o tiempo agotado)
    method perder(mensaje) {
        reloj.detener()                          // Detenemos el cronómetro
        game.removeTickEvent("movimientoDea")    // Dejamos de mover los enemigos
        game.say(walter, mensaje)                // Mostramos mensaje ("DEA te atrapó" o "Se acabó el tiempo")

        game.schedule(1500, {                    // Esperamos 1.5 segundos y mostramos la pantalla final
            game.clear()
            game.boardGround("fondoNegro.png")
            juego.cambiarEstado("perdiste")      // Cambiamos el estado global a "perdiste"
            pantalla.mostrarGameOver()           // Mostramos imagen de derrota
        })
    }

    // Método para ganar el juego correctamente
    method ganar() {
        reloj.detener()                          // Paramos el reloj
        game.removeTickEvent("movimientoDea")    // Detenemos a los enemigos
        game.say(walter, "¡Ganaste!")            // Mostramos mensaje de victoria

        game.schedule(1500, {
            game.clear()
            game.boardGround("fondoNegro.png")
            juego.estado("ganaste")              // Cambiamos el estado global a "ganaste"
            pantalla.mostrarVictoria()           // Mostramos pantalla de victoria
        })
    }

    // Método que se llama cuando el cronómetro llega a 0
    // Si todavía estamos en el nivel 2 → perdemos por tiempo
    method seAcaboElTiempo() {
        if (juego.estado() == "nivel2") {
            self.perder("¡Se acabó el tiempo!")
        }
    }
}
