# Visualizza movimenti

def vismovimenti
	mvismov = Gtk::Window.new("Vista movimenti")
	#mvismov.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mvismov.set_default_size(800, 600)
	mvismov.maximize
	mvismovscroll = Gtk::ScrolledWindow.new #(hadjustment = nil, vadjustment = nil)
	boxmovv = Gtk::VBox.new(false, 0)
	boxmov1 = Gtk::HBox.new(false, 0)
	boxmov2 = Gtk::HBox.new(false, 0)
	boxmovv.pack_start(boxmov1, false, false, 5)
	boxmovv.pack_start(boxmov2, true, true, 5)
	labelconto = Gtk::Label.new("Movimenti trovati: 0")
	mvismov.add(boxmovv)

	def riempimento(selmov, lista, labelconto)
		puts "riempimento"
		selmov.each do |m|
			itermov = lista.append
			itermov[0] = m.id.to_i
			itermov[1] = m.progreg
			itermov[2] = m.relaz.ragsoc.ragsoc
			itermov[3] = m.marca
			itermov[4] = m.specie
			itermov[5] = m.razza.razza
			itermov[6] = m.data_nas.strftime("%d/%m/%Y")
			itermov[7] = m.stalla_nas
			itermov[8] = m.sesso
			itermov[9] = m.nazorig.codice
			itermov[10] = m.naznasprimimp.codice
			if m.data_applm !=nil
				itermov[11] = m.data_applm.strftime("%d/%m/%Y")
			else
				itermov[11] = ""
			end
			itermov[12] = m.ilg
			itermov[13] = m.marca_prec
			itermov[14] = m.marca_madre
			itermov[15] = m.marca_padre
			itermov[16] = m.donatrice
			itermov[17] = m.ingresso.descr
			if m.data_ingr != nil
				itermov[18] = m.data_ingr.strftime("%d/%m/%Y")
			else
				itermov[18] = ""
			end
#			if m.tipo == "I"
				if m.allevingr_id != nil
					itermov[19] = m.allevingr.cod317
					itermov[20] = m.allevingr.ragsoc
					itermov[21] = m.allevingr.idfisc
					itermov[46] = m.allevingr.id.to_s
				else
					itermov[19] = ""
					itermov[20] = ""
					itermov[21] = ""
#					itermov[46] = ""
				end
#			elsif m.tipo == "U"
				if m.allevusc_id != nil
					itermov[30] = m.allevusc.cod317
					itermov[32] = m.allevusc.ragsoc
					itermov[33] = m.allevusc.idfisc
					itermov[47] = m.allevusc_id.to_s
				else
					itermov[30] = ""
					itermov[32] = ""
					itermov[33] = ""
#					itermov[47] = ""
				end
#			end
			if m.nazprov_id.to_s != ""
				itermov[22] = m.nazprov.codice
			else
				itermov[22] = ""
			end
			itermov[23] = m.certsaningr
			itermov[24] = m.rifloc
			if m.data_certsaningr != nil
				itermov[25] = m.data_certsaningr.strftime("%d/%m/%Y")
			else
				itermov[25] = ""
			end
			itermov[26] = m.mod4ingr
			if m.data_mod4ingr != nil
				itermov[27] = m.data_mod4ingr.strftime("%d/%m/%Y")
			else
				itermov[27] = ""
			end
			if m.uscite_id != nil
				itermov[28] = m.uscite.descr
			else
				itermov[28] = ""
			end
				if m.uscita != nil
				itermov[29] = m.uscita.strftime("%d/%m/%Y")
			else
				itermov[29] = ""
			end
			if m.nazdest_id.to_s != ""
				itermov[31] = m.nazdest.codice
			else
				itermov[31] = ""
			end
			if m.macelli_id != nil
				itermov[34] = m.macelli.nomemac
				itermov[35] = m.macelli.ifmac
				itermov[36] = m.macelli.bollomac
				itermov[37] = m.macelli.region.regione
			else
				itermov[34] = ""
				itermov[35] = ""
				itermov[36] = ""
				itermov[37] = ""
			end
			itermov[38] = m.certsanusc
			if m.data_certsanusc != nil
				itermov[39] = m.data_certsanusc.strftime("%d/%m/%Y")
			else
				itermov[39] = ""
			end
			if m.trasportatori_id != nil
				itermov[40] = m.trasportatori.nometrasp
			else
				itermov[40] = ""
			end
			itermov[41] = m.marcasost
			itermov[42] = m.ditta_racc
			itermov[43] = m.clg
			itermov[44] = m.uscito.to_s
			if m.fileingr == true
				itermov[45] = "SI"
			else
				itermov[45] = "NO"
			end
			if m.fileusc == true
				itermov[48] = "SI"
			else
				itermov[48] = "NO"
			end
			if m.stampacar == true
				itermov[49] = "SI"
			else
				itermov[49] = "NO"
			end
			if m.stampascar == true
				itermov[50] = "SI"
			else
				itermov[50] = "NO"
			end
			itermov[46] = m.mod4usc
			if m.data_mod4usc != nil
				itermov[47] = m.data_mod4usc.strftime("%d/%m/%Y")
			else
				itermov[47] = ""
			end
		end
	labelconto.text = ("Movimenti trovati: #{selmov.length}")
	end
	
	def riempimento2(selmov, lista, labelconto)
		puts "riempimento2"
		selmov.each do |m|
			itermov = lista.append
			itermov[0] = m["id"]
			itermov[1] = m["progreg"]
			itermov[2] = m["ragsoc"]
			itermov[3] = m["marca"]
			itermov[4] = m["specie"]
			itermov[5] = m["razza"]
			itermov[6] = m["data_nas"] #.strftime("%d/%m/%Y")
			itermov[7] = m["stalla_nas"]
			itermov[8] = m["sesso"]
			itermov[9] = m["nazorig"]
			itermov[10] = m["naznasprimimp"]
			itermov[11] = m["data_applm"]
			itermov[12] = m["ilg"]
			itermov[13] = m["marca_prec"]
			itermov[14] = m["marca_madre"]
			itermov[15] = m["marca_padre"]
			itermov[16] = m["donatrice"]
			itermov[17] = m["ingresso"]
			itermov[18] = m["data_ingr"].to_s
			itermov[19] = m["allevingrcod317"]
			itermov[20] = m["allevingrragsoc"]
			itermov[21] = m["allevingridfisc"]
#			itermov[46] = m["allevingr.id.to_s
			itermov[30] = m["allevusccod317"]
			itermov[32] = m["allevuscragsoc"]
			itermov[33] = m["allevuscidfisc"]
#				itermov[47] = m["allevusc_id.to_s"]
			itermov[22] = m["nazprov"]
			itermov[23] = m["certsaningr"]
			itermov[24] = m["rifloc"]
			itermov[25] = m["data_certsaningr"].to_s
			itermov[26] = m["mod4ingr"]
			itermov[27] = m["data_mod4ingr"].to_s
			itermov[28] = m["uscitedescr"]
			itermov[29] = m["uscita"]
			itermov[31] = m["nazdest"]
			itermov[34] = m["macellinome"]
			itermov[35] = m["macelliif"]
			itermov[36] = m["macellibollo"]
			itermov[37] = m["macelliregion"]
			itermov[38] = m["certsanusc"]
			itermov[39] = m["data_certsanusc"].to_s
			itermov[40] = m["trasportatori.nometrasp"]
			itermov[41] = m["marcasost"]
			itermov[42] = m["ditta_racc"]
			itermov[43] = m["clg"]
			itermov[44] = m["uscito"].to_s
			itermov[45] = m["fileingr"].to_s
			itermov[48] = m["fileusc"].to_s
			itermov[49] = m["stampacar"].to_s
			puts itermov[49]
			puts m["stampacar"]
			itermov[50] = m["stampascar"].to_s
			itermov[46] = m["mod4usc"]
			itermov[47] = m["data_mod4usc"].to_s
		end
	labelconto.text = ("Movimenti trovati: #{selmov.length}")
	end

	visingressi = Gtk::Button.new( "Visualizza ingressi" )
	visuscite = Gtk::Button.new( "Visualizza uscite" )
	vispresenti = Gtk::Button.new( "Visualizza presenti in stalla" )
	vistutti = Gtk::Button.new( "Visualizza tutti" )
	visricerca = Gtk::Button.new( "Cerca capo" )
	visricercaentry = Gtk::Entry.new
	lista = Gtk::ListStore.new(Integer, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String)
	vista = Gtk::TreeView.new(lista)
	vista.selection.mode = Gtk::SELECTION_SINGLE #BROWSE #SINGLE #MULTIPLE
#	vista.show_expanders = (true)
	vista.rules_hint = true
#	vista.set_enable_grid_lines(true)
#	@relid = @combo3.active_iter[0]
	visingressi.signal_connect("clicked") {
		lista.clear
		selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ?", "#{@stallaoper.id}"], :order => ["data_ingr, id"])
		riempimento(selmov, lista, labelconto)
	}
	visuscite.signal_connect("clicked") {
		lista.clear
		selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and uscito= ?", "#{@stallaoper.id}", "1"], :order => ["uscita, mod4usc, id"])
		riempimento(selmov, lista, labelconto)
	}
	vispresenti.signal_connect("clicked") {
		lista.clear
		puts "vispresenti"
		#selmov = Animals.presenti2(@stallaoper.id)
		#puts selmov.inspect
		#creahash(selmov)
		#selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and uscito= ?", "#{@stallaoper.id}", "0"], :order => ["data_ingr"])
		#riempimento2(selmov, lista, labelconto)
		#riempimento(selmov, lista, labelconto)
		riempimento(Animals.presenti2(@stallaoper.id), lista, labelconto)
	}
	vistutti.signal_connect("clicked") {
		lista.clear
		selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ?", "#{@stallaoper.id}"])
		riempimento(selmov, lista, labelconto)
	}
	visricerca.signal_connect("clicked") {
		lista.clear
		selmov = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and marca LIKE ?", "#{@stallaoper.id}", "%#{visricercaentry.text}%"])
		riempimento(selmov, lista, labelconto)
	}
		cella = Gtk::CellRendererText.new
		colonna1 = Gtk::TreeViewColumn.new("Progressivo", cella)
		colonna1.resizable = true
		colonna2 = Gtk::TreeViewColumn.new("Ragione sociale", cella)
		colonna2.resizable = true
		colonna3 = Gtk::TreeViewColumn.new("Marca", cella)
		colonna4 = Gtk::TreeViewColumn.new("Specie", cella)
		colonna5 = Gtk::TreeViewColumn.new("Razza", cella)
		colonna5.resizable = true
		colonna6 = Gtk::TreeViewColumn.new("Data di nascita", cella)
		colonna7 = Gtk::TreeViewColumn.new("Stalla di nascita", cella)
		colonna8 = Gtk::TreeViewColumn.new("Sesso", cella)
		colonna9 = Gtk::TreeViewColumn.new("Nazione origine", cella)
		colonna10 = Gtk::TreeViewColumn.new("Nazione prima importazione", cella)
		colonna11 = Gtk::TreeViewColumn.new("Data applicazione marca", cella)
		colonna12 = Gtk::TreeViewColumn.new("ILG", cella)
		colonna13 = Gtk::TreeViewColumn.new("Marca precedente", cella)
		colonna14 = Gtk::TreeViewColumn.new("Marca madre", cella)
		colonna15 = Gtk::TreeViewColumn.new("Marca padre", cella)
		colonna16 = Gtk::TreeViewColumn.new("Marca donatrice", cella)
		colonna17 = Gtk::TreeViewColumn.new("Movimento ingresso", cella)
		colonna18 = Gtk::TreeViewColumn.new("Data ingresso", cella)
		colonna19 = Gtk::TreeViewColumn.new("Cod. stalla provenienza", cella)
		colonna20 = Gtk::TreeViewColumn.new("Stalla provenienza", cella)
		colonna21 = Gtk::TreeViewColumn.new("Id. fisc. provenienza", cella)
		colonna22 = Gtk::TreeViewColumn.new("Nazione provenienza", cella)
		colonna23 = Gtk::TreeViewColumn.new("Certificato sanitario ingresso", cella)
		colonna24 = Gtk::TreeViewColumn.new("Riferimento locale", cella)
		colonna25 = Gtk::TreeViewColumn.new("Data certificato sanitario", cella)
		colonna26 = Gtk::TreeViewColumn.new("Modello 4 ingresso", cella)
		colonna27 = Gtk::TreeViewColumn.new("Data modello 4 ingresso", cella)
		colonna28 = Gtk::TreeViewColumn.new("Movimento uscita", cella)
		colonna29 = Gtk::TreeViewColumn.new("Data uscita", cella)
		colonna30 = Gtk::TreeViewColumn.new("Stalla destinazione", cella)
		colonna31 = Gtk::TreeViewColumn.new("Nazione destinazione", cella)
		colonna32 = Gtk::TreeViewColumn.new("Allevamento destinazione", cella)
		colonna33 = Gtk::TreeViewColumn.new("Id. fisc. allevamento destinazione", cella)
		colonna34 = Gtk::TreeViewColumn.new("Macello destinazione", cella)
		colonna35 = Gtk::TreeViewColumn.new("Id. fisc. macello", cella)
		colonna36 = Gtk::TreeViewColumn.new("Bollo macello", cella)
		colonna37 = Gtk::TreeViewColumn.new("Regione macello", cella)
		colonna38 = Gtk::TreeViewColumn.new("Cert. san. uscita", cella)
		colonna39 = Gtk::TreeViewColumn.new("Data cert. san. uscita", cella)
		colonna40 = Gtk::TreeViewColumn.new("Modello 4 uscita", cella)
		colonna41 = Gtk::TreeViewColumn.new("Data modello 4 uscita", cella)
		colonna42 = Gtk::TreeViewColumn.new("Trasportatore", cella)
		colonna43 = Gtk::TreeViewColumn.new("Marca sostitutiva", cella)
		colonna44 = Gtk::TreeViewColumn.new("Ditta raccoglitrice", cella)
		colonna45 = Gtk::TreeViewColumn.new("File movimento ingresso", cella)
		colonna46 = Gtk::TreeViewColumn.new("File movimento uscita", cella)
		colonna47 = Gtk::TreeViewColumn.new("Stampa registro ingresso", cella)
		colonna48 = Gtk::TreeViewColumn.new("Stampa registro uscita", cella)
		colonna1.set_attributes(cella, :text => 1)
		colonna2.set_attributes(cella, :text => 2)
		colonna3.set_attributes(cella, :text => 3)
		colonna4.set_attributes(cella, :text => 4)
		colonna5.set_attributes(cella, :text => 5)
		colonna6.set_attributes(cella, :text => 6)
		colonna7.set_attributes(cella, :text => 7)
		colonna8.set_attributes(cella, :text => 8)
		colonna9.set_attributes(cella, :text => 9)
		colonna10.set_attributes(cella, :text => 10)
		colonna11.set_attributes(cella, :text => 11)
		colonna12.set_attributes(cella, :text => 12)
		colonna13.set_attributes(cella, :text => 13)
		colonna14.set_attributes(cella, :text => 14)
		colonna15.set_attributes(cella, :text => 15)
		colonna16.set_attributes(cella, :text => 16)
		colonna17.set_attributes(cella, :text => 17)
		colonna18.set_attributes(cella, :text => 18)
		colonna19.set_attributes(cella, :text => 19)
		colonna20.set_attributes(cella, :text => 20)
		colonna21.set_attributes(cella, :text => 21)
		colonna22.set_attributes(cella, :text => 22)
		colonna23.set_attributes(cella, :text => 23)
		colonna24.set_attributes(cella, :text => 24)
		colonna25.set_attributes(cella, :text => 25)
		colonna26.set_attributes(cella, :text => 26)
		colonna27.set_attributes(cella, :text => 27)
		colonna28.set_attributes(cella, :text => 28)
		colonna29.set_attributes(cella, :text => 29)
		colonna30.set_attributes(cella, :text => 30)
		colonna31.set_attributes(cella, :text => 31)
		colonna32.set_attributes(cella, :text => 32)
		colonna33.set_attributes(cella, :text => 33)
		colonna34.set_attributes(cella, :text => 34)
		colonna35.set_attributes(cella, :text => 35)
		colonna36.set_attributes(cella, :text => 36)
		colonna37.set_attributes(cella, :text => 37)
		colonna38.set_attributes(cella, :text => 38)
		colonna39.set_attributes(cella, :text => 39)
		colonna40.set_attributes(cella, :text => 46)
		colonna41.set_attributes(cella, :text => 47)
#		colonna40.set_attributes(cella, :text => 40)
#		colonna41.set_attributes(cella, :text => 41)
#		colonna42.set_attributes(cella, :text => 42)
#		colonna43.set_attributes(cella, :text => 45)
#		colonna44.set_attributes(cella, :text => 42)
#		colonna45.set_attributes(cella, :text => 45)
		colonna42.set_attributes(cella, :text => 40)
		colonna43.set_attributes(cella, :text => 41)
		colonna44.set_attributes(cella, :text => 42)
		colonna45.set_attributes(cella, :text => 45)
		colonna46.set_attributes(cella, :text => 48)
		colonna47.set_attributes(cella, :text => 49)
		colonna48.set_attributes(cella, :text => 50)
		vista.append_column(colonna1)
		vista.append_column(colonna2)
		vista.append_column(colonna3)
		vista.append_column(colonna4)
		vista.append_column(colonna5)
		vista.append_column(colonna6)
		vista.append_column(colonna7)
		vista.append_column(colonna8)
		vista.append_column(colonna9)
		vista.append_column(colonna10)
		vista.append_column(colonna11)
		vista.append_column(colonna12)
		vista.append_column(colonna13)
		vista.append_column(colonna14)
		vista.append_column(colonna15)
		vista.append_column(colonna16)
		vista.append_column(colonna17)
		vista.append_column(colonna18)
		vista.append_column(colonna19)
		vista.append_column(colonna20)
		vista.append_column(colonna21)
		vista.append_column(colonna22)
		vista.append_column(colonna23)
		vista.append_column(colonna24)
		vista.append_column(colonna25)
		vista.append_column(colonna26)
		vista.append_column(colonna27)
		vista.append_column(colonna28)
		vista.append_column(colonna29)
		vista.append_column(colonna30)
		vista.append_column(colonna31)
		vista.append_column(colonna32)
		vista.append_column(colonna33)
		vista.append_column(colonna34)
		vista.append_column(colonna35)
		vista.append_column(colonna36)
		vista.append_column(colonna37)
		vista.append_column(colonna38)
		vista.append_column(colonna39)
		vista.append_column(colonna40)
		vista.append_column(colonna41)
		vista.append_column(colonna42)
		vista.append_column(colonna43)
		vista.append_column(colonna44)
		vista.append_column(colonna45)
		vista.append_column(colonna46)
		vista.append_column(colonna47)
		vista.append_column(colonna48)
	mvismovscroll.add(vista)
	boxmov2.pack_start(mvismovscroll, true, true, 0)
	boxmov1.pack_start(visingressi, false, false, 0)
	boxmov1.pack_start(visuscite, false, false, 0)
	boxmov1.pack_start(vispresenti, false, false, 0)
	boxmov1.pack_start(vistutti, false, false, 0)
	boxmov1.pack_start(visricerca, false, false, 5)
	boxmov1.pack_start(visricercaentry, false, false, 0)
	boxmov1.pack_start(labelconto, false, false, 5)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mvismov.destroy
	}
	boxmovv.pack_start(bottchiudi, false, false, 0)

	vista.signal_connect("row-activated") do |view, path, column|
		selcapo = vista.selection
		if selcapo.selected[44] == "0"
			if selcapo.selected[49] == "SI"
				Conferma.conferma(mvismov, "Attenzione: il movimento è stato stampato nel registro vidimato; ricordarsi di correggere il cartaceo a mano previo accordo col funzionario preposto.")
			end
			modificacapo(selcapo)
		elsif selcapo.selected[44] == "1"
			mascsceltamod(selcapo)
		end
	end
	mvismov.show_all
end