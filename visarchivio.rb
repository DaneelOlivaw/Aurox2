# Visualizza archivio

def visarchivio
	mvisarc = Gtk::Window.new("Vista archivio")
	#mvisarc.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mvisarc.set_default_size(800, 600)
	mvisarc.maximize
	mvisarcscroll = Gtk::ScrolledWindow.new #(hadjustment = nil, vadjustment = nil)
	boxarcv = Gtk::VBox.new(false, 0)
	boxarc1 = Gtk::HBox.new(false, 0)
	boxarc2 = Gtk::HBox.new(false, 0)
	boxarcv.pack_start(boxarc1, false, false, 5)
	boxarcv.pack_start(boxarc2, true, true, 5)
	labelconto = Gtk::Label.new("Capi trovati: 0")
	mvisarc.add(boxarcv)

	def riempimento(selarc, lista, labelconto)
		selarc.each do |m|
#			puts m.inspect
#			puts m.relaz.ragsoc.ragsoc
#			puts m.razza
			iterarc = lista.append
			iterarc[0] = m.id.to_i
			iterarc[1] = m.progreg
			iterarc[2] = m.relaz.ragsoc.ragsoc
			iterarc[3] = m.marca
			iterarc[4] = m.specie
			iterarc[5] = m.razza
			iterarc[6] = m.data_nas.strftime("%d/%m/%Y")
			iterarc[7] = m.stalla_nas
			iterarc[8] = m.sesso
			iterarc[9] = m.nazorig
			iterarc[10] = m.naznasprimimp
			if m.data_applm !=nil
				iterarc[11] = m.data_applm.strftime("%d/%m/%Y")
			else
				iterarc[11] = ""
			end
			iterarc[12] = m.ilg
			iterarc[13] = m.marca_prec
			iterarc[14] = m.marca_madre
			iterarc[15] = m.marca_padre
			iterarc[16] = m.donatrice
			iterarc[17] = m.codingresso
			if m.data_ingr != nil
				iterarc[18] = m.data_ingr.strftime("%d/%m/%Y")
			else
				iterarc[18] = ""
			end
#			if m.tipo == "I"
#				if m.allevingr_id != nil
					iterarc[19] = m.allevingr_cod317
					iterarc[20] = m.allevingr_ragsoc
					iterarc[21] = m.allevingr_idfisc
#					iterarc[46] = m.allevingr.id.to_s
#				else
#					iterarc[19] = ""
#					iterarc[20] = ""
#					iterarc[21] = ""
##					iterarc[46] = ""
#				end
#			elsif m.tipo == "U"
#				if m.allevusc_id != nil
					iterarc[30] = m.allevusc_cod317
					iterarc[32] = m.allevusc_ragsoc
					iterarc[33] = m.allevusc_idfisc
#					iterarc[47] = m.allevusc_id.to_s
#				else
#					iterarc[30] = ""
#					iterarc[32] = ""
#					iterarc[33] = ""
##					iterarc[47] = ""
#				end
#			end
#			if m.nazprov_id.to_s != ""
				iterarc[22] = m.nazprov
#			else
#				iterarc[22] = ""
#			end
			iterarc[23] = m.certsaningr
			iterarc[24] = m.rifloc
			if m.data_certsaningr != nil
				iterarc[25] = m.data_certsaningr.strftime("%d/%m/%Y")
			else
				iterarc[25] = ""
			end
			iterarc[26] = m.mod4ingr
			if m.data_mod4ingr != nil
				iterarc[27] = m.data_mod4ingr.strftime("%d/%m/%Y")
			else
				iterarc[27] = ""
			end
#			if m.uscite_id != nil
				iterarc[28] = m.coduscita
#			else
#				iterarc[28] = ""
#			end
				if m.data_uscita != nil
				iterarc[29] = m.data_uscita.strftime("%d/%m/%Y")
			else
				iterarc[29] = ""
			end
#			if m.nazdest_id.to_s != ""
				iterarc[31] = m.nazdest
#			else
#				iterarc[31] = ""
#			end
#			if m.macelli_id != nil
				iterarc[34] = m.macello_ragsoc
				iterarc[35] = m.macello_idfisc
				iterarc[36] = m.macello_bollo
				iterarc[37] = m.macello_regione
#			else
#				iterarc[34] = ""
#				iterarc[35] = ""
#				iterarc[36] = ""
#				iterarc[37] = ""
#			end
			iterarc[38] = m.certsanusc
			if m.data_certsanusc != nil
				iterarc[39] = m.data_certsanusc.strftime("%d/%m/%Y")
			else
				iterarc[39] = ""
			end
			iterarc[40] = m.trasp
			iterarc[41] = m.marcasost
			iterarc[42] = m.ditta_racc
			iterarc[43] = m.clg
#			iterarc[44] = m.uscito.to_s
#			if m.registro == true
#				iterarc[45] = "SI"
#			else
#				iterarc[45] = "NO"
#			end
			iterarc[46] = m.mod4usc
			if m.data_mod4usc != nil
				iterarc[47] = m.data_mod4usc.strftime("%d/%m/%Y")
			else
				iterarc[47] = ""
			end
#			iterarc[45] = m.registro.to_s
#			puts iterarc[45]
		end
	labelconto.text = ("Capi trovati: #{selarc.length}")
	end

	vistutti = Gtk::Button.new( "Visualizza capi" )
	visricerca = Gtk::Button.new( "Cerca capo" )
	visricercaentry = Gtk::Entry.new
	lista = Gtk::ListStore.new(Integer, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String)
	vista = Gtk::TreeView.new(lista)
	vista.selection.mode = Gtk::SELECTION_SINGLE #BROWSE #SINGLE #MULTIPLE
#	vista.show_expanders = (true)
	vista.rules_hint = true
#	vista.set_enable_grid_lines(true)
	vistutti.signal_connect("clicked") {
		lista.clear
		selarc = Archives.find(:all, :conditions => ["relaz_id= ?", "#{@stallaoper.id}"])
		riempimento(selarc, lista, labelconto)
	}
	visricerca.signal_connect("clicked") {
		lista.clear
		selarc = Archives.find(:all, :conditions => ["relaz_id= ? and marca LIKE ?", "#{@stallaoper.id}", "%#{visricercaentry.text}%"])
		riempimento(selarc, lista, labelconto)
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
		colonna45 = Gtk::TreeViewColumn.new("Registro", cella)
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
	mvisarcscroll.add(vista)
	boxarc2.pack_start(mvisarcscroll, true, true, 0)
	boxarc1.pack_start(vistutti, false, false, 0)
	boxarc1.pack_start(visricerca, false, false, 5)
	boxarc1.pack_start(visricercaentry, false, false, 0)
	boxarc1.pack_start(labelconto, false, false, 5)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mvisarc.destroy
	}
	boxarcv.pack_start(bottchiudi, false, false, 0)
	mvisarc.show_all
end
