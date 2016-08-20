class StatusCart < EnumerateIt::Base
  associate_values(
    iniciado:   	[1, 'Iniciado'],
    recibido:   	[2, 'Recibido'],
    preparado:  	[3, 'Preparado'],
    enviado:    	[4, 'Enviado'],
    entregado:  	[5, 'Entregado'],
    no_entregado: 	[6, 'No Entregado'],
    rechazado:  	[7, 'Rechazado'],
    cobrado: 		[8, 'Cobrado']
  )

  sort_by :name
end