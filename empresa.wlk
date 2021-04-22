import empleados.*

class Empresa {
	var property nombre
	var property cuit
	var montoTotalSueldosNetos
	
	const property empleados
	const property recibosHaberes = []
	
	// Públicos
	method montoSueldosNetos() {
		return empleados.sum({ empleado => empleado.sueldoNeto() })
	}
	
	method montoSueldosBrutos() {
		return empleados.sum({ empleado => empleado.sueldoBruto() })
	}
	
	method montoRetenciones() {
		return empleados.sum({ empleado => empleado.retenciones() })
	}
	
	method liquidarSueldos() {
		empleados.forEach({ empleado => self.agregarRecibo(empleado) })
	}

	method calculoDeSueldosNetos() {
		montoTotalSueldosNetos = self.montoSueldosNetos()
	}
	
	// Privados
	method agregarRecibo(empleado) {
		recibosHaberes.add(empleado.recibo())
	}
}

class Recibo {
	const property nombreEmpleado
	const property direccionEmpleado
	const property fechaDeEmision
	const property sueldoBruto
	const property sueldoNeto
	const property conceptos
}











