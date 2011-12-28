# Script per convertire il database di Aurox dalla versione 0.5 alla x
# Ricordarsi di:
# - creare i files di invio dati;
# - compilare il registro;
# - stampare il registro.


require 'rubygems'
require 'active_record'

#ActiveRecord::Base.logger = Logger.new(STDOUT) #Butta in console il codice sql delle varie operazioni e query
ActiveRecord::Base.establish_connection(
        :adapter => "mysql",
        :host => "localhost",
        :username => "root",
        :password => "new-password",
        :database => "aurox1_0"
)

class Relazs < ActiveRecord::Base
        has_many :animal
        belongs_to :user, :class_name => "Users"
        belongs_to :stalle, :class_name => "Stalles"
        belongs_to :ragsoc, :class_name => "Ragsocs"
        belongs_to :prop, :class_name => "Props"
        belongs_to :contatori, :class_name => "Contatoris"
end

class Stalles < ActiveRecord::Base
        has_many :relaz
end

class Ragsocs < ActiveRecord::Base
        has_many :relaz
end

class Props < ActiveRecord::Base
        has_many :relaz
end

class Razzas < ActiveRecord::Base
        has_many :animal
end

class Animals < ActiveRecord::Base
        belongs_to :relaz, :class_name => "Relazs"
        belongs_to :razza, :class_name => "Razzas"
        belongs_to :allevingr, :class_name => "Allevingrs"
        belongs_to :allevusc, :class_name => "Allevuscs"
        belongs_to :macelli, :class_name => "Macellis"
        belongs_to :nazorig, :class_name => "Nazorigs"
        belongs_to :nazprov, :class_name => "Nazprovs"
        belongs_to :naznasprimimp, :class_name => "Naznasprimimps"
        belongs_to :nazdest, :class_name => "Nazdests"
#        belongs_to :nation, :as => :Nazorig
#        belongs_to :nation, :as => :Nazprov
#        belongs_to :nation, :as => :Naznasprimimp
#        belongs_to :nation, :as => :Nazdest
end

class Uscites < ActiveRecord::Base
        has_many :animal
end

class Ingressos < ActiveRecord::Base
        has_many :animal
end

#class Nations < ActiveRecord::Base
#        has_many :animal
#end

class Nations < ActiveRecord::Base
#        has_many :animal
        has_many :nations
end

class Nazorigs < Nations

end

class Nazprovs < Nations

end

class Naznasprimimps < Nations

end

class Nazdests < Nations

end

class Allevamentis < ActiveRecord::Base
#        has_many :animal
end

class Allevingrs < Allevamentis
        has_many :animal
end
class Allevuscs < Allevamentis
        has_many :animal
end

class Macellis < ActiveRecord::Base
        has_many :animal
        belongs_to :region, :class_name => "Regions"
end

class Trasportatoris < ActiveRecord::Base
        has_many :animal
end

class Luncampis < ActiveRecord::Base
end    

class Contatoris < ActiveRecord::Base
        has_many :relazs
end

class Registros < ActiveRecord::Base
        has_many :relazs
end

class Regions < ActiveRecord::Base
        has_many :macelli
end

class Vanimals < ActiveRecord::Base

end

# Inizio trasferimento movimenti di ingresso


uscite = Vanimals.find(:all, :conditions => ["tipo = ?", "U"])


uscite.each do |u|
	if u.idcoll == nil
		mov = Vanimals.find(:all, :conditions => ["relaz_id = ? and tipo = ? and marca = ?", "#{u.relaz_id}", "I", "#{u.marca}"])

#		mov = Vanimals.find(:all, :conditions => ["tipo = ? and marca = ?", "I", "#{u.marca}"])

		if mov.length > 1
			puts u.marca
		end
	end


end
