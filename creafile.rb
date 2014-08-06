#Creazione del file da inviare all'ULSS

def creafile(finestra)
	nomefile = Time.now.strftime("#{@stallaoper.ragsoc.ragsoc.gsub(/[ ]/, "")}""%m%d_%H%M.asc")
#	if @sistema == "linux"
		fileulss = File.new("#{@dir}/file/#{nomefile}", "w+")
#	else
#		fileulss = File.new(".\\file\\#{nomefile}", "w+")
#	end
	selmovingr = Animals.find(:all, :from=> "animals", :conditions => ["relaz_id= ? and fileingr= ?", "#{@stallaoper.id}", "0"])
	luncampi = Luncampis.find(:first)
	if selmovingr.length > 0
		itermov = Array.new
		selmovingr.each do |mov|

			#creazione tipofile

			tipofile = "I".ljust(luncampi.tipo)

			#creazione 317 prop

			file317 = mov.relaz.stalle.cod317.ljust(luncampi.cod317)

			#creazione ragsoc

			ragsocfile = mov.relaz.ragsoc.ragsoc.ljust(luncampi.ragsoc)

			#creazione tipo idfisc ragsoc

			tifragsocfile = mov.relaz.ragsoc.idf.ljust(luncampi.tifragsoc	)

			#creazione idfisc ragsoc

			if mov.relaz.ragsoc.idf == 'I'
				ifragsocfile = mov.relaz.ragsoc.piva.ljust(luncampi.ifragsoc)
			else
				ifragsocfile = mov.relaz.ragsoc.codfisc.ljust(luncampi.ifragsoc)
			end

			#creazione atp

			atpfile = mov.relaz.atp.ljust(luncampi.atp)

			#creazione prop

			propfile = mov.relaz.prop.prop.ljust(luncampi.prop)

			#creazione tipo idfisc prop

			tifpropfile = mov.relaz.prop.idf.ljust(luncampi.tifprop)

			#creazione idfisc prop

			if mov.relaz.prop.idf == 'I'
				ifpropfile = mov.relaz.prop.piva.ljust(luncampi.ifprop)
			else
				ifpropfile = mov.relaz.prop.codfisc.ljust(luncampi.ifprop)
			end

			#creazione marca

			marcafile = mov.marca.ljust(luncampi.marca)

			#creazione specie

			speciefile = mov.specie.ljust(luncampi.specie)

			#Creazione razza

			if mov.razza_id != nil
				razzafile = mov.razza.cod_razza.ljust(luncampi.razza)
			else
				razzafile = "".ljust(luncampi.razza)
			end

			#creazione data nascita

			if mov.data_nas != nil
				datafile = mov.data_nas.strftime("%d%m%Y").ljust(luncampi.nascita)
			else
				datafile = "".ljust(luncampi.nascita)
			end

			#creazione cod. 317 nascita / prima importazione

			file317nas = mov.stalla_nas.ljust(luncampi.cod317nascita)

			#creazione sesso

			sessofile = mov.sesso.ljust(luncampi.sesso)

			#creazione nazione origine

			nazorigfile = mov.nazorig.codice.ljust(luncampi.nazorig)

			#creazione nazione prima importazione

			nazprimimpfile = mov.naznasprimimp.codice.ljust(luncampi.nazprimimp)

			#creazione data applicazione marca

			if mov.data_applm != nil
				dataapplmarcafile = mov.data_applm.strftime("%d%m%Y").ljust(luncampi.applmarca)
			else
				dataapplmarcafile = "".ljust(luncampi.applmarca)
			end

			#creazione ilg

			ilgfile = mov.ilg.ljust(luncampi.ilg)

			#creazione marca precedente

			if mov.marca_prec != nil
				marcaprecfile = mov.marca_prec.to_s.ljust(luncampi.marcaprec)
			else
				marcaprecfile = "".ljust(luncampi.marcaprec)
			end

			#creazione marca madre

			if mov.marca_madre != nil
				madrefile = mov.marca_madre.to_s.ljust(luncampi.madre)
			else
				madrefile = "".ljust(luncampi.madre)
			end

			#creazione marca padre

			if mov.marca_padre != nil
				padrefile = mov.marca_padre.to_s.ljust(luncampi.padre)
			else
				padrefile = "".ljust(luncampi.padre)
			end

			#creazione data passaporto (campo non presente nella tabella)

			datapassfile = "".ljust(luncampi.datapass)

			#creazione codice movimento ingresso

			movingfile = mov.ingresso_id.to_s.ljust(luncampi.codmoving)

			#creazione data ingresso

			if mov.data_ingr != nil
				dataingfile = mov.data_ingr.strftime("%d%m%Y").ljust(luncampi.dataing)
			else
				dataingfile = "".ljust(luncampi.dataing)
			end

			#creazione cod. 317 provenienza o destinazione

			if mov.ingresso_id != 13
				file317prov = mov.allevingr.cod317.ljust(luncampi.cod317prov)
				idfiscallfile = mov.allevingr.idfisc.ljust(luncampi.idfiscall)
			else
				file317prov = "".ljust(luncampi.cod317prov)
				idfiscallfile = "".ljust(luncampi.idfiscall)
			end
			file317dest = "".ljust(luncampi.cod317dest)
			ragsocdestfile = "".ljust(luncampi.ragsocdest)

			#creazione comune provenienza (campo non presente nella tabella)

			comunefile = "".ljust(luncampi.comuneprov)

			#creazione nazione provenienza

			nazprovfile = mov.nazprov.codice.ljust(luncampi.nazprov)

			#creazione codice movimento uscita

			movuscfile = "".ljust(luncampi.codmovusc)

			#creazione data uscita

			datauscfile = "".ljust(luncampi.datausc)

			#creazione comune destinazione (campo non presente nella tabella)

			comunedestfile = "".ljust(luncampi.comunedest)

			#creazione nazione destinazione

			nazdestfile = "".ljust(luncampi.nazdest)

			#creazione trasportatore

			traspfile = "".ljust(luncampi.trasportatore)

			#creazione comune trasportatore (campo non presente nella tabella)

			comtraspfile = "".ljust(luncampi.comunetrasp)

			#creazione targa trasportatore (campo non presente nella tabella)

			targatraspfile = "".ljust(luncampi.targatrasp)

			#creazione mod. 4

			if mov.ingresso_id != 1 and mov.ingresso_id != 13
				mod4file = mov.mod4ingr.ljust(luncampi.mod4)
				datamod4file = mov.data_mod4ingr.strftime("%d%m%Y").ljust(luncampi.datamod4)
			else
				mod4file = "".ljust(luncampi.mod4)
				datamod4file = "".ljust(luncampi.datamod4)
			end

			#creazione marca sostitutiva

			marcasostfile = "".ljust(luncampi.marcasost)

			#creazione libro genealogico

			clgfile = mov.clg.to_s.ljust(luncampi.codlibgen)

			#creazione regione macello

			regmacfile = "".ljust(luncampi.regmac)

			#creazione identificativo fiscale macello

			idfiscmacfile = "".ljust(luncampi.idfiscmac)

			#creazione bollo CEE macello

			bollomacfile = "".ljust(luncampi.bollomac)

			#creazione embryo transfer

			embryofile = mov.embryo.ljust(luncampi.embryo)

			#creazione identificativo fiscale stalla di nascita o prima importazione
			#ATTENZIONE: creare tabella con scelta allevamenti anche qua.

			ifragsocnasfile = "".ljust(luncampi.idfisc317nasc)

			#creazione data primo ingresso (campo non presente nella tabella)

			primoingrfile = "".ljust(luncampi.dataprimoingr)

			#creazione madre donatrice

			donatricefile = mov.donatrice.to_s.ljust(luncampi.madreembryotransf)

			#creazione riferimento locale

			riflocfile = mov.rifloc.to_s.ljust(luncampi.rifloc)

			#creazione certificato sanitario

			certsanfile = mov.certsaningr.to_s.ljust(luncampi.certsan)

			fileulss.puts("RC" + "#{tipofile}" + "I" + "#{file317}" + "#{ragsocfile}" + "#{tifragsocfile}" + "#{ifragsocfile}" + "#{atpfile}" + "#{propfile}" + "#{tifpropfile}" + "#{ifpropfile}" + "#{marcafile}" + "#{speciefile}" + "#{razzafile}" + "#{datafile}" + "#{file317nas}" + "#{sessofile}" + "#{nazorigfile}" + "#{nazprimimpfile}" + "#{dataapplmarcafile}" + "#{ilgfile}" + "#{marcaprecfile}" + "#{madrefile}" + "#{padrefile}" + "#{datapassfile}" + "#{movingfile}" +"#{dataingfile}" + "#{file317prov}" + "#{comunefile}" + "#{nazprovfile}" + "#{movuscfile}" + "#{datauscfile}" + "#{file317dest}" + "#{comunedestfile}" + "#{nazdestfile}" + "#{ragsocdestfile}" + "#{traspfile}" + "#{comtraspfile}" + "#{targatraspfile}" + "#{mod4file}" + "#{marcasostfile}" + "#{idfiscallfile}" + "#{datamod4file}" + "#{clgfile}" + "#{regmacfile}" + "#{idfiscmacfile}" + "#{bollomacfile}" + "#{embryofile}" + "#{ifragsocnasfile}" + "#{primoingrfile}" + "#{donatricefile}" + "#{riflocfile}" + "#{certsanfile}")
			Animals.update(mov.id, {:fileingr => "1"})
		end
	end

	selmovusc = Animals.find(:all, :from=> "animals", :conditions => ["relaz_id= ? and uscito = ? and fileusc= ?", "#{@stallaoper.id}", "1", "0"])
	if selmovusc.length != 0
		itermov = Array.new
		selmovusc.each do |mov|

			#creazione tipofile

			tipofile = "U".ljust(luncampi.tipo)

			#creazione 317 prop

			file317 = mov.relaz.stalle.cod317.ljust(luncampi.cod317)

			#creazione ragsoc

			ragsocfile = mov.relaz.ragsoc.ragsoc.ljust(luncampi.ragsoc)

			#creazione tipo idfisc ragsoc

			tifragsocfile = mov.relaz.ragsoc.idf.ljust(luncampi.tifragsoc)

			#creazione idfisc ragsoc

			if mov.relaz.ragsoc.idf == 'I'
				ifragsocfile = mov.relaz.ragsoc.piva.ljust(luncampi.ifragsoc)
			else
				ifragsocfile = mov.relaz.ragsoc.codfisc.ljust(luncampi.ifragsoc)
			end

			#creazione atp

			atpfile = mov.relaz.atp.ljust(luncampi.atp)

			#creazione prop

			propfile = mov.relaz.prop.prop.ljust(luncampi.prop)

			#creazione tipo idfisc prop

			tifpropfile = mov.relaz.prop.idf.ljust(luncampi.tifprop)

			#creazione idfisc prop

			if mov.relaz.prop.idf == 'I'
				ifpropfile = mov.relaz.prop.piva.ljust(luncampi.ifprop)
			else
				ifpropfile = mov.relaz.prop.codfisc.ljust(luncampi.ifprop)
			end

			#creazione marca

			marcafile = mov.marca.ljust(luncampi.marca)

			#creazione specie

			speciefile = mov.specie.ljust(luncampi.specie)

			#Creazione razza

			if mov.razza_id != nil
				razzafile = mov.razza.cod_razza.ljust(luncampi.razza)
			else
				razzafile = "".ljust(luncampi.razza)
			end

			#creazione data nascita

			if mov.data_nas != nil
				datafile = mov.data_nas.strftime("%d%m%Y").ljust(luncampi.nascita)
			else
				datafile = "".ljust(luncampi.nascita)
			end

			#creazione cod. 317 nascita / prima importazione

			file317nas = mov.stalla_nas.ljust(luncampi.cod317nascita)

			#creazione sesso

			sessofile = mov.sesso.ljust(luncampi.sesso)

			#creazione nazione origine

			nazorigfile = mov.nazorig.codice.ljust(luncampi.nazorig)

			#creazione nazione prima importazione

			nazprimimpfile = mov.naznasprimimp.codice.ljust(luncampi.nazprimimp)

			#creazione data applicazione marca, non obbligatoria per uscite

			dataapplmarcafile = "".ljust(luncampi.applmarca)

			#creazione ilg

			ilgfile = mov.ilg.ljust(luncampi.ilg)

			#creazione marca precedente, non serve per uscita

			marcaprecfile = "".ljust(luncampi.marcaprec)

			#creazione marca madre

			if mov.marca_madre != nil
				madrefile = mov.marca_madre.to_s.ljust(luncampi.madre)
			else
				madrefile = "".ljust(luncampi.madre)
			end

			#creazione marca padre

			if mov.marca_padre != nil
				padrefile = mov.marca_padre.to_s.ljust(luncampi.padre)
			else
				padrefile = "".ljust(luncampi.padre)
			end

			#creazione data passaporto (campo non presente nella tabella)

			datapassfile = "".ljust(luncampi.datapass)

			#creazione codice movimento ingresso

			movingfile = "".ljust(luncampi.codmoving)

			#creazione data ingresso

			dataingfile = "".ljust(luncampi.dataing)

			#creazione cod. 317 provenienza o destinazione

			if mov.allevusc_id != nil
				file317prov = "".ljust(luncampi.cod317prov)
				file317dest = mov.allevusc.cod317.ljust(luncampi.cod317dest)
				ragsocdestfile = mov.allevusc.ragsoc.ljust(luncampi.ragsocdest)
				idfiscallfile = mov.allevusc.idfisc.ljust(luncampi.idfiscall)
			else
				file317prov = "".ljust(luncampi.cod317prov)
				file317dest = "".ljust(luncampi.cod317dest)
				ragsocdestfile = "".ljust(luncampi.ragsocdest)
				idfiscallfile = "".ljust(luncampi.idfiscall)
			end

			#creazione comune provenienza (campo non presente nella tabella)

			comunefile = "".ljust(luncampi.comuneprov)

			#creazione nazione provenienza

			nazprovfile = mov.nazprov.codice.ljust(luncampi.nazprov)

			#creazione codice movimento uscita

			movuscfile = mov.uscite_id.to_s.ljust(luncampi.codmovusc)

			#creazione data uscita

			datauscfile = mov.uscita.strftime("%d%m%Y").ljust(luncampi.datausc)

			#creazione comune destinazione (campo non presente nella tabella)

			comunedestfile = "".ljust(luncampi.comunedest)

			#creazione nazione destinazione

			if mov.nazdest_id != nil
				nazdestfile = mov.nazdest.codice.ljust(luncampi.nazdest)
			else
				nazdestfile = "".ljust(luncampi.nazdest)
			end

			#creazione trasportatore

			if mov.trasportatori_id != nil
				traspfile = mov.trasportatori.nometrasp.ljust(itercampi[36])
			else
				traspfile = "".ljust(luncampi.trasportatore)
			end

			#creazione comune trasportatore (campo non presente nella tabella)

			comtraspfile = "".ljust(luncampi.comunetrasp)

			#creazione targa trasportatore (campo non presente nella tabella)

			targatraspfile = "".ljust(luncampi.targatrasp)

			if mov.uscite_id == 4 or mov.uscite_id == 16
				mod4file = mov.certsanusc.ljust(luncampi.mod4)
				datamod4file = mov.data_certsanusc.strftime("%d%m%Y").ljust(luncampi.datamod4)
			elsif mov.uscite_id == 6
				mod4file = "".ljust(luncampi.mod4)
				datamod4file = "".ljust(luncampi.datamod4)
			else
				mod4file = mov.mod4usc.ljust(luncampi.mod4)
				datamod4file = mov.data_mod4usc.strftime("%d%m%Y").ljust(luncampi.datamod4)
			end

			#creazione marca sostitutiva

			marcasostfile = mov.marcasost.to_s.ljust(luncampi.marcasost)

			#creazione libro genealogico

			clgfile = "".ljust(luncampi.codlibgen)

			#creazione dati macello

			if mov.macelli_id != nil
				regmacfile = mov.macelli.region.codreg.ljust(luncampi.regmac)
				idfiscmacfile = mov.macelli.ifmac.ljust(luncampi.idfiscmac)
				bollomacfile = mov.macelli.bollomac.ljust(luncampi.bollomac)
			else
				regmacfile = "".ljust(luncampi.regmac)
				idfiscmacfile = "".ljust(luncampi.idfiscmac)
				bollomacfile = "".ljust(luncampi.bollomac])
			end

			#creazione embryo transfer

			embryofile = "".ljust(luncampi.embryo)

			#creazione identificativo fiscale stalla di nascita o prima importazione
			#ATTENZIONE: creare tabella con scelta allevamenti anche qua.

			ifragsocnasfile = "".ljust(luncampi.idfisc317nasc)

			#creazione data primo ingresso (campo non presente nella tabella)

			primoingrfile = "".ljust(luncampi.dataprimoingr)

			#creazione madre donatrice

			donatricefile = "".ljust(luncampi.madreembryotransf)

			#creazione riferimento locale

			riflocfile = "".ljust(luncampi.rifloc)

			#creazione certificato sanitario

			certsanfile = "".ljust(luncampi.certsan)

			fileulss.puts("RC" + "#{tipofile}" + "I" + "#{file317}" + "#{ragsocfile}" + "#{tifragsocfile}" + "#{ifragsocfile}" + "#{atpfile}" + "#{propfile}" + "#{tifpropfile}" + "#{ifpropfile}" + "#{marcafile}" + "#{speciefile}" + "#{razzafile}" + "#{datafile}" + "#{file317nas}" + "#{sessofile}" + "#{nazorigfile}" + "#{nazprimimpfile}" + "#{dataapplmarcafile}" + "#{ilgfile}" + "#{marcaprecfile}" + "#{madrefile}" + "#{padrefile}" + "#{datapassfile}" + "#{movingfile}" +"#{dataingfile}" + "#{file317prov}" + "#{comunefile}" + "#{nazprovfile}" + "#{movuscfile}" + "#{datauscfile}" + "#{file317dest}" + "#{comunedestfile}" + "#{nazdestfile}" + "#{ragsocdestfile}" + "#{traspfile}" + "#{comtraspfile}" + "#{targatraspfile}" + "#{mod4file}" + "#{marcasostfile}" + "#{idfiscallfile}" + "#{datamod4file}" + "#{clgfile}" + "#{regmacfile}" + "#{idfiscmacfile}" + "#{bollomacfile}" + "#{embryofile}" + "#{ifragsocnasfile}" + "#{primoingrfile}" + "#{donatricefile}" + "#{riflocfile}" + "#{certsanfile}")
			Animals.update(mov.id, {:fileusc => "1"})
		end
	end
	filler1 = "".ljust(441)
	filler2 = "".ljust(94)
	fileulss.rewind
	righe = fileulss.readlines.length + 1
	righefile = "#{righe}".ljust(6)
	fileulss.write("RCT" + "#{filler1}" + "#{righefile}")
	fileulss.rewind
	checksum = 0
	fileulss.each_byte do |ch|
		checksum+=ch
	end
	checksumfile = "#{checksum}".ljust(12)
	fileulss.puts("#{checksumfile}" + "#{filler2}")
	fileulss.puts("")
	fileulss.close

#		if @sistema == "linux"
	Dir.foreach("#{@dir}/invio") do |f|
		File.delete("#{@dir}/invio/#{f}") if f.include?(".asc")
	end
	File.copy("#{@dir}/file/#{nomefile}", "#{@dir}/invio")
#		else
#			Dir.foreach(".\\invio") do |f|
#				File.delete(".\\invio\\#{f}") if f.include?(".asc")
#			end
#			File.copy(".\\file\\#{nomefile}", ".\\invio")
#		end

	Conferma.conferma(finestra, "File generato correttamente.")
#	else
#		Conferma.conferma(finestra, "Nessun capo da inviare.")
#	end
end
