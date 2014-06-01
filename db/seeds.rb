Customer.delete_all
Invoice.delete_all
InvoiceItem.delete_all

customer = Customer.create(name: "Renan Sena", phone: "(91) 8308-8352", email: "nan-sena@hotmail.com")

invoice = Invoice.create(due_date: Date.current + 9, issue_date: Time.now, customer: customer)

items = [
          { quantity: 3, description: "CREDIARIO AUTOMATICO PA", unitary_cost: 388.42 },
          { quantity: 6, description: "VERMELHO MATERIAIS04/06", unitary_cost: 479.94 },
          { quantity: 4, description: "YAMADA PONTO Y 03/04",    unitary_cost: 20.00  },
          { quantity: 4, description: "PENA IRMAO 03/04",        unitary_cost: 100.29 },
          { quantity: 6, description: "PONTO Y 03/06",           unitary_cost: 116.50 },
          { quantity: 5, description: "PENA IRMAO 02/05",        unitary_cost: 68.72  },
          { quantity: 4, description: "LOJAS VISAO 02/04",       unitary_cost: 37.25  },
          { quantity: 6, description: "CIA DO TERNO 02/06",      unitary_cost: 81.85  },
          { quantity: 3, description: "KATTLEYA 02/03",          unitary_cost: 98.00  },
          { quantity: 3, description: "CADERNO E COMPANHI02/03", unitary_cost: 44.29  }
        ]

items.each do |item|
  InvoiceItem.create({
                        quantity:     item[:quantity],
                        description:  item[:description],
                        unitary_cost: item[:unitary_cost],
                        invoice:      invoice
                    })
end
