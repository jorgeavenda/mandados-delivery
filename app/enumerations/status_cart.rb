class StatusCart < EnumerateIt::Base
  associate_values(
    iniciado:   [1, 'Iniciado'],
    recibido:   [2, 'Recibido'],
    preparado:  [3, 'Preparado'],
    enviado:    [4, 'Enviado'],
    entregado:  [5, 'Entregado']
  )

  sort_by :name
end