# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# -------------------------------------------------------------------------------

require 'csv'

# check if files exist 
def check_file_existence(files)
	files.each do |file|
		path = Rails.root.join('db','data',file)

		File.file?(path) || raise('File %s does not exist. Did you misspell the file name?' % file)
	end 
end 


def csv_to_poems(path,language)
	# headers are 'author','line1','line2','line3','line4','line5'
	# check out schema.rb for schemas					
	CSV.foreach(path, headers:true).with_index(1) do |row,index|
		poem = Poem.find_by(numeral: index)
		
		poem.author[language] = row['author']
		poem[language] = [row['line1'],row['line2'],row['line3'],row['line4'],row['line5']]

		poem.save || raise('Failed to save document')
		
		puts poem.author[language] 
	end  
end 


# create_poems takes csv filenames and saves authors and poem lines in their appropriate Author and Poem models 
def create_poems(*filenames)
	check_file_existence(filenames) 

	# hyakunin isshu consists of 100 poems by 100 poets
	100.times.each do |number|
		author = Author.create 
		poem = Poem.create(numeral: number + 1, author: author)
	end 

	# do this for each csv file 
	filenames.each do |filename|
		path = Rails.root.join('db','data',filename)
		lang = filename.split(/.csv/)[0]

		csv_to_poems(path,lang) 
	end 
end 


create_poems('rom.csv', 'jap.csv', 'eng.csv')