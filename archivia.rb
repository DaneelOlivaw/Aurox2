def archivia(capi, marchivia, lista)
	capi.each do |c|
		if c.allevingr_id != nil
			ingr317 = c.allevingr.cod317
			ingridfisc = c.allevingr.idfisc
			ingrragsoc = c.allevingr.ragsoc
		else
			ingr317 = ""
			ingridfisc = ""
			ingrragsoc = ""
		end

		if c.nazdest_id != nil
			nazdest = c.nazdest.codice
		else
			nazdest = ""
		end

		if c.allevusc_id != nil
			usc317 = c.allevusc.cod317
			uscidfisc = c.allevusc.idfisc
			uscragsoc = c.allevusc.ragsoc
		else
			usc317 = ""
			uscidfisc = ""
			uscragsoc = ""
		end

		if c.macelli_id != nil
			macbollo = c.macelli.bollomac
			macidfisc = c.macelli.ifmac
			macragsoc = c.macelli.nomemac
			macregione = c.macelli.region.regione
		else
			macbollo = ""
			macidfisc = ""
			macragsoc = ""
			macregione = ""
		end
		if c.trasportatori_id != nil
			trasp = c.trasportatori.nometrasp
		else
			trasp = ""
		end
		unless c.nazalleva_id == nil
			nazalleva = c.nazalleva.codice
		else
			nazalleva = ""
		end
		unless c.nazallevb_id == nil
			nazallevb = c.nazallevb.codice
		else
			nazallevb = ""
		end
		unless c.condition_id == nil
			condizone = c.condition.descrizione
		else
			condizone = ""
		end
		unless c.certification_id == nil
			certificazione = c.certification.descrizione
		else
			certificazione = ""
		end
		unless c.esportatori_id == nil
			esportatori = c.esportatori.descrizione
		else
			esportatori = ""
		end

		Archives.create(:relaz_id => "#{c.relaz_id}", :progreg => "#{c.progreg}", :marca => "#{c.marca}", :specie => "#{c.specie}", :razza => "#{c.razza.cod_razza}", :data_nas => "#{c.data_nas}", :stalla_nas => "#{c.stalla_nas}", :sesso => "#{c.sesso}", :nazorig => "#{c.nazorig.codice}", :naznasprimimp => "#{c.naznasprimimp.codice}", :data_applm => "#{c.data_applm}", :ilg => "#{c.ilg}", :embryo => "#{c.embryo}", :marca_prec => "#{c.marca_prec}", :marca_madre => "#{c.marca_madre}", :marca_padre => "#{c.marca_padre}", :donatrice => "#{c.donatrice}", :clg => "#{c.clg}", :codingresso => "#{c.ingresso.descr}", :data_ingr => "#{c.data_ingr}", :nazprov => "#{c.nazprov.codice}", :certsaningr => "#{c.certsaningr}", :data_certsaningr => "#{c.data_certsaningr}", :rifloc => "#{c.rifloc}", :allevingr_cod317 => "#{ingr317}", :allevingr_ragsoc => "#{ingrragsoc}", :allevingr_idfisc => "#{ingridfisc}", :mod4ingr => "#{c.mod4ingr}", :data_mod4ingr => "#{c.data_mod4ingr}", :coduscita => "#{c.uscite.descr}", :data_uscita => "#{c.uscita}", :ditta_racc => "#{c.ditta_racc}", :trasp => "#{trasp}", :marcasost => "#{c.marcasost}", :nazdest => "#{nazdest}", :allevusc_cod317 => "#{usc317}", :allevusc_ragsoc => "#{uscragsoc}", :allevusc_idfisc => "#{uscidfisc}", :macello_bollo => "#{macbollo}", :macello_ragsoc => "#{macragsoc}", :macello_idfisc => "#{macidfisc}", :macello_regione => "#{macregione}", :mod4usc => "#{c.mod4usc}", :data_mod4usc => "#{c.data_mod4usc}", :certsanusc => "#{c.certsanusc}", :data_certsanusc => "#{c.data_certsanusc}", :nazalleva => "#{nazalleva}", :nazallevb => "#{nazallevb}", :siglapartita => "#{c.siglapartita}", :tipoanimale => "#{c.tipoanimale}", :tipocapo => "#{c.tipocapo}", :condition => "#{condizone}", :ppagato => "#{c.ppagato}", :parrivo => "#{c.parrivo}", :certification => "#{certificazione}", :testnoogm => "#{c.testnoogm}", :esportatori => "#{esportatori}":dati_unipeg => "#{c.dati_unipeg}")
		Animals.delete(c.id)
	end

	Conferma.conferma(marchivia, "Operazione eseguita correttamente.")

	arranni = []
	arranni2 = [@giorno.strftime("%Y").to_s]
	capi = Animals.find(:all, :conditions => ["relaz_id= ? and uscito = ? and fileusc= ? and fileingr = ? and stampacar = ? and stamparegistro = ?", "#{@stallaoper.id}", "1", "1", "1", "1", "1"])
	capi.each do |c|
		arranni << c.uscita.strftime("%Y")
	end
	arranni.uniq!
	capi2 = Animals.find(:all, :conditions => ["relaz_id= ? and (uscito = ? or fileusc= ? or fileingr = ? or stampacar = ? or stamparegistro = ?)", "#{@stallaoper.id}", "0", "0", "0", "0", "0"])
	capi2.each do |c|
		arranni2 << c.data_ingr.strftime("%Y")
	end
	arranni2.uniq!
	anniarchiviare = arranni - arranni2

	if lista != nil
		lista.clear
		anniarchiviare.each do |a|
			iter = lista.append
			iter[0] = a
		end
	end
end
