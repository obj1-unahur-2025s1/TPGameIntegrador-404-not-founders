import wollok.game.*
import walter.*
import nivel1.*
import juego.*

class Elemento {
    var property position

    method image()
    method alColisionarConWalter()
}
// Clase que representa a un enemigo de tipo DEA
class DEA inherits Elemento{

    // Cada objeto DEA tiene una posición en el tablero (como todos los visuales)
    // Imagen que representa visualmente a una DEA
    override method image() = "dea.png"
    override method alColisionarConWalter() {
        juego.estado().colisionConEnemigo()
    }

    // Este método hace que la DEA se mueva en una dirección aleatoria segura
    method moverAleatorio() {

        // Calculamos las 4 posiciones posibles a las que podría moverse (arriba, abajo, izq, der)
        const posibles = [
            position.up(1),      // Una celda hacia arriba
            position.down(1),    // Una celda hacia abajo
            position.left(1),    // Una celda hacia la izquierda
            position.right(1)    // Una celda hacia la derecha
        ]

        // Filtramos solo las posiciones válidas:
        // Que estén dentro del tablero Y que no haya otra DEA en esa posición
        const posicionesValidas = posibles.filter({ pos =>
            pos.x() >= 0 and pos.x() < game.width() and     // Dentro del ancho del tablero
            pos.y() >= 0 and pos.y() < game.height()         // Dentro del alto del tablero                       
        })

        // Si hay al menos una posición válida, elige una al azar y se mueve
        if (!posicionesValidas.isEmpty()) {
            position = posicionesValidas.anyOne() //filtra solo las válidas 
            //(que estén dentro del tablero y sin otra DEA), y si hay alguna libre, 
            //se mueve a una de ellas al azar con .anyOne()
        }
    }
}

class Ingrediente inherits Elemento{
// cada ingrediente tiene una posición en el tablero
    override method image() = "ingrediente.png"
    override method alColisionarConWalter() {
        walter.recolectar(self)
        game.removeVisual(self)
        nivel1.removerIngrediente(self)  // Esto lo vamos a definir
    }
}

class Contenedor inherits Elemento {
    override method image() = "laboratory.png"

    override method alColisionarConWalter() {
        // Este comportamiento depende del nivel, así que por ahora puede no hacer nada
        // porque en nivel1 y nivel2 ya se maneja esa colisión por separado
    }
}

