#!/usr/bin/env ruby


# == Nombre
#
# Máquina
#
# == Descripción
#
# Clase que representa una maquina en la línea de produccion
#
# == Autores
# Wilmer Bandres (10-10055)
# Gustavo El Khoury (10-10226)
# Ana Arteaga ()
# Luis Fernandes ()

class Maquina
  # Identificador de la maquina
  attr_accessor :nombre

  # Describe el estado actual de la maquina
  attr_reader :estado

  # Cantidad Maxima de producto
  attr_reader :cantidadMaxima

  # Desecho que emite la maquina
  attr_reader :desecho


  # Construye una instancia de la maquina
  #
  # ==== Atributos
  #
  # * +nombre+ - El nombre que tendra la maquina
  # * +cantidadMaxima+ - Cantidad maxima de producto que emite
  # * +Desecho+ - El porcentaje (eg 0.1) que la máquina desecha
  #
  def initialize(nombre,cantidadMaxima,desecho)
    @nombre = nombre
    @cantidadMaxima= cantidadMaxima
    @desecho = desecho
    @estado = "Inactiva"
  end

end