# Script per convertire il database di Aurox dalla versione 0.5 alla x
# Ricordarsi di:
# - creare i files di invio dati;
# - compilare il registro;
# - stampare il registro.

#Dopodiché:
# - rinominare animals in vanimals e registros in vregistros
# - importare la struttura vuota della nuova animals
# - importare la struttura vuota della tabella archives


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
        belongs_to :trasportatori, :class_name => "Trasportatoris"
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

class Vregistros < ActiveRecord::Base

end

# Inizio trasferimento movimenti di ingresso

ingressi = Vanimals.find(:all, :conditions => ["tipo = ?", "I"])

ingressi.each do |i|

	nazorig = Nations.find(:first, :conditions => ["codice = ?", "#{i.naz_orig}"])
	naznasprimimp = Nations.find(:first, :conditions => ["codice = ?", "#{i.naz_nasprimimp}"])
	nazprov = Nations.find(:first, :conditions => ["codice = ?", "#{i.naz_prov}"])
	registro = Vregistros.find(:first, :conditions => ["relaz_id = ? and marca = ? and dataingresso = ?", "#{i.relaz_id}", "#{i.marca}", "#{i.data_ingr}"])
	Animals.create(:contatori_id => "#{registro.contatori_id}", :progreg => "#{registro.progressivo}", :relaz_id => "#{i.relaz_id}", :ingresso_id => "#{i.cm_ing}", :marca => "#{i.marca}", :specie => "#{i.specie}", :razza_id => "#{i.razza_id}", :data_nas => "#{i.data_nas}", :stalla_nas => "#{i.stalla_nas}", :sesso => "#{i.sesso}", :nazorig_id => "#{nazorig.id}", :naznasprimimp_id => "#{naznasprimimp.id}", :data_applm => "#{i.data_applm}", :ilg => "#{i.ilg}", :embryo => "#{i.embryo}", :marca_prec => "#{i.marca_prec}", :marca_madre => "#{i.marca_madre}", :marca_padre => "#{i.marca_padre}", :donatrice => "#{i.donatrice}", :clg => "#{i.clg}", :data_ingr => "#{i.data_ingr}", :nazprov_id => "#{nazprov.id}", :certsaningr => "#{i.certsan}", :data_certsaningr => "#{i.data_certsan}", :rifloc => "#{i.rifloc}", :allevingr_id => "#{i.allevamenti_id}", :mod4ingr => "#{i.mod4}", :data_mod4ingr => "#{i.data_mod4}", :idcoll => "#{i.idcoll}")

end

uscite = Vanimals.find(:all, :conditions => ["tipo = ?", "U"])
errore = 0
uscite.each do |u|
	if u.idcoll == nil
		mov = Vanimals.find(:all, :conditions => ["relaz_id = ? and tipo = ? and marca = ?", "#{u.relaz_id}", "I", "#{u.marca}"])

#		mov = Vanimals.find(:all, :conditions => ["tipo = ? and marca = ?", "I", "#{u.marca}"])

		if mov.length > 1
			puts u.marca
			errore = 1
		end
	end
	if errore == 0
		#puts u.trasp
		if u.idcoll == nil
			if u.naz_dest.to_s != ""
				nazionedest = Nations.find(:first, :conditions => ["codice = ?", "#{u.naz_dest}"])
				nazdest = nazionedest.id
			else
				nazdest = nil
				if u.cm_usc != 4
					puts u.marca
				end
				puts nazdest
			end
			#puts u.trasp
			if u.trasp.to_s != ""
				#puts u.marca
				#puts "trasp"
				#puts u.trasp
				trasporto = Trasportatoris.find(:first, :conditions => ["nometrasp = ?", "#{u.trasp}"])
				#puts trasporto.nometrasp
				trasp = trasporto.id
			else
				trasp = u.trasp
			end
			capo = Animals.find(:first, :conditions => ["relaz_id = ? and marca = ?", "#{u.relaz_id}", "#{u.marca}"])
			Animals.update(capo.id, {:uscita => "#{u.uscita}", :uscite_id => "#{u.cm_usc}", :trasportatori_id => "#{trasp}", :marcasost => "#{u.marcasost}", :nazdest_id => "#{nazdest}", :allevusc_id => "#{u.allevamenti_id}", :macelli_id => "#{u.macelli_id}", :mod4usc => "#{u.mod4}", :data_mod4usc => "#{u.data_mod4}", :certsanusc => "#{u.certsanusc}", :data_certsanusc => "#{u.data_certsanusc}", :uscito => "1"})
		else
			if u.naz_dest != nil
				nazionedest = Nations.find(:first, :conditions => ["codice = ?", "#{u.naz_dest}"])
				nazdest = nazionedest.id
			else
				nazdest = u.naz_dest
				if u.cm_usc != 4
					puts u.marca
				end
				puts nazdest
			end
			if u.trasp != nil
				trasporto = Trasportatoris.find(:first, :conditions => ["nometrasp = ?", "#{u.trasp}"])
				trasp = trasporto.id
			else
				trasp = u.trasp
			end
			capo = Animals.find(:first, :conditions => ["relaz_id = ? and idcoll = ?", "#{u.relaz_id}", "#{u.id}"])
			#puts capo.inspect
			Animals.update(capo.id, {:uscita => "#{u.uscita}", :uscite_id => "#{u.cm_usc}", :trasportatori_id => "#{trasp}", :marcasost => "#{u.marcasost}", :nazdest_id => "#{nazdest}", :allevusc_id => "#{u.allevamenti_id}", :macelli_id => "#{u.macelli_id}", :mod4usc => "#{u.mod4}", :data_mod4usc => "#{u.data_mod4}", :certsanusc => "#{u.certsanusc}", :data_certsanusc => "#{u.data_certsanusc}", :uscito => "1"})
		end
	else
		puts errore
		puts "Controlla gli idcoll dei capi elencati e sistemali a mano"
	end
end

puts "Controlla gli usciti per morte o chi non ha una nazione di destinazione e correggila."




=begin
uscite.each do |u|
	if u.idcoll == nil
		mov = Animals.find(:first, :conditions => ["relaz_id = ? and tipo = ? and marca = ? and data_usc"])



end
=end

