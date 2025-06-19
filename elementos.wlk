import wollok.game.*

class Elemento {
    var property position

    method image()
}
// Clase que representa a un enemigo de tipo DEA
class DEA inherits Elemento{

    // Cada objeto DEA tiene una posición en el tablero (como todos los visuales)
    // Imagen que representa visualmente a una DEA
    override method image() = "dea.png"

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
            pos.y() >= 0 and pos.y() < game.height() and    // Dentro del alto del tablero
            !self.hayOtraDEAEn(pos)                         // No hay otra DEA en esa celda
        })

        // Si hay al menos una posición válida, elige una al azar y se mueve
        if (!posicionesValidas.isEmpty()) {
            position = posicionesValidas.anyOne() //filtra solo las válidas 
            //(que estén dentro del tablero y sin otra DEA), y si hay alguna libre, 
            //se mueve a una de ellas al azar con .anyOne()
        }
    }

    // Método auxiliar que verifica si ya hay otra DEA en una posición dada
    method hayOtraDEAEn(posicion) {
        const objetos = game.getObjectsIn(posicion)             // Trae todos los objetos en esa celda
        return objetos.any({ o => o != self and o.className() == "DEA" })  
        // Devuelve true si hay otra DEA (distinta de esta misma) en la posición
        /*Este método busca si ya hay otra DEA en una posición. 
        Usa game.getObjectsIn(posicion) para ver qué objetos hay ahí. Luego con 
        className() revisa si alguno es una DEA. Y se asegura de que no esté chequeando a 
        sí misma con o != self. Si encuentra otra DEA, no se mueve a esa celda */
    }
}

class Ingrediente inherits Elemento{
// cada ingrediente tiene una posición en el tablero
    override method image() = "ingrediente.png"
}

class Contenedor inherits Elemento{
    override method image() = "laboratory.png"
}
