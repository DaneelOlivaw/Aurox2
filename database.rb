#ActiveRecord::Base.logger = Logger.new("debug.log")
#ActiveRecord::Base.logger = Logger.new(STDOUT) #Butta in console il codice sql delle varie operazioni e query
#puts ActiveRecord.methods
filechiave = File.open('./impostazioni/chiave', 'r')
arrchiave = []
filechiave.each do |leggi|
	arrchiave << leggi.strip
end
filechiave.close
ActiveRecord::Base.establish_connection(
	:adapter => "mysql",
	:host => "localhost",
	:username => "aurox",
	:password => "#{arrchiave[0]}",
	:database => "aurox10"
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
	belongs_to :detentori, :class_name => "Detentoris"
	belongs_to :prop, :class_name => "Props"
	belongs_to :contatori, :class_name => "Contatoris"
	
	def self.selragsoc(stalleid)
		find(:all, :include => [:stalle, :ragsoc], :conditions => ["relazs.stalle_id= ?", "#{stalleid}"], :order => "ragsoc_id").map
	end

	def self.seldetentore(stalleid, ragsocid)
		find(:all, :include => [:stalle, :ragsoc, :detentori], :conditions => ["relazs.stalle_id= ? and relazs.ragsoc_id= ?", "#{stalleid}", "#{ragsocid}"]).map
	end

	def self.selprop(stalleid, ragsocid, combodetid)
		find(:all, :include => [:stalle, :ragsoc, :detentori, :prop], :conditions => ["relazs.stalle_id= ? and relazs.ragsoc_id= ? and relazs.detentori_id = ?", "#{stalleid}", "#{ragsocid}", "#{combodetid}"]).map
	end

	def self.cercagestito(cod317, ragsoc)
		find(:all, :include => [:stalle, :ragsoc], :conditions => ["stalles.cod317= ? and ragsocs.ragsoc= ?", "#{cod317}", "#{ragsoc}"]).map
	end

	def self.controllo(cod317, ragsoc, detentore, prop, atp)
		find(:first, :conditions => ["stalle_id= ? and ragsoc_id= ? and detentori_id = ? and prop_id = ? and atp = ?", "#{cod317}", "#{ragsoc}", "#{detentore}", "#{prop}", "#{atp}"])
	end

end

class Stalles < ActiveRecord::Base
	has_many :relaz
	belongs_to :region, :class_name => "Regions"
	def self.seleziona
		all.map
	end
#	def self.seleziona2
#		all
#	end

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

class Detentoris < ActiveRecord::Base
	has_many :relaz

	def self.seleziona
		all.map
	end

	def self.controllo(detentore, idfisc, tipoidfisc, iftab)
		find(:first, :conditions => ["detentore = ? and #{iftab} = ? and idf = ?", "#{detentore}", "#{idfisc}", "#{tipoidfisc}"])
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
	def self.provv
		find(:all, :conditions => ["id != 4 and id != 6 and id != 10 and id != 11 and id != 16"])
	end
end

#class Razzas < ActiveRecord::Base
#	has_many :animal
##	def self.ulss
##		find(:all, :conditions => ["ulss = ?", "1"], :order => "razza")
##	end
##	def self.unipeg
##		find(:all, :conditions => ["unipeg = ?", "1"], :order => "razza")
##	end
#	def self.tutti
#		#find(:all, :order => "razza")
#		all(:order => "razza")
#	end

#end

class Razzas < ActiveRecord::Base
	has_many :animal
	def self.ulss
		find(:all, :conditions => ["ulss = ?", "1"], :order => "razza")
	end
	def self.unipeg
		find(:all, :conditions => ["unipeg = ?", "1"], :order => "razza")
	end
	def self.tutti
		find(:all, :order => "razza")
	end
	def self.codbarre(var, codrazza)
		find(:first, :conditions => ["#{var} = ? and cod_razza= ?", "1", "#{codrazza}"], :order => "razza")
	end

end

class Animals < ActiveRecord::Base
	belongs_to :relaz, :class_name => "Relazs"
	#belongs_to :razza, :class_name => "Razzas"
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
	belongs_to :nazalleva, :class_name => "Nazalleva"
	belongs_to :nazallevb, :class_name => "Nazallevb"
	belongs_to :certification, :class_name => "Certifications"
	belongs_to :esportatori, :class_name => "Esportatoris"

	def self.tutti(stallaoper)
		#find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp, :uscite, :allevusc, {:macelli, :region}, :nazdest, :trasportatori], :conditions => ["relaz_id= ?", "#{stallaoper}"])
		all(:include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp, :uscite, :allevusc, {:macelli, :region}, :nazdest, :trasportatori], :conditions => ["relaz_id= ?", "#{stallaoper}"])
	end

	def self.presenti(stallaoper)
		#find(:all, :conditions => ["relaz_id= ? and uscito = ?", "#{stallaoper}", "0"], :order => "data_ingr")
		find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp], :conditions => ["relaz_id= ? and uscito = ?", "#{stallaoper}", "0"], :order => "data_ingr")
	end
	
	def self.presenti2(stallaoper)
		find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp], :conditions => ["relaz_id= ? and uscito = ?", "#{stallaoper}", "0"], :order => "data_ingr, id").map
	end

	def self.capi(stallaoper, uscito, marca)
		find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp, :uscite, :allevusc, {:macelli, :region}, :nazdest, :trasportatori], :conditions => ["relaz_id= ? and uscito LIKE ? and marca LIKE ?", "#{stallaoper}", "#{uscito}", "%#{marca}%"]) #do |c|
			#Hash["id", c.id, "marca", c.marca, "data_nas", c.data_nas, "data_ingr", c.data_ingr]
		#end
	end

	def self.ingressi(stallaoper)
		find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp, :uscite, :allevusc, {:macelli, :region}, :nazdest, :trasportatori], :conditions => ["relaz_id= ?", "#{stallaoper}"], :order => ["data_ingr, id"])
	end

	def self.uscite(stallaoper)
		find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp, :uscite, :allevusc, {:macelli, :region}, :nazdest, :trasportatori], :conditions => ["relaz_id= ? and uscito= ?", "#{stallaoper}", "1"], :order => ["uscita, mod4usc, id"])
	end

	def self.stamparegistroingr(stallaoper, stampa)
		find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp], :conditions => ["relaz_id= ? and stampacar = ?", "#{stallaoper}", "#{stampa}"], :order => ["data_ingr, id"])
	end

	def self.stamparegistrousc(stallaoper, stampa)
		find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp, :uscite, :allevusc, {:macelli, :region}, :nazdest, :trasportatori], :conditions => ["relaz_id= ? and stamparegistro= ? and uscite_id != ?", "#{stallaoper}", "#{stampa}", "null"], :order => ["uscita, mod4usc, id"]) #.map
	end

	def self.stamparegistro(stallaoper, stampa)
		find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp, :uscite, :allevusc, {:macelli, :region}, :nazdest, :trasportatori], :conditions => ["relaz_id= ? and stamparegistro= ? and uscito = ?", "#{stallaoper}", "#{stampa}", "1"], :order => ["data_ingr, id"])
	end
	
	def self.stamparegistroingrnv(stallaoper, anno)
		find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp], :conditions => ["relaz_id= ? and YEAR(data_ingr) = ?", "#{stallaoper}", "#{anno}"], :order => ["data_ingr, id"])
	end

#	def self.stamparegistrouscnv(stallaoper, anno)
#		find(:all, :conditions => ["relaz_id= ? and uscite_id != ? and YEAR(uscita) = ?", "#{stallaoper}", "null", "#{anno}"], :order => ["uscita, mod4usc, id"])
#	end

	def self.stamparegistrouscnv(stallaoper, anno)
		find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp, :uscite, :allevusc, {:macelli, :region}, :nazdest, :trasportatori], :conditions => ["relaz_id= ? and uscite_id != ? and YEAR(uscita) = ?", "#{stallaoper}", "null", "#{anno}"], :order => ["uscita, mod4usc, id"])
	end

	def self.stamparegistronv(stallaoper, anno)
			find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp, :uscite, :allevusc, {:macelli, :region}, :nazdest, :trasportatori], :conditions => ["relaz_id= ? and uscito = ? and YEAR(uscita) = ?", "#{stallaoper}", "1", "#{anno}"], :order => ["data_ingr, id"])
	end

	def self.trovapartita(stallaoper, tipodocumento, documento)
		find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp, :uscite, :allevusc, {:macelli, :region}, :nazdest, :trasportatori], :from => "animals", :conditions => ["relaz_id= ? and #{tipodocumento} LIKE ?", "#{stallaoper}", "#{documento}"])
	end


end

class Nations < ActiveRecord::Base
	def self.tutti
		#puts "tutte le nazioni"
		#find(:all, :order => "nome")
		all(:order => "nome DESC")

	end
	def self.nazunipeg
		all(:conditions => ["codice != ?", "IT"], :order => "nome")
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
		#find(:all, :order => "ragsoc")
		all(:order => "ragsoc")
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
	def self.cercaid(id)
		find(:first, :conditions => ["id = ?", "#{id}"])
	end
end

class Macellis < ActiveRecord::Base
	has_many :animal

	belongs_to :region, :class_name => "Regions"
	def self.tutti
		#find(:all, :include => [:region], :order => "nomemac")
		all(:include => [:region], :order => "nomemac")
	end

	def self.cerca(nome, idfisc, bollo, regione)
		find(:first, :include => [:region], :conditions => ["nomemac = ? and ifmac = ? and bollomac = ? and region_id = ?", "#{nome}", "#{idfisc}", "#{bollo}", "#{regione}"])
	end
	def self.cercaid(id)
		find(:first, :include => [:region], :conditions => ["id = ?", "#{id}"])
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
	def self.cercaid(id)
		find(:first, :conditions => ["id = ?", "#{id}"])
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
	has_many :stalle
	#selreg = Regions.find(:all, :order => "regione")
	def self.tutti
		#find(:all, :order => "regione")
		all(:order => "regione")
	end
end

class Archives < ActiveRecord::Base
	belongs_to :relaz, :class_name => "Relazs"
end

class Esportatoris < ActiveRecord::Base
	has_many :animal
	belongs_to :nation, :class_name => "Nations"
	def self.tutti
		all(:order => "descrizione")
	end
end

class Conditions < ActiveRecord::Base
	has_many :animal
	def self.tutte
		#find(:all, :order => "regione")
		all
	end
end

class Certifications < ActiveRecord::Base
	has_many :animal
end

class Luncampiunipegs < ActiveRecord::Base
end

class Nazalleva < Nations
	has_many :animal
end

class Nazallevb < Nations
	has_many :animal
end
class Mod4temps < ActiveRecord::Base
	belongs_to :relaz, :class_name => "Relazs"
	belongs_to :allevamenti, :class_name => "Allevamentis"
	belongs_to :macelli, :class_name => "Macellis"
	belongs_to :trasportatori, :class_name => "Trasportatoris"
	def self.conta(stallaoper)
		count(:all, :conditions => ["relaz_id= ?", "#{stallaoper}"])
	end
	def self.cerca(stallaoper)
		find(:all, :conditions => ["relaz_id= ?", "#{stallaoper}"])
	end
end
