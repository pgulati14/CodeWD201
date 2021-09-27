require 'active_record'

def connect_db!
  ActiveRecord::Base.establish_connection(
    host: 'localhost',
    adapter: 'postgresql',
    database: 'kabir_db',
    user: 'postgres',
    password: 'kabir@132'
  )
end
