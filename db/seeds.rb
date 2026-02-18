Domain::Catalog::Service.delete_all
Domain::Catalog::Product.delete_all

[
  { code: "SVC001", name: "Troca de Óleo", description: "Substituir óleo do motor e filtro", base_price: 120.00 },
  { code: "SVC002", name: "Inspeção de Freios", description: "Verificar pastilhas e discos de freio", base_price: 80.00 },
  { code: "SVC003", name: "Diagnóstico de Motor", description: "Diagnóstico completo do sistema do motor", base_price: 150.00 }
].map { |attrs| Domain::Catalog::Service.create!(attrs) }

[
  { sku: "AP001", name: "Filtro de Óleo", description: "Filtro de óleo de alta qualidade", stock_quantity: 50, base_price: 30.99 },
  { sku: "AP002", name: "Pastilhas de Freio", description: "Jogo de pastilhas de freio dianteiras", stock_quantity: 20, base_price: 92.89 },
  { sku: "AP003", name: "Vela de Ignição", description: "Vela de ignição padrão", stock_quantity: 100, base_price: 15.54 },
  { sku: "AP004", name: "Óleo de Motor 5W30", description: "Garrafa de óleo de motor 5W30", stock_quantity: 250, base_price: 65.89 }
].map { |attrs| Domain::Catalog::Product.create!(attrs) }
