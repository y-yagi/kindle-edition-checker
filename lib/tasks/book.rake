namespace :book do
  desc "set kindle edition info"

  task set_kindle_edtion_info: :environment do
    Book.set_kindle_edition_info!
  end
end
