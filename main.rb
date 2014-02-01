#!/usr/bin/env ruby 
require_relative 'Maquina.rb'
require_relative 'MaquinasCerveza.rb' 
def inicializar()

	@maquinas = []

	@maquinas += [Maquina.new("Silos de Cebada", 400,0)]
	@maquinas[0].extend(SiloDeCebada)

	@maquinas += [Maquina.new("Molino",100,1)]
	@maquinas[1].extend(Molino)

	@maquinas += [Maquina.new("Paila de mezcla",150,2)]
	@maquinas[2].extend(PailaDeMezcla)

	@maquinas += [Maquina.new("Cuba de filtracion", 135, 2)]
	@maquinas[3].extend(CubaDeFiltracion)

	@maquinas += [Maquina.new("Paila de coccion",70,3)]
	@maquinas[4].extend(PailaDeCoccion)

	@maquinas += [Maquina.new("Tanque preclarificador", 35,1)]
	@maquinas[5].extend(TanquePreClarificador)

	@maquinas += [Maquina.new("Enfriador",60,2)]
	@maquinas[6].extend(Enfriador)

	@maquinas += [Maquina.new("TCC", 200,10)]
	@maquinas[7].extend(TCC)

	@maquinas += [Maquina.new("Filtro de cerveza", 100,1)]
	@maquinas[8].extend(FiltroDeCerveza)

	@maquinas += [Maquina.new("Tanques para cerveza filtrada", 100,0)]
	@maquinas[9].extend(TanqueCervezaFiltrada)

	@maquinas += [Maquina.new("Llenadora y tapadora", 50, 2)]
	@maquinas[10].extend(LlenadoraTapadora)




	return @maquinas
end
def algo(p,bd)
	eval "#{p}=0", bd
end
if ARGV.length!=5
	puts "Cantidad de argumentos tiene que ser igual a 5"
	puts "Usted dio #{ARGV.length} argumento(s)"
	puts "El formato utilizado es ./main.rb <numero de ciclos> <cantidad cevada> <cantidad mezcla arroz/maiz> <cantidad de levadura> <cantidad de lupulo>"

else 
	cerveza,ins1,ins2,ins3,ins4 = ciclar(@lista)
	@lista = inicializar()
	
	puts ""
	puts ""
	puts "Cerveza total: #{cerveza}"
	puts "Cebada sobrante: #{ins1}"
	puts "Lupulo sobrante: #{ins4}"
	puts "Levadura sobrante: #{ins3}"
	puts "Mezcla Arroz Maiz sobrante: #{ins2}"
end
