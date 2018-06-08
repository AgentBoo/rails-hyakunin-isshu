# Rails hyakunin isshu 

0. useful to know: 
bundler install && yarn install(after cloning)
bundle update && yarn upgrade 

rails server 
rails db:create 
rails db:rollback STEP=NUM
rails db:migrate:down VERSION=NUM 
rails generate model (opens a manual)
rails generate controller ... 
rails destroy controller ...  

* rollback db with many steps => destroy migrations => destroy model 


1. cli 
rails new hyakuninisshu --webpack=react -d postgresql
cd hyakuninisshu 
bundle install 


2. cli
rails generate scaffold  
mkdir /db/data 

- add csv files into data folder 


3. cli 
rails generate model Author jap:string rom:string eng:string

3.5. db/migrate/migration for create_authors 
- alter migration file 

```ruby 
class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :jap, default: 'Unknown'
      t.string :rom, default: 'Unknown'
      t.string :eng, default: 'Unknown'

      t.timestamps
    end
  end
end
```



4. cli 
rails generate model Poem numeral:integer jap:string rom:string eng:string author:references

http://blog.plataformatec.com.br/2014/07/rails-4-and-postgresql-arrays/
https://stackoverflow.com/questions/32409820/add-an-array-column-in-rails

4.5. db/migrate/migration for create_poems 
- alter migration file 

```ruby 
class CreatePoems < ActiveRecord::Migration[5.2]
  def change
    create_table :poems do |t|
      t.integer :numeral
      t.string :jap, array: true, default: []
      t.string :rom, array: true, default: []
      t.string :eng, array: true, default: []
      t.references :author, foreign_key: true

      t.timestamps
    end

    add_index :poems, :numeral, unique: true 
  end
end

``` 


5. cli 
rails db:migrate 


6. app/models/author.rb
- poem.rb already has a belongs_to association declared by rails generate model  
- add autosave: true to both author.rb and poem.rb otherwise association members will not save updates or destroys 

```ruby 
class Author < ApplicationRecord
	has_one :poem, autosave: true, dependent: :delete  
end
```


7. db/seeds.rb 
- use CSV.foreach() block 
- use rubocop ruby style guide
- Enumerator.with_index 

http://api.rubyonrails.org/classes/Rails.html#method-c-root
https://github.com/rubocop-hq/ruby-style-guide#ternary-operator
https://ruby-doc.org/core-2.2.0/Enumerator.html
https://dalibornasevic.com/posts/68-processing-large-csv-files-with-ruby





