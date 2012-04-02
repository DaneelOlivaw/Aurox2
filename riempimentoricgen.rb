#def riempimento2(selmov, lista, labelconto, datainizio, datafine)
def riempimentoricgen(selreg, listareg, labelcontoreg, datainizio, datafine, disordine)
#	puts @giorno
#	puts @giorno.class
#	puts @giorno.to_i
	#array = Array.new
	#hash = Hash.new
	selreg.each do |m|
		b = Hash.new(0)
		#puts m.datanascita.strftime("%s")
		iterreg = listareg.append
		iterreg[0] = m.id.to_i
		iterreg[1] = m.progreg
		iterreg[2] = m.marca
		iterreg[3] = m.razza.cod_razza
		iterreg[4] = m.sesso
		iterreg[5] = m.marca_madre
		iterreg[6] = m.ingresso_id.to_s
		iterreg[7] = m.data_nas.strftime("%d/%m/%Y")
		iterreg[8] = m.data_ingr.strftime("%d/%m/%Y")
		if m.ingresso_id == 13 or m.ingresso_id == 23 or m.ingresso_id == 32
			if m.certsaningr.to_s != ""
				modingr = m.certsaningr
			else
				modingr = m.rifloc
			end
		else
			modingr = m.allevingr.cod317
		end
		#iterreg[9] = m.provenienza
		iterreg[10] = m.uscite_id.to_s
		if m.uscita != nil
			iterreg[11] = m.uscita.strftime("%d/%m/%Y")
		else
			iterreg[11] = ""
		end
		if m.uscite_id != nil
		if m.uscite_id == 4 or m.uscite_id == 6 or m.uscite_id == 10 or m.uscite_id == 11
			destinazione = ""
		elsif m.uscite_id == 9
			destinazione = m.macelli.nomemac
		else
			destinazione = m.allevusc.cod317
		end

		if destinazione.length > 18
			destinazione = destinazione[0..16] + "..."
		end
#		else
#			destinazione = i.destinazione
		end
		#iterreg[12] = m.destinazione
		iterreg[13] = m.marca_prec
		iterreg[14] = m.mod4ingr
		iterreg[15] = m.mod4usc
		iterreg[16] = m.certsaningr
		iterreg[17] = m.certsanusc
		#iterreg[18] = m.ragsoc
		iterreg[19] = m.data_nas.strftime("%s")
		#b = {"id" => iterreg[0], "prog" => iterreg[1], "marca" => iterreg[2], "nascita" => iterreg[7], "nascitaepoch" => m.datanascita.strftime("%s")}
		#array << b
		disordine << {"id" => iterreg[0], "prog" => iterreg[1], "marca" => iterreg[2], "razza" => iterreg[3], "sesso" => iterreg[4], "madre" => iterreg[5], "tipoingresso"=> iterreg[6],  "datanascita" => iterreg[7], "dataingresso" => iterreg[8], "provenienza" => modingr, "tipouscita" => iterreg[10], "datauscita" => iterreg[11], "destinazione" => destinazione, "marcaprec" => iterreg[13], "mod4ingr" => iterreg[14], "mod4usc" => iterreg[15], "certsaningr" => iterreg[16], "certsanusc" => iterreg[17], "ragsoc" => "togliere", "nascitaepoch" => m.data_nas.strftime("%s")}
	end
	#puts array.inspect
#	arr2 = Array.new
#	arr2 = array.sort_by { |hsh| hsh["nascitaepoch"] }.reverse!
#	puts arr2.inspect
	labelcontoreg.text = ("Movimenti trovati dal #{datainizio} al #{datafine}: #{selreg.length}")
end
