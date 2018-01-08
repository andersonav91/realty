namespace :realty do
  desc "Grouping of tasks for the realty project"

  task delete_pdf_files: :environment do
    max_age = 7 # days
    Dir.chdir("#{Rails.root}/public/pdfs/")
    Dir.glob("*.pdf").each { |filename| File.delete(filename) if file_age(filename) > max_age }
  end

  def file_age(name)
    (Time.now - File.ctime(name))/(24*3600)
  end
end
