class Paciente{
    var edad
    var fortalezaMuscular
    var nivelDeDolor
    method edad() = edad
    method fortalezaMuscular() = fortalezaMuscular
    method nivelDeDolor() = nivelDeDolor
    method cambiarFortalezaMuscular(unValor){
        fortalezaMuscular = unValor
    }
    method cambiarNivelDeDolor(unValor){
        nivelDeDolor = unValor
    }
    method puedeUsarElAparato(unAparato) = unAparato.puedeSerUsado(self)
    
    method usarAparato(unAparato){
        if(self.puedeUsarElAparato(unAparato)){
            unAparato.obtenerResultados(self)
        }
    }
    method puedeHacerRutinaAsignada(unaRutina) = unaRutina.aparatosAsignados().all({a => a.puedeSerUsado(self)})
    method hacerRutinaAsignada(unaRutina){
        if(self.puedeHacerRutinaAsignada(unaRutina))
         unaRutina.aparatosAsignados().forEach({a => a.obtenerResultados(self)})
    }
}

class Aparato{
    var property color 
    method puedeSerUsado(unPaciente)
    method obtenerResultados(unPaciente)
    method necesitaMantenimiento()
    method hacerMantenimiento()

}

class Magneto inherits Aparato{
    var puntosDeInmantacion = 800
    method puntosDeInmantacion() = puntosDeInmantacion
    override method puedeSerUsado(unPaciente) = true
    method consecuenciasDelUso(){
        puntosDeInmantacion -= 1
    }
    override method obtenerResultados(unPaciente){
        const dolor = unPaciente.nivelDeDolor() * 0.1
        unPaciente.cambiarNivelDeDolor(unPaciente.nivelDeDolor() - dolor)
        self.consecuenciasDelUso()
    }
    override method necesitaMantenimiento() = puntosDeInmantacion < 100
    override method hacerMantenimiento(){
        if(self.necesitaMantenimiento()){
            puntosDeInmantacion += 500
        }
    }
}

class Bicicleta inherits Aparato{
    var vecesQueSeDesajustanTornillos = 0
    var vecesQuePierdeAceite = 0
    override method puedeSerUsado(unPaciente) = unPaciente.edad() > 8
    method consecuenciasDelUso(unPaciente){
        self.consecuenciasDelUsoAceite(unPaciente)
        self.consecuenciasDelUsoTornillos(unPaciente)
    }
    method consecuenciasDelUsoTornillos(unPaciente){
         if(unPaciente.edad() > 30){
            vecesQueSeDesajustanTornillos += 1
        }
    }
    method consecuenciasDelUsoAceite(unPaciente){
        if(unPaciente.edad().between(30, 50)){
            vecesQuePierdeAceite += 1
        }
    }
    override method obtenerResultados(unPaciente){
        const nuevoDolor = unPaciente.nivelDeDolor() - 4
        const nuevaFortalezaMuscular = unPaciente.fortalezaMuscular() + 3
        unPaciente.cambiarFortalezaMuscular(nuevaFortalezaMuscular)
        unPaciente.cambiarNivelDeDolor(nuevoDolor)
        self.consecuenciasDelUso(unPaciente)
    }
    override method necesitaMantenimiento() = vecesQueSeDesajustanTornillos >= 10 || vecesQuePierdeAceite >= 5
    override method hacerMantenimiento(){
        if(self.necesitaMantenimiento())
        vecesQuePierdeAceite = 0
        vecesQueSeDesajustanTornillos = 0

    }



    


}

class Minitramp inherits Aparato{
     override method puedeSerUsado(unPaciente) = unPaciente.nivelDeDolor() < 20
     override method obtenerResultados(unPaciente){
        const nuevoFortalezaMuscular = unPaciente.fortalezaMuscular() * 0.1
        unPaciente.cambiarFortalezaMuscular(unPaciente.fortalezaMuscular() + nuevoFortalezaMuscular)
     }
     override method necesitaMantenimiento() = false

}

class Resistente inherits Paciente{
    override method hacerRutinaAsignada(unaRutina){
        super(unaRutina)
        fortalezaMuscular += unaRutina.aparatosAsignados().size()

    }
}

class Caprichoso inherits Paciente{
    override method puedeHacerRutinaAsignada(unaRutina){
        return super(unaRutina) and unaRutina.aparatosAsignados().any({a => a.color() == "rojo"})
    }
    override method hacerRutinaAsignada(unaRutina){
         super(unaRutina)
         unaRutina.aparatosAsignados().forEach({a => a.obtenerResultados(self)})
    }
}

class RapidaRecuperacion inherits Paciente{
    override method hacerRutinaAsignada(unaRutina){
        super(unaRutina)
        self.cambiarNivelDeDolor(self.nivelDeDolor() - 2)
    }

}