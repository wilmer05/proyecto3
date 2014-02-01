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
# Ana Arteaga (09-11059)
# Luis Fernandes (10-10239)


# == Nombre
#
# MaquinasCerveza
#
# == Descripción
#
# Module que contiene los mixins para cada tipo de maquina que se encuentra
# en una destiladora de cerveza

require_relative 'Contenedor.rb'
require_relative 'CicloDeTrabajo.rb'

def imprimir(obj)
		
		puts "Maquina #{obj.nombre}"
		puts "Estado: #{obj.estado}"
		if(obj.estado=="llena" or obj.estado=="inactiva")
			cant = obj.cantidad
			nom = obj.nombreContenido
			nom.zip(cant).each do |name, cant|
				puts "#{name}: #{cant}"
			end
		end
	end


module SiloDeCebada

	
	#Imprime informacion relacionada con la maquina
	@cont = new Contenedor(['Cebada'],[0])
	# Produce cebada
	#
	# ==== Atributos
	#
	# * +cantidadCebada+ - La cantidad de cebada. Se obtiene del main, y debe
	# ser una variable del Main que se va modificando
	#
	def ciclo(cantidadCebada,cambioEstado)
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
		val = 0 
		if (@estado == "en espera" and cambioEstado==1)
			if @cont.cantidad[0] > 100
				@cont = new Contenedor(['Cebada'],[@cont.cantidad[0]-100])
			else
				if(cantidadCebada>=400)
					@estado="llena"
				else
					@estado = "inactiva"
				end
				val = (cantidadCebada<400?cantidadCebada:400)

				@cont = new Contenedor(['Cebada'],[val])
			end
		else if(@estado=="llena")
			@estado="en espera"
		else if(@estado=="inactiva" and @cont.cantidad[0]+cantidadCebada>=400)
			@estado="llena"
			@cont = new Contenedor(['Cebada'],[400])
			val = (cantidadCebada<400?0:cantidadCebada-400)
		end
		return val
	end

end



module TanqueCervezaFiltrada
	# Filtra la Cerveza
	#
	# ==== Atributos
	#
	# * +cantidadPA+ - La cantidad del producto de la maquina anterior.
	# Se obtiene del main, y debe ser una variable del Main que se va modificando
	#
	@cont = Contenedor.new(['Cerveza Filtrada'],[0])

	def ciclo(cantidadPA,cambioEstado)
		# Basicamente es el mismo procedimiento del ciclo anterior
		# ya que es una maquina de 0 ciclos.
	  
		val = 0 
		if (@estado == "en espera" and cambioEstado==1)
			if @cont.cantidad[0] > 50
				@cont = new Contenedor(['Cerveza Filtrada'],[@cont.cantidad[0]-50])
			else
				if(cantidadPA>=100)
					@estado="llena"
				else
					@estado = "inactiva"
				end
				val = (cantidadPA<100?cantidadPA:100)

				@cont = new Contenedor(['Cerveza Filtrada'],[val])
			end
		else if(@estado=="llena")
			@estado="en espera"
		else if(@estado=="inactiva" and @cont.cantidad[0]+cantidadPA>=100)
			@estado="llena"
			@cont = new Contenedor(@cont.nombreContenido,[100])
			val = (cantidadPA<100?0:cantidadPA-100)
		end
		return val

	end
end



module Molino
	# Molino
	#
	# ==== Atributos
	#
	# * +cantidadPA+ - La cantidad del producto de la maquina anterior.
	# Se obtiene del main, y debe ser una variable del Main que se va modificando
	#
	@cont = Contenedor.new(['Molino'],[0])
	def ciclomolino(cantidadPA)
		# la maquina molino tiene un ciclo, por lo que se tiene que modificar el
		# status a llena una vez llegue a su cantidad Maxima de insumos.
	  
		ciclo = CicloDeTrabajo.new
		desecho = ((@cantidadMaxima * 2) / 100)  #2%

		if cantidadPA >= @cantidadMaxima
			cantidadPA = cantidadPA - @cantidadMaxima
			@estado = "Llena"
			ciclo.AumentarDeCiclo
			
			return new Contenedor('Molino',@cantidadMaxima)
		else
			cont = new Contenedor('Molino',cantidadPA)
			cantidadPA = 0
			return cont
		end
	end
end


module TanquePreClarificador
	# Tanque Clarificador
	#
	# ==== Atributos
	#
	# * +cantidadPA+ - La cantidad del producto de la maquina anterior.
	# Se obtiene del main, y debe ser una variable del Main que se va modificando
	#
	def cicloTanquePC(cantidadPA)
		# la maquina TanquePreClarificador tiene un ciclo, por lo que se tiene que modificar el
		# status a llena una vez llegue a su cantidad Maxima de insumos.

		ciclo = CicloDeTrabajo.new
		desecho = ((@cantidadMaxima) / 100) # 1%
		
		if cantidadPA >= @cantidadMaxima
			cantidadPA = cantidadPA - @cantidadMaxima
			@estado = "Llena"
			ciclo.AumentarDeCiclo
			return new Contenedor('Tanque Pre-Clarificador',@cantidadMaxima)
		else
			cont = new Contenedor('Tanque Pre-Clarificador',cantidadPA)
			cantidadPA = 0
			return cont
		end
	end
end


module FiltroDeCerveza
	# Filtra la Cerveza
	#
	# ==== Atributos
	#
	# * +cantidadPA+ - La cantidad del producto de la maquina anterior.
	# Se obtiene del main, y debe ser una variable del Main que se va modificando
	#
	def cicloFiltroCerveza(cantidadPA)
		# la maquina FiltroDeCerveza tiene un ciclo, por lo que se tiene que modificar el
		# status a llena una vez llegue a su cantidad Maxima de insumos.

		ciclo = CicloDeTrabajo.new

		if cantidadPA >= @cantidadMaxima
			cantidadPA = cantidadPA - @cantidadMaxima
			@estado = "Llena"
			ciclo.AumentarDeCiclo
			return new Contenedor('Cerveza Filtrada',@cantidadMaxima)
		else
			cont = new Contenedor('Cerveza Filtrada',cantidadPA)
			cantidadPA = 0
			return cont
		end
	end
end




module LlenadoraTapadora
	# Maquina Llenadora y Tapadera
	#
	# ==== Atributos
	#
	# * +cantidadPA+ - La cantidad del producto de la maquina anterior.
	# Se obtiene del main, y debe ser una variable del Main que se va modificando
	#

	ciclo = CicloDeTrabajo.new
	cantidadProducto = 0

  
	def cicloLlenadoraTapadora(cantidadPA)
		# la maquina LlenadoraTapadora tiene dos ciclos, por lo que se tiene que modificar el
		# status a llena una vez llegue a su cantidad Maxima de insumos, y luego a procesando
		# Una vez este realizando el producto.
		# NOTA: Se que tienen ya planeado el sistema, el se encarga de llamar a las Maquinas y eso,
		# no se como pensaron lo de los ciclos, pero aqui dejo un bosquejo.
		
		if @estado == "Inactiva"
			if cantidadPA >= @cantidadMaxima
				cantidadPA = cantidadPA - @cantidadMaxima
				cantidadProducto = @cantidadMaxima
				@estado = "Llena"
				ciclo.AumentarDeCiclo
			else
				cantidadProducto = cantidadPA
			end
			
		elsif @estado == "Llena"
			@estado = "Procesando"
			ciclo.AumentarDeCiclo
			#No se le resta el desperdicio porque en el caso de esta maquina es 0.
			return new Contenedor('Cerveza LLena y Tapada', cantidadProducto)

		end	
			
	end
end



module Enfriador
	# Maquina Enfriadora
	#
	# ==== Atributos
	#
	# * +cantidadPA+ - La cantidad del producto de la maquina anterior.
	# Se obtiene del main, y debe ser una variable del Main que se va modificando
	#

	ciclo = CicloDeTrabajo.new
	cantidadProducto = 0

  
	def cicloEnfriadora(cantidadPA)
		# la maquina Enfriadora tiene dos ciclos, por lo que se tiene que modificar el
		# status a llena una vez llegue a su cantidad Maxima de insumos, y luego a procesando
		# Una vez este realizando el producto.
		
		if @estado == "Inactiva"
			if cantidadPA >= @cantidadMaxima
				cantidadPA = cantidadPA - @cantidadMaxima
				cantidadProducto = @cantidadMaxima
				@estado = "Llena"
				ciclo.AumentarDeCiclo
			else
				cantidadProducto = cantidadPA
			end
			
		elsif @estado == "Llena"
			@estado = "Procesando"
			ciclo.AumentarDeCiclo
			return new Contenedor('Enfriadora', cantidadProducto)

		end	
			
	end
end


module CubaDeFiltracion
	# Cuba de Filtracion
	#
	# ==== Atributos
	#
	# * +cantidadPA+ - La cantidad del producto de la maquina anterior.
	# Se obtiene del main, y debe ser una variable del Main que se va modificando
	#

	ciclo = CicloDeTrabajo.new
	cantidadProducto = 0

  
	def cicloCubaDeFiltracion(cantidadPA)
		# la maquina CubaDeFiltracion tiene dos ciclos, por lo que se tiene que modificar el
		# status a llena una vez llegue a su cantidad Maxima de insumos, y luego a procesando
		# Una vez este realizando el producto.
		
		if @estado == "Inactiva"
			if cantidadPA >= @cantidadMaxima
				cantidadPA = cantidadPA - @cantidadMaxima
				cantidadProducto = @cantidadMaxima
				@estado = "Llena"
				ciclo.AumentarDeCiclo
			else
				cantidadProducto = cantidadPA
			end
			
		elsif @estado == "Llena"
			@estado = "Procesando"
			ciclo.AumentarDeCiclo
			desecho = ((@cantidadMaxima * 35) / 100)  #35%
			cantidadProducto = @cantidadMaxima * (1- desecho)
			return new Contenedor('Filtracion', cantidadProducto)

		end	
			
	end
end

module PailaDeMezcla
	# Paila de Mezcla
	#
	# ==== Atributos
	#
	# * +cantidadPA+ - La cantidad del producto de la maquina anterior.
	# Se obtiene del main, y debe ser una variable del Main que se va modificando
	#

	ciclo = CicloDeTrabajo.new
	cantidadProducto = 0

  
	def cicloCubaDeFiltracion(cantidadeArrozMaiz , cantidadPA)
		# la maquina PailaDeMezcla tiene dos ciclos, por lo que se tiene que modificar el
		# status a llena una vez llegue a su cantidad Maxima de insumos, y luego a procesando
		# Una vez este realizando el producto.		
		if @estado == "Inactiva"
			if ((cantidadeArrozMaiz + cantidadPA) >= @cantidadMaxima)
			     cuarentaPorc = ((@cantidadMaxima * 40) / 100)
			     sesentaPorc = ((@cantidadMaxima * 50) / 100)
			    
			     if((cantidadeArrozMaiz>=cuarentaPorc)&&(cantidadPA>=sesentaPorc))
					cantidadeArrozMaiz = cantidadeArrozMaiz - cuarentaPorc
					cantidadPA = cantidadPA - sesentaPorc
				       
					cantidadProducto = @cantidadMaxima
					@estado = "Llena"
					ciclo.AumentarDeCiclo
				end
			else
				cantidadProducto = cantidadeArrozMaiz+cantidadPA
			end
		
		elsif @estado == "Llena"
			@estado = "Procesando"
			ciclo.AumentarDeCiclo
			return new Contenedor('Paila de Mezcla', cantidadProducto)
		end	
	end
end


module TCC

end
