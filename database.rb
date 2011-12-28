#ActiveRecord::Base.logger = Logger.new("debug.log")
#ActiveRecord::Base.logger = Logger.new(STDOUT) #Butta in console il codice sql delle varie operazioni e query
ActiveRecord::Base.establish_connection(
	:adapter => "mysql",
	:host => "localhost",
	:username => "aurox",
	:password => "password",
	:database => "aurox2"
)

class Parameters < ActiveRecord::Base
	def self.parametri
		find(:first)
	end
end

class Relazs < ActiveRecord::Base
	has_many :animal
	belongs_to :user, :class_name => "Users"
	belongs_to :stalle, :class_name => "Stalles"
	belongs_to :ragsoc, :class_name => "Ragsocs"
	belongs_to :prop, :class_name => "Props"
	belongs_to :contatori, :class_name => "Contatoris"
	
	def self.selragsoc(stalleid)
		find(:all, :conditions => ["relazs.stalle_id= ?", "#{stalleid}"], :order => "ragsoc_id").map
	end

	def self.selprop(stalleid, ragsocid)
		find(:all, :conditions => ["relazs.stalle_id= ?  and relazs.ragsoc_id= ?", "#{stalleid}", "#{ragsocid}"]).map
	end

	def self.cercagestito(cod317, ragsoc)
		find(:all, :include => [:stalle, :ragsoc], :conditions => ["stalles.cod317= ? and ragsocs.ragsoc= ?", "#{cod317}", "#{ragsoc}"]).map
	end

end

class Stalles < ActiveRecord::Base
	has_many :relaz

	def self.seleziona
		all.map
	end

	def self.controllo(cod317)
		find(:first, :conditions => ["cod317 = ?", "#{cod317}"])
	end

end

class Ragsocs < ActiveRecord::Base
	has_many :relaz

	def self.seleziona
		all.map
	end

	def self.controllo(ragsoc, idfisc, tipoidfisc, iftab)
		find(:first, :conditions => ["ragsoc = ? and #{iftab} = ? and idf = ?", "#{ragsoc}", "#{idfisc}", "#{tipoidfisc}"])
	end
end

class Props < ActiveRecord::Base
	has_many :relaz

	def self.seleziona
		all.map
	end

	def self.controllo(prop, idfisc, tipoidfisc, iftab)
		find(:first, :conditions => ["prop = ? and #{iftab} = ? and idf = ?", "#{prop}", "#{idfisc}", "#{tipoidfisc}"])
	end

end

class Ingressos < ActiveRecord::Base
	has_many :animal

	def self.tutti
		all.map
	end

end

class Uscites < ActiveRecord::Base
	has_many :animal

	def self.tutti
		all.map
	end

end

class Razzas < ActiveRecord::Base
	has_many :animal

	def self.tutti
		find(:all, :order => "razza")
	end

end

class Animals < ActiveRecord::Base
	belongs_to :relaz, :class_name => "Relazs"
	belongs_to :razza, :class_name => "Razzas"
	belongs_to :ingresso, :class_name => "Ingressos"
	belongs_to :allevingr, :class_name => "Allevingrs"
	belongs_to :uscite, :class_name => "Uscites"
	belongs_to :allevusc, :class_name => "Allevuscs"
	belongs_to :macelli, :class_name => "Macellis"
	belongs_to :nazorig, :class_name => "Nazorigs"
	belongs_to :nazprov, :class_name => "Nazprovs"
	belongs_to :naznasprimimp, :class_name => "Naznasprimimps"
	belongs_to :nazdest, :class_name => "Nazdests"
	belongs_to :trasportatori, :class_name => "Trasportatoris"

	def self.presenti(stallaoper)
		find(:all, :conditions => ["relaz_id= ? and uscito = ?", "#{stallaoper}", "0"], :order => "data_ingr")
	end
	
	def self.presenti2(stallaoper)
		find(:all, :conditions => ["relaz_id= ? and uscito = ?", "#{stallaoper}", "0"], :order => "data_ingr, id").map
	end

	def self.capi(stallaoper, marca)
		find(:all, :conditions => ["relaz_id= ? and uscito = ? and marca LIKE ?", "#{stallaoper}", "0", "%#{marca}%"]) do |c|
			Hash["id", c.id, "marca", c.marca, "data_nas", c.data_nas, "data_ingr", c.data_ingr]
		end
	end

	def self.stamparegistroingr(stallaoper, stampa)
		find(:all, :conditions => ["contatori_id= ? and stampacar = ?", "#{stallaoper}", "#{stampa}"], :order => ["data_ingr, id"]).map
	end

	def self.stamparegistrousc(stallaoper, stampa)
		find(:all, :conditions => ["contatori_id= ? and stampascar= ? and uscite_id != ?", "#{stallaoper}", "#{stampa}", "null"], :order => ["uscita, mod4usc, id"]).map
	end

	def self.stamparegistro(stallaoper, stampa)
		find(:all, :conditions => ["contatori_id= ? and stampascar= ? and uscito = ?", "#{stallaoper}", "#{stampa}", "1"], :order => ["data_ingr, id"])
	end
	
	def self.stamparegistroingrnv(stallaoper, anno)
		find(:all, :conditions => ["contatori_id= ? and YEAR(data_ingr) = ?", "#{stallaoper}", "#{anno}"], :order => ["data_ingr, id"])
	end

	def self.stamparegistrouscnv(stallaoper, anno)
		find(:all, :conditions => ["contatori_id= ? and uscite_id != ? and YEAR(uscita) = ?", "#{stallaoper}", "null", "#{anno}"], :order => ["uscita, mod4usc, id"])
	end

	def self.stamparegistronv(stallaoper, anno)
			find(:all, :conditions => ["contatori_id= ? and uscito = ? and YEAR(uscita) = ?", "#{stallaoper}", "1", "#{anno}"], :order => ["data_ingr, id"])
	end

end

class Nations < ActiveRecord::Base
	def self.tutti
		#puts "tutte le nazioni"
		find(:all, :order => "nome")
	end
end

class Nazorigs < Nations
	has_many :animal
end

class Nazprovs < Nations
	has_many :animal
end

class Naznasprimimps < Nations
	has_many :animal
end

class Nazdests < Nations
	has_many :animal
end

class Allevamentis < ActiveRecord::Base
	def self.tutti
		find(:all, :order => "ragsoc")
	end

	def self.cerca(ragsoc, idfisc, cod317)
		find(:first, :conditions => ["ragsoc = ? and idfisc = ? and cod317 = ?", "#{ragsoc}", "#{idfisc}", "#{cod317}"])
	end
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
	def self.tutti
		find(:all, :order => "nomemac")
	end

	def self.cerca(nome, idfisc, bollo, regione)
		find(:first, :conditions => ["nomemac = ? and ifmac = ? and bollomac = ? and region_id = ?", "#{nome}", "#{idfisc}", "#{bollo}", "#{regione}"])
	end
end

class Trasportatoris < ActiveRecord::Base
	has_many :animal

	def self.tutti
		find(:all, :order => "nometrasp") do |t|
			Hash["id", t.id, "nometrasp", t.nometrasp]
		end
	end

	def self.cerca(nometrasp)
		find(:first, :conditions => ["nometrasp = ?", "#{nometrasp}"])
	end

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

	selreg = Regions.find(:all, :order => "regione")
	def self.tutti
		find(:all, :order => "regione")
	end
end

class Archives < ActiveRecord::Base
	belongs_to :relaz, :class_name => "Relazs"
end
