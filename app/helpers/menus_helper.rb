module MenusHelper
  def state_menus menu
    if menu.stock < 1
      if menu.editable == true
        states_menus = 'red'
      else
        state_menus = '#ffc107'
      end
    else
        state_menus = 'white'
    end
  end
  # RED SIN STOCK
  # YELLOW FECHA ANTIGUA DE PUBLICACION
  # WHITE FECHA Y STOCK OK
end
