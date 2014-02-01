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


def ciclar(listaMaq,res)
	ciclos = res[0].to_i
	lista = [res[1].to_i]+[res[2].to_i]+[res[3].to_i]+[res[4].to_i]
	cerveza = 0
	tmp =1
	entra = [0,0,0,0,0,0,0,0,0,0,0]	
	while tmp<=ciclos do
		maquinas =0
		while maquinas<=10 do

			if(maquinas==0)
				cont,lista[1]=listaMaq[0].producirCebada(lista[1])
				if listaMaq[0].estado == "Espera"
					entra[1]=100
				end
		
			else if maquinas==1
				

			end



			
			maquinas-=1

		end


		tmp+=1
	end

	puts ciclos

	return [cerveza,lista[0],lista[1],lista[2],lista[3]]
end

if ARGV.length!=5
	puts "Cantidad de argumentos tiene que ser igual a 5"
	puts "Usted dio #{ARGV.length} argumento(s)"
	puts "El formato utilizado es ./main.rb <numero de ciclos> <cantidad cevada> <cantidad mezcla arroz/maiz> <cantidad de levadura> <cantidad de lupulo>"

else 
	@lista = inicializar()
	lista2=[]

	cerveza,ins1,ins2,ins3,ins4 = ciclar(@lista,ARGV)
	
	puts ""
	puts ""
	puts "Cerveza total: #{cerveza}"
	puts "Cebada sobrante: #{ins1}"
	puts "Lupulo sobrante: #{ins4}"
	puts "Levadura sobrante: #{ins3}"
	puts "Mezcla Arroz Maiz sobrante: #{ins2}"
end
