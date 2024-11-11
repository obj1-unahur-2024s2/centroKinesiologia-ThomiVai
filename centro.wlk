import paciente.*

class Rutina{
    const property aparatosAsignados = []
    method asignarRutinaAlPaciente(rutina){
        aparatosAsignados.addAll(rutina)
    }
}

class Centro{
    const property aparatos = []
    const property pacientes = #{}
    method coloresDeAparatos() = aparatos.map({a => a.color()}).asSet()
    method pacientesMenores() = pacientes.filter({p => p.edad() < 5})
    method cantidadDePacientes(rutinaAsignada) = pacientes.filter({p => p.puedeHacerRutinaAsignada(rutinaAsignada)})
    method estaEnOptimasCondiciones() = aparatos.all({a => !a.necesitaMantenimiento()})
    method estaComplicado(){
        const aparatosTotal = aparatos.size()
        return aparatos.count({a => a.necesitaMantenimiento()}) >= aparatosTotal / 2
} 
    method visitaDeTecnico(){
        aparatos.forEach({a => a.hacerMantenimiento()})
    }
}

