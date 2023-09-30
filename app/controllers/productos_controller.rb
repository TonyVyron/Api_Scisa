class ProductosController < ApplicationController
  before_action :set_producto, only: [:show, :update, :destroy]

  def index
    @productos = Producto.all
    productos_data = @productos.map do |producto|
      {
        id: producto.id,
        nombre: producto.nombre,
        descripcion: producto.descripcion,
        categoria: {
          id: producto.categoria.id,
          nombre: producto.categoria.nombre
        }
      }
    end
    render json: { status: "EXITOSO", message: "Productos cargados", productos: productos_data }, status: :ok
  end
  

  def show
    render json: { status: "EXITOSO", message: "Producto cargado", producto: {
        id: @producto.id,
        nombre: @producto.nombre,
        descripcion: @producto.descripcion,
        categoria: {
          id: @producto.categoria.id,
          nombre: @producto.categoria.nombre
        }
      }
    }, status: :ok
  end  

  def create
    @producto = Producto.new(producto_params)
    if @producto.save
      render json: { message: "Producto creado exitosamente", producto: @producto }, status: :created
    else
      render json: { error: "No se pudo crear el producto" }, status: :unprocessable_entity
    end
  end
  

  def update
    if @producto.update(producto_params)
      render json: { message: "Producto actualizado correctamente", producto: @producto }
    else
      render json: { error: "No se pudo actualizar el producto" }, status: :unprocessable_entity
    end
  end
  

  def destroy
    if @producto.destroy
      render json: { message: "Producto eliminado correctamente" }, status: :no_content
    else
      render json: { error: "No se pudo eliminar el producto" }, status: :unprocessable_entity
    end
  end

  private

  def set_producto
    @producto = Producto.find(params[:id])
  end

  def producto_params
    params.require(:producto).permit(:nombre, :descripcion, :categoria_id)
  end
end
