// archivo: nivel1.wlk

// Importamos todo lo que necesitamos para este nivel
import wollok.game.*           // Herramientas del motor de juego
import juego.*                 // Para cambiar el estado del juego
import walter.*                // Nuestro personaje jugable
import elementos.*           // Clase que representa ingredientes
import nivel2.*                // Importamos nivel2 para pasar a él más adelante
import pantalla.*
import instrucciones.*

// Objeto principal del primer nivel del juego
object nivel1 {

    // Lista de ingredientes que estarán en el tablero
    // Cada uno tiene una posición inicial definida
    const ingredientes = [
        new Ingrediente(position = game.at(3,3)),
        new Ingrediente(position = game.at(5,1)),
        new Ingrediente(position = game.at(6,6)),
        new Ingrediente(position = game.at(1,2)),
        new Ingrediente(position = game.at(4,5))
    ]

    const enemigos = [
        new DEA(position = game.at(3,1)),
        new DEA(position = game.at(4,6)),
        new DEA(position = game.at(5,5)),
        new DEA(position = game.at(2,3)),
        new DEA(position = game.at(7,3)),
        new DEA(position = game.at(8,5)),
        new DEA(position = game.at(0,6))
    ]

    method resetearIngredientes(elementos){
        ingredientes.addAll(elementos)
    }

    // Contenedor al que Walter debe llevar los ingredientes
    const elContenedor = new Contenedor(position = game.at(1,7))

    // Método que inicia el Nivel 1
    method iniciarNivel() {
        // Mensaje de prueba para saber que entramos correctamente, igual creo que no funciona
        game.say(game, "Entrando al Nivel 1")

        // Cambiamos el estado global del juego
        juego.estado("nivel1")

        // Limpiamos el tablero y ponemos el fondo del nivel 1
        game.clear()
        game.boardGround("Tablero.jpeg")  // El fondo del nivel debe estar en la carpeta assets

        //  Colocamos a Walter en su posición inicial y le vaciamos la mochila
        walter.position(game.at(0,0))
        walter.resetearRecoleccion(self)
        game.addVisualCharacter(walter)  // Esto lo hace controlable con las flechas

        // Agregamos todos los ingredientes al tablero
        ingredientes.forEach({ i => game.addVisual(i) })
        enemigos.forEach({ i => game.addVisual(i) })

        // Agregamos el contenedor donde Walter debe entregar lo recolectado
        game.addVisual(elContenedor)

        // Colisiones entre Walter e ingredientes
        // Si Walter toca un ingrediente, lo recoge y desaparece del tablero
        game.whenCollideDo(walter, { otro =>
            if (ingredientes.contains(otro)) {
                walter.recolectar(otro)      // Se guarda el ingrediente en la mochila
                game.removeVisual(otro)      // Se lo remueve visualmente del tablero
                ingredientes.remove(otro)    // Se lo elimina de la lista interna
            }
            else if (enemigos.contains(otro)) {
                self.perder() // Si toca un DEA → pierde el juego

            }
        })

        // Colisión con el contenedor
        // Si Walter tiene los 3 ingredientes cuando llega al contenedor, pasa al Nivel 2
        game.whenCollideDo(walter, { otro =>
            if (otro == elContenedor and walter.tieneTodosLosIngredientes()) {
                game.say(walter, "¡Pasás al Nivel 2!")  // Mensaje de aviso
                game.schedule(1500, {       
                    walter.resetearRecoleccion(self)            // Esperamos 1.5 segundos antes de cambiar
                    nivel2.iniciarNivel()               // Pasamos al Nivel 2
                })
            }
        })
    }

    method perder() {
        game.schedule(500, {                    // Esperamos 1.5 segundos y mostramos la pantalla final
            game.clear()
            game.boardGround("fondoNegro.png")
            juego.cambiarEstado("perdiste")      // Cambiamos el estado global a "perdiste"
            pantalla.mostrarGameOver()           // Mostramos imagen de derrota
            configReinicio.habilitarTeclaParaCerrar()
        })
    }
}
