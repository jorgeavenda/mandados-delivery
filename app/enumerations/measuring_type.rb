class MeasuringType < EnumerateIt::Base
  associate_values(
    unidad: [1, 'Unidad'],
    peso:   [2, 'Peso']
  )

  sort_by :name
end