class CategoriasController < ApplicationController
  before_action :set_categoria, only: [:show, :update, :destroy]

  def index
    @categorias = Categoria.all
    categorias_data = @categorias.map { |categoria| { id: categoria.id, nombre: categoria.nombre,descripcion: categoria.descripcion  } }
    render json: { status: "EXITOSO", message: "Categorias cargadas", categorias: categorias_data }, status: :ok
  end
  
  

  def show
    render json: { status: "EXITOSO", message: "Categoria cargada", categoria: @categoria.slice(:id, :nombre, :descripcion) }, status: :ok
  end
  

  def create
    @categoria = Categoria.new(categoria_params)
    if @categoria.save
      render json: { message: "Categoria creada exitosamente", categoria: @categoria }, status: :created
    else
      render json: { error: "No se pudo crear la categoría" }, status: :unprocessable_entity
    end
  end
  

  def update
    if @categoria.update(categoria_params)
      render json: { message: "Categoria actualizada correctamente", categoria: @categoria }
    else
      render json: { error: "No se pudo actualizar la categoria" }, status: :unprocessable_entity
    end
  end
  
  def destroy
    if @categoria.productos.empty?
      @categoria.destroy
      render json: { message: "Categoria eliminada correctamente" }, status: :no_content
    else
      render json: { error: "No se puede eliminar una categoria con productos asignados..." }, status: :unprocessable_entity
    end
  end
  

  private

  def set_categoria
    @categoria = Categoria.find(params[:id])
  end

  def categoria_params
    params.require(:categoria).permit(:nombre, :descripcion)
  end
end
