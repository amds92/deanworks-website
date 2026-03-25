# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "json"

admin_email = ENV.fetch("ADMIN_EMAIL", "admin@deanworks.local")
admin_password = ENV.fetch("ADMIN_PASSWORD", "ChangeMe123!@#")

admin = AdminUser.find_or_initialize_by(email: admin_email)
admin.password = admin_password
admin.password_confirmation = admin_password
admin.save!

legacy_path = Rails.root.join("legacy", "site-data.json")
if File.exist?(legacy_path)
  data = JSON.parse(File.read(legacy_path))

  Array(data["viaturas"]).each do |v|
    external_id = v["id"].presence || [v["marca"], v["modelo"], v["ano"]].compact.join("-").parameterize

    vehicle = Vehicle.find_or_initialize_by(external_id: external_id)
    vehicle.title = v["titulo"]
    vehicle.marca = v["marca"]
    vehicle.modelo = v["modelo"]
    vehicle.ano = v["ano"]
    vehicle.preco = v["preco"]
    vehicle.km = v["km"]
    vehicle.descricao = v["descricao"]
    vehicle.importada = v["importada"]
    vehicle.destaque = v["destaque"]
    vehicle.estado = v["estado"].presence || "available"
    vehicle.published_on = v["data"].presence
    vehicle.save!

    if vehicle.photo.blank? && v["foto"].present?
      image_path = Rails.root.join("legacy", v["foto"].to_s.delete_prefix("/"))
      if File.exist?(image_path)
        vehicle.photo.attach(io: File.open(image_path), filename: File.basename(image_path))
      end
    end
  end

  Array(data["trabalhos"]).each do |t|
    external_id = t["id"].presence || t["titulo"].to_s.parameterize

    work = Work.find_or_initialize_by(external_id: external_id)
    work.titulo = t["titulo"]
    work.tipo = t["tipo"]
    work.pedido_cliente = t["pedido_cliente"]
    work.solucao = t["solucao"]
    work.resultado = t["resultado"]
    work.published_on = t["data"].presence
    work.save!

    if work.photo.blank? && t["foto"].present?
      image_path = Rails.root.join("legacy", t["foto"].to_s.delete_prefix("/"))
      if File.exist?(image_path)
        work.photo.attach(io: File.open(image_path), filename: File.basename(image_path))
      end
    end
  end
end
