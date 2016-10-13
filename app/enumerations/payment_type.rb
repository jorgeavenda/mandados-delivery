class PaymentType < EnumerateIt::Base
  associate_values(
  	efectivo: [1, 'Efectivo'],
    transferencia:  [2, 'Transferencia'],
    debito: [3, 'Debito'],
    credito: [4, 'Credito'],
    alimentacion: [5, 'Alimentacion']
  )

  sort_by :name
end