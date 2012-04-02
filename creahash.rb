def creahash(selezione)
	#puts "creahash"
	#puts selezione.inspect
	selezione.each do |m|
		if m.data_applm !=nil
			data_applm = m.data_applm.strftime("%d/%m/%Y")
		else
			data_applm = ""
		end
		if m.data_ingr != nil
			data_ingr = m.data_ingr.strftime("%d/%m/%Y")
		else
			data_ingr = ""
		end
		if m.allevingr_id != nil
			allevingrcod317 = m.allevingr.cod317
			allevingrragsoc = m.allevingr.ragsoc
			allevingridfisc = m.allevingr.idfisc
			#itermov[46] = m.allevingr.id.to_s
		else
			allevingrcod317 = ""
			allevingrragsoc = ""
			allevingridfisc = ""
#					itermov[46] = ""
		end
#			elsif m.tipo == "U"
			if m.allevusc_id != nil
				allevusccod317 = m.allevusc.cod317
				allevuscragsoc = m.allevusc.ragsoc
				allevuscidfisc = m.allevusc.idfisc
				#itermov[47] = m.allevusc_id.to_s
			else
				allevusccod317 = ""
				allevuscragsoc = ""
				allevuscidfisc = ""
#					itermov[47] = ""
			end
#			end
		if m.nazprov_id.to_s != ""
			nazprov = m.nazprov.codice
		else
			nazprov = ""
		end
		if m.data_certsaningr != nil
			data_certsaningr = m.data_certsaningr.strftime("%d/%m/%Y")
		else
			data_certsaningr = ""
		end
		if m.data_mod4ingr != nil
			data_mod4ingr = m.data_mod4ingr.strftime("%d/%m/%Y")
		else
			data_mod4ingr = ""
		end
		if m.uscite_id != nil
			uscitedescr = m.uscite.descr
		else
			uscitedescr = ""
		end
			if m.uscita != nil
			uscita = m.uscita.strftime("%d/%m/%Y")
		else
			uscita = ""
		end
		if m.nazdest_id.to_s != ""
			nazdest = m.nazdest.codice
		else
			nazdest = ""
		end
		if m.macelli_id != nil
			macellinome = m.macelli.nomemac
			macelliif= m.macelli.ifmac
			macellibollo = m.macelli.bollomac
			macelliregion = m.macelli.region.regione
		else
			macellinome = ""
			macelliif = ""
			macellibollo = ""
			macelliregion = ""
		end
		if m.data_certsanusc != nil
			data_certsanusc = m.data_certsanusc.strftime("%d/%m/%Y")
		else
			data_certsanusc = ""
		end
		if m.trasportatori_id != nil
			nometrasp = m.trasportatori.nometrasp
		else
			nometrasp = ""
		end

#		itermov[44] = m.uscito.to_s
		if m.fileingr == true
			fileingr = "SI"
		else
			fileingr = "NO"
		end
		if m.fileusc == true
			fileusc = "SI"
		else
			fileusc = "NO"
		end
		if m.stampacar == true
			stampacar = "SI"
		else
			stampacar = "NO"
		end
		if m.stampascar == true
			stampascar = "SI"
		else
			stampascar = "NO"
		end
		#itermov[46] = m.mod4usc
		if m.data_mod4usc != nil
			data_mod4usc = m.data_mod4usc.strftime("%d/%m/%Y")
		else
			data_mod4usc = ""
		end
		#puts stampacar
		Hash["id", m.id.to_i, "progreg", m.progreg, "ragsoc", m.relaz.ragsoc.ragsoc, "marca", m.marca, "specie", m.specie, "razza", m.razza.razza, "data_nas", m.data_nas.strftime("%d/%m/%Y"), "stalla_nas", m.stalla_nas, "sesso", m.sesso, "nazorig", m.nazorig.codice, "naznasprimimp", m.naznasprimimp.codice, "data_applm", data_applm, "ilg", m.ilg, "marca_prec", m.marca_prec, "marca_madre", m.marca_madre, "marca_padre", m.marca_padre, "donatrice", m.donatrice, "ingresso", m.ingresso.descr, "data_ingr", m.data_ingr, "allevingrcod317", allevingrcod317, "allevingrragsoc", allevingrragsoc, "allevingridfisc", allevingridfisc, "allevusccod317", allevusccod317, "allevuscragsoc", allevuscragsoc, "allevuscidfisc", allevuscidfisc, "nazprov", nazprov, "certsaningr", m.certsaningr, "rifloc", m.rifloc, "data_certsaningr", data_certsaningr, "mod4ingr", m.mod4ingr, "data_mod4ingr", data_mod4ingr, "uscitedescr", uscitedescr, "uscita", uscita, "nazdest", nazdest, "macellinome", macellinome, "macelliif", macelliif, "macellibollo", macellibollo, "macelliregion", macelliregion, "certsanusc", m.certsanusc, "data_certsanusc", data_certsanusc, "marcasost", m.marcasost, "ditta_racc", m.ditta_racc, "clg", m.clg, "fileingr", fileingr, "fileusc", fileusc, "stampacar", stampacar, "stampascar", stampascar, "mod4usc", m.mod4usc, "data_mod4usc", data_mod4usc]
		

	end
	
end
