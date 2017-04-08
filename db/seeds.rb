# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# if Rails.env.development?

  (100 - Page.count).times do
    Page.create(
      title: Faker::Lorem.words((1..10).to_a.sample).join(' ').titleize,
      description: Faker::Lorem.paragraph,
    )
  end

  # Watch out, sometimes this crashes
  Page.all.each do |page|
    if rand > 0.7
      puts page.id
      page.parent_page_id = Page.where.not(id: page.id).sample.id
      page.save
    end
  end

  if 'Artist'.safe_constantize
    (100 - Artist.count).times do
      Artist.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        bio: Faker::Lorem.paragraph
      )
    end
  end

  if 'Exhibition'.safe_constantize
    (100 - Exhibition.count).times do
      Exhibition.create(
        title: Faker::Lorem.words((1..10).to_a.sample).join(' ').titleize,
        description: Faker::Lorem.paragraph,
        start_date: Faker::Date.forward,
        end_date: Faker::Date.backward,
      )
    end
  end

  if 'Artwork'.safe_constantize
    (100 - Artwork.count).times do
      Artwork.create(
        title: Faker::Lorem.words((1..10).to_a.sample).join(' ').titleize,
        description: Faker::Lorem.paragraph,
        date: Faker::Date.backward,
      )
    end
  end

# end
