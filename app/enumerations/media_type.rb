class MediaType < EnumerateIt::Base
  associate_values(
    banner: [1, 'Banner']
  )

  sort_by :name
end