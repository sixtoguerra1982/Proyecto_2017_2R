ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Últimos cocineros agregados" do
          ul do
            Cook.last(5).map do |cook|
              li link_to(cook.name, admin_cook_path(cook))
            end
          end
        end
      end

      column do
        panel "Usuarios" do
          ul do
            li "Usuarios registrados: #{User.count}"
            li "Administradores registrados: #{AdminUser.count}"
          end
        end
      end
    end
  end # content
end
