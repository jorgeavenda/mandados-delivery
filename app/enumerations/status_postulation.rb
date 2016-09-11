class StatusPostulation < EnumerateIt::Base
  associate_values(
  	pendiente: [1, 'Pendiente'],
    aceptado:  [2, 'Aceptado'],
    rechazado: [3, 'Rechazado']
  )

  sort_by :name
end