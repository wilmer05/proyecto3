# == Nombre
#
# MaquinasCerveza
#
# == Descripción
#
# Module que contiene los mixins para cada tipo de maquina que se encuentra
# en una destiladora de cerveza
#
# == Autores
# Wilmer Bandres (10-10055)
# Gustavo El Khoury (10-10226)
# Ana Arteaga ()
# Luis Fernandes ()


# == Nombre
#
# MaquinasCerveza
#
# == Descripción
#
# Module que contiene los mixins para cada tipo de maquina que se encuentra
# en una destiladora de cerveza

require_relative 'Contenedor.rb'

module SiloDeCebada

	# Produce cebada
	#
	# ==== Atributos
	#
	# * +cantidadCebada+ - La cantidad de cebada. Se obtiene del main, y debe
	# ser una variable del Main que se va modificando
	#
	def producirCebada(cantidadCebada)
		# Este metodo es dummy. Como la cantidad de ciclos de trabajo de esta
		# maquina es 0, la maquina consume la entrada y emite la salida inme
		# diatamente. En teoria, si una maquina tiene ciclos de trabajo positivos
		# tiene que esperar esa cantidad de ciclos antes de pasar de un estado a
		# otro (eg el molino empieza con inactivo, si le pasan el insumo pasa a
		# el estado 'Llena' y termina el ciclo, guardando en una variable de la
		# clase cuanto tiene guardado, y en otra variable debe guardar que ha finalizado
		# 1 ciclo, y retrna un contenedor con contenido 0. En el siguiente 
		# ciclo, se da cuenta que ya
		# esta llena y ha recorrido un ciclo, asi que ahi SI retorna un contenedor
		# con su producto.)
		if cantidadCebada >= @cantidadMaxima
			cantidadCebada = cantidadCebada - @cantidadMaxima
			return new Contenedor('Cebada',@cantidadMaxima)
		else
			cont = new Cebada('Contenedor',cantidadCebada)
			cantidadCebada = 0
			return cont
		end
	end

	# Para agregar mixins a una maquina se hace
	# n = new Maquina('Pikachu',400,0.1)
	# n.extend(SiloDeCebada)
end