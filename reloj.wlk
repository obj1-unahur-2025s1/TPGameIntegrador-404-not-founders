import wollok.game.*       // Funcionalidades del motor del juego (game, ticks, visuales, etc.)
import walter.*            // Para que Walter pueda hablar cuando se acaba el tiempo
import pantalla.*          // Para mostrar la pantalla de Game Over si pierde
import juego.*             // Para acceder al estado del juego
import nivel2.*            // Para invocar el método perder del Nivel 2

// Objeto que representa el reloj del segundo nivel (cuenta regresiva)
object reloj {

    // Número de segundos restantes (se reinicia a 20 cuando se inicia el nivel)
    var property segundos = 20

    // Imagen opcional del reloj (no es obligatoria si no lo mostramos en pantalla)
    method image() = "reloj.png"

    // Comienza la cuenta regresiva
    method iniciar() {
        // Cada 1000 milisegundos (1 segundo), ejecuta el bloque que llama a `restar()`
        game.onTick(1000, "cuentaRegresiva", {
            self.restar()
        })
    }

    // Detiene la cuenta regresiva
    method detener() {
        game.removeTickEvent("cuentaRegresiva")  // Cancela el evento repetitivo llamado "cuentaRegresiva"
    }

    // Reinicia el contador a 20 segundos
    method reiniciar() {
        segundos = 20
    }

    // Resta 1 segundo y evalúa si se terminó el tiempo
    method restar() {
        segundos -= 1    // Baja en uno el contador

        // Walter dice cuántos segundos quedan (solo visible si está en pantalla)
        game.say(walter, "Tiempo restante: " + segundos.toString())

        // Si llegó a 0, se detiene y se llama al método perder del nivel2
        if (segundos == 0) {
            self.detener()                             // Detiene el reloj
            nivel2.perder()      // Llama a perder con mensaje personalizado
        }
    }
}
/* objeto reloj se encarga de contar 20 segundos hacia atrás en el Nivel 2. Usa un game.onTick, 
que ejecuta un bloque cada segundo. Ahí llama al método restar, que baja el contador. 
Si llega a cero, se llama automáticamente al método perder de nivel2, con un mensaje que dice que 
se acabó el tiempo.*/