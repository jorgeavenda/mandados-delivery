class PackingType < EnumerateIt::Base
  associate_values(
    refrigerado: [1, 'Refrigerado'],
    natural:     [2, 'Natural']
  )

  sort_by :name
end