import empresa.*

class Empleado {
	var property nombre
	var property direccion
	var property estadoCivil
	var property sueldoBasico
	var property fechaDeNacimiento
	
	//Abstractos
	method sueldoBruto()
	method retenciones()	
	method conceptos()
	
	method sueldoNeto() {
		return self.sueldoBruto() - self.retenciones()
	}
	
	method recibo() {
		return new Recibo(
			nombreEmpleado = nombre,
			direccionEmpleado = direccion,
			fechaDeEmision = self.fechaDeHoy(),
			sueldoBruto = self.sueldoBruto(),
			sueldoNeto = self.sueldoNeto(),
			conceptos = self.conceptos()
		)
	}
	
	method edad() {
		return ((self.fechaDeNacimiento() - self.fechaDeHoy()).abs() / 365).truncate(0)
	}
	
	method fechaDeHoy() {
		return new Date()
	}
}

class EmpleadoPlantaPermanente inherits Empleado {
	var cantidadHijos
	var antiguedad
	
	// Públicos
	override method sueldoBruto() {
		return sueldoBasico + self.salarioFamiliar()
	}
	
	override method retenciones() {
		return self.retencionObraSocial() + self.aportesJubilatorios()
	}
	
	// Privados	
	override method conceptos() {
		return 
			"Sueldo Bruto: \n" +
			"	Sueldo básico: \n" + sueldoBasico.toString() +
			"	Sueldo familiar: \n" + 
			"		Asignación por hijo: " + self.asignacionPorHijo().toString() + "\n" +
			"		Asignación por cónyuge: " + self.asignacionPorConyuge().toString() + "\n" +
			"		Asignación por antigüedad: " + self.asignacionAntiguedad().toString() + "\n" +
			"Retenciones: \n" +
			"	Obra social: " + self.retencionObraSocial().toString() + "\n" +
			"	Aportes jubilatorios: " + self.aportesJubilatorios().toString() + "\n"
	}
	
	method salarioFamiliar() {
		return self.asignacionPorHijo() + self.asignacionPorConyuge() + self.asignacionAntiguedad()
	}
	
	method asignacionPorHijo() {
		return 150 * cantidadHijos
	}
	
	method asignacionPorConyuge() {
		return if(estadoCivil == "Casado") 100 else 0
	}
	
	method asignacionAntiguedad() {
		return antiguedad * 50
	}
	
	method retencionObraSocial() {
		return self.sueldoBruto() * 0.1 + 20 * cantidadHijos
	}
	
	method aportesJubilatorios() {
		return self.sueldoBruto() * 0.15
	}
}

class EmpleadoPlantaTemporaria inherits Empleado {
	var fechaFinDesignacion
	var cantidadHorasExtras
	
	// Públicos
	override method sueldoBruto() {
		return sueldoBasico + self.aportesHorasExtras()
	}
	
	override method retenciones() {
		return self.retencionObraSocial() + self.aportesJubilatorios()
	}
		
	// Privados
	override method conceptos() {
		return 
			"Sueldo Bruto: \n" +
			"	Sueldo básico: " + sueldoBasico.toString() + "\n" +
			"	Horas extras: " + self.aportesHorasExtras().toString() + "\n" +
			"Retenciones: \n" +
			"	Obra social: " + self.retencionObraSocial().toString() + "\n" +
			"	Aportes jubilatorios: " + self.aportesJubilatorios().toString() + "\n"
	}
	
	method aportesHorasExtras() {
		return 40 * cantidadHorasExtras
	}

	method retencionObraSocial() {
		return self.sueldoBruto() * 0.1 + self.retencionPorEdad()
	}
	
	method aportesJubilatorios() {
		return self.sueldoBruto() * 0.1 + 5 * cantidadHorasExtras
	}
	
	method retencionPorEdad() {
		return if(self.edad() >= 50) 25 else 0
	}
}

class EmpleadoContratado inherits Empleado {
	var nroContrato
	var medioDePago

	// Públicos
	override method sueldoBruto() {
		return sueldoBasico
	}

	override method retenciones() {
		return self.gastosAdministrativos()
	}

	override method conceptos() {
		return 
			"Sueldo Bruto: \n" +
			"	Sueldo básico: " + sueldoBasico.toString() + "\n" +
			"Retenciones: \n" +
			"	Gastos Administrativos Contractuales: " + self.gastosAdministrativos().toString() + "\n"
	}

	// Privados
	method gastosAdministrativos() {
		return 50
	}
}