require 'pry'

class Pokemon
    attr_reader :db
    attr_accessor :name, :type, :id

    def initialize(pokemon={})
        @name = pokemon[:name]
        @type = pokemon[:type]
        @id = pokemon[:id]
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * from pokemon
            WHERE id = ?
        SQL

        db.execute(sql, id).map {|row| self.new(name: row[1], type: row[2], id: row[0])}.first
    end
end
