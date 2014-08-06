def modpartitauscita
	modpartusc = Gtk::Window.new("Modifica dati partita in uscita")
	modpartusc.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	modpartusc.set_default_size(600, 500)
	boxgen = Gtk::VBox.new(false, 0)
	boxricerca = Gtk::HBox.new(false, 0)
	boxrisultato = Gtk::HBox.new(false, 0)
	boxgrande = Gtk::HBox.new(false, 0)
	boxmodcv1 = Gtk::HBox.new(false, 0)
	boxmodcv11 = Gtk::VBox.new(true, 0)
	boxmodcv12 = Gtk::VBox.new(true, 0)
	boxmodc1 = Gtk::HBox.new(false, 0)
	boxmodc2 = Gtk::HBox.new(false, 0)
	boxmodc3 = Gtk::HBox.new(false, 0)
	boxmodc4 = Gtk::HBox.new(false, 0)
	boxmodc5 = Gtk::HBox.new(false, 0)
	boxmodc6 = Gtk::HBox.new(false, 0)
	boxmodc7 = Gtk::HBox.new(false, 0)
	boxmodc8 = Gtk::HBox.new(false, 0)
	boxmodc9 = Gtk::HBox.new(false, 0)
	boxmodc10 = Gtk::HBox.new(false, 0)
	boxmodc11 = Gtk::HBox.new(false, 0)
	boxmodc12 = Gtk::HBox.new(false, 0)
	boxmodc13 = Gtk::HBox.new(false, 0)
	boxmodc14 = Gtk::HBox.new(false, 0)
	boxmodc15 = Gtk::HBox.new(false, 0)
	boxmodc16 = Gtk::HBox.new(false, 0)
	boxmodc17 = Gtk::HBox.new(false, 0)
	boxmodc18 = Gtk::HBox.new(false, 0)
	boxmodc19 = Gtk::HBox.new(false, 0)
	boxmodc20 = Gtk::HBox.new(false, 0)
	boxmodc100 = Gtk::HBox.new(true, 0)
	boxmodcv11.pack_start(boxmodc1, false, false, 0)
	boxmodcv12.pack_start(boxmodc2, false, false, 0)
	boxmodcv11.pack_start(boxmodc3, false, false, 0)
	boxmodcv12.pack_start(boxmodc4, false, false, 0)
	boxmodcv11.pack_start(boxmodc5, false, false, 0)
	boxmodcv12.pack_start(boxmodc6, false, false, 0)
	boxmodcv11.pack_start(boxmodc7, false, false, 0)
	boxmodcv12.pack_start(boxmodc8, false, false, 0)
	boxmodcv11.pack_start(boxmodc9, false, false, 0)
	boxmodcv12.pack_start(boxmodc10, false, false, 0)
	boxmodcv11.pack_start(boxmodc11, false, false, 0)
	boxmodcv12.pack_start(boxmodc12, false, false, 0)
	boxmodcv11.pack_start(boxmodc13, false, false, 0)
	boxmodcv12.pack_start(boxmodc14, false, false, 0)
	boxmodcv11.pack_start(boxmodc15, false, false, 0)
	boxmodcv12.pack_start(boxmodc16, false, false, 0)
	boxmodcv11.pack_start(boxmodc17, false, false, 0)
	boxmodcv12.pack_start(boxmodc18, false, false, 0)
	boxmodcv11.pack_start(boxmodc19, false, false, 0)
	boxmodcv12.pack_start(boxmodc20, false, false, 0)
	boxmodcv1.pack_start(boxmodcv11, false, false, 0)
	boxmodcv1.pack_start(boxmodcv12, false, false, 0)
	boxgrande.pack_start(boxmodcv1, true, true)
	boxgen.pack_start(boxricerca, false, false, 5)
	boxgen.pack_start(boxrisultato, false, false, 5)
	boxgen.pack_start(boxgrande, true, true)
	boxgen.pack_start(boxmodc100, false, false)
	modpartusc.add(boxgen)

	@arridcapi = []
	@datauscingl = ""

	docum1 = Gtk::RadioButton.new("Modello 4")
	boxricerca.pack_start(docum1, false, false, 5)
	docum2 = Gtk::RadioButton.new(docum1, "Certificato sanitario")
	boxricerca.pack_start(docum2, false, false, 5)
	tipodocumento = "mod4usc"
	docum1.active=(true)
	docum1.signal_connect("toggled") {
		if docum1.active?
			tipodocumento="mod4usc"
		end
	}
	docum2.signal_connect("toggled") {
		if docum2.active?
			tipodocumento="certsanusc"
		end
	}

	cercapartita = Gtk::Entry.new
	cercapartita.max_length=(14)
	boxricerca.pack_start(cercapartita, false, false, 10)
	vispartita = Gtk::Button.new( "Cerca" )
	boxricerca.pack_start(vispartita, false, false, 5)

	labeldocumento = Gtk::Label.new("Documento:")
	boxrisultato.pack_start(labeldocumento, false, false, 5)
	documento = Gtk::Entry.new
	documento.width_chars=(21)
	documento.editable = false
	boxrisultato.pack_start(documento, false, false, 5)
	
	labeltotcapi = Gtk::Label.new("Totale capi:")
	boxrisultato.pack_start(labeltotcapi, false, false, 5)

	vedicapi = Gtk::Button.new("Vedi lista capi")
	vedicapi.signal_connect("clicked") {
		if @arridcapi.length == 0
			Errore.avviso(modpartusc, "Devi selezionare un documento.")
		else
			viscapi = Gtk::Window.new("Capi del documento #{documento.text}")
			viscapi.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
			viscapi.set_default_size(400, 400)
			viscapiscroll = Gtk::ScrolledWindow.new
			boxmovv = Gtk::VBox.new(false, 0)
			boxmov1 = Gtk::HBox.new(false, 0)
			boxmov2 = Gtk::HBox.new(false, 0)
			boxmovv.pack_start(boxmov1, false, false, 5)
			boxmovv.pack_start(boxmov2, true, true, 5)
			viscapi.add(boxmovv)
			listacapi = Gtk::ListStore.new(String)
			@arridcapi.each do |m|
				iter = listacapi.append
				iter[0] = m[1]
			end
			vistacapi = Gtk::TreeView.new(listacapi)
			cella = Gtk::CellRendererText.new
			colonna1 = Gtk::TreeViewColumn.new("Marca", cella)
			colonna1.set_attributes(cella, :text => 0)
			vistacapi.append_column(colonna1)
			viscapiscroll.add(vistacapi)
			boxmov2.pack_start(viscapiscroll, true, true, 0)

			bottchiudi = Gtk::Button.new( "Chiudi" )
			bottchiudi.signal_connect("clicked") {
				viscapi.destroy
			}
			boxmovv.pack_start(bottchiudi, false, false, 0)
			viscapi.show_all
		end
	}
	boxrisultato.pack_start(vedicapi, false, false, 5)

	#Modifica motivo uscita

	labelmovusc = Gtk::Label.new("Motivo uscita:")
	listamovusc = Gtk::ListStore.new(Integer, String)
	selmovusc = Uscites.find(:all)
	selmovusc.each do |u|
		iter1 = listamovusc.append
		iter1[0] = u.id
		iter1[1] = u.descr
	end

	combomovusc = Gtk::ComboBox.new(listamovusc)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomovusc.pack_start(renderer1,false)
	combomovusc.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combomovusc.pack_start(renderer1,false)
	combomovusc.set_attributes(renderer1, :text => 1)
	boxmodc1.pack_end(labelmovusc, false, false, 5)
	boxmodc2.pack_start(combomovusc.popdown, false, false, 0)

	#Modifica data uscita

	labeldatausc = Gtk::Label.new("Data di uscita (GGMMAA):")
	boxmodc3.pack_end(labeldatausc, false, false, 5)
	datausc = Gtk::Entry.new()
	datausc.max_length=(6)
	boxmodc4.pack_start(datausc, false , false, 0)

	#Nazione di destinazione

	labelnazdest = Gtk::Label.new("Nazione di destinazione:")
	boxmodc5.pack_end(labelnazdest, false, false, 5)
	listanazdest = Gtk::ListStore.new(Integer, String, String)
	listanazdest.clear
	selnazdest = Nazdests.find(:all, :order => "nome")
	selnazdest.each do |n|
		iter1 = listanazdest.append
		iter1[0] = n.id
		iter1[1] = n.nome
		iter1[2] = n.codice
	end
	combonazdest = Gtk::ComboBox.new(listanazdest)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazdest.pack_start(renderer1,false)
	combonazdest.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combonazdest.pack_start(renderer1,false)
	combonazdest.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazdest.pack_start(renderer1,false)
	combonazdest.set_attributes(renderer1, :text => 2)
	boxmodc6.pack_start(combonazdest.popdown, false, false, 0)

	#Certificato sanitario

	labelcertsan = Gtk::Label.new("Certificato sanitario:")
	boxmodc7.pack_end(labelcertsan, false, false, 5)
	certsan = Gtk::Entry.new
	certsan.max_length=(21)
	certsan.width_chars=(21)
	boxmodc8.pack_start(certsan, false, false, 5)

	#Data certificato sanitario

	labeldatacertsan = Gtk::Label.new("Data certificato sanitario (GGMMAA):")
	boxmodc9.pack_end(labeldatacertsan, false, false, 5)
	datacertsan = Gtk::Entry.new
	datacertsan.max_length=(6)
	boxmodc10.pack_start(datacertsan, false , false, 0)

	#Allevamento destinazione

	labelalldest = Gtk::Label.new("Allevamento di destinazione:")
	boxmodc11.pack_end(labelalldest, false, false, 5)
	listaalldest = Gtk::ListStore.new(Integer, String, String, String)
	listaalldest.clear
	selalldest = Allevuscs.find(:all, :order => "ragsoc")
	selalldest.each do |a|
		iter1 = listaalldest.append
		iter1[0] = a.id
		iter1[1] = a.ragsoc
		iter1[2] = a.idfisc
		iter1[3] = a.cod317
	end
	comboalldest = Gtk::ComboBox.new(listaalldest)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboalldest.pack_start(renderer1,false)
	comboalldest.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	comboalldest.pack_start(renderer1,false)
	comboalldest.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboalldest.pack_start(renderer1,false)
	comboalldest.set_attributes(renderer1, :text => 2)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboalldest.pack_start(renderer1,false)
	comboalldest.set_attributes(renderer1, :text => 3)
	boxmodc12.pack_start(comboalldest.popdown, false, false, 5)

	#Macello destinazione

	labelmacdest = Gtk::Label.new("Macello di destinazione:")
	boxmodc13.pack_end(labelmacdest, false, false, 5)
	listamacdest = Gtk::ListStore.new(Integer, String, String, String, String)
	listamacdest.clear
	selmacdest = Macellis.tutti
	selmacdest.each do |a|
		iter1 = listamacdest.append
		iter1[0] = a.id
		iter1[1] = a.nomemac
		iter1[2] = a.ifmac
		iter1[3] = a.bollomac
		iter1[4] = a.region.regione
	end
	combomacdest = Gtk::ComboBox.new(listamacdest)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomacdest.pack_start(renderer1,false)
	combomacdest.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combomacdest.pack_start(renderer1,false)
	combomacdest.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomacdest.pack_start(renderer1,false)
	combomacdest.set_attributes(renderer1, :text => 2)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomacdest.pack_start(renderer1,false)
	combomacdest.set_attributes(renderer1, :text => 3)
	boxmodc14.pack_start(combomacdest.popdown, false, false, 5)

	labeltrasp = Gtk::Label.new("Trasportatore:")
	boxmodc15.pack_end(labeltrasp, false, false, 5)
	listatrasp = Gtk::ListStore.new(Integer, String)
	listatrasp.clear
	listatrasp.prepend()
	seltrasp = Trasportatoris.find(:all, :order => "nometrasp")
	seltrasp.each do |t|
		iter1 = listatrasp.append
		iter1[0] = t.id
		iter1[1] = t.nometrasp
	end
	combotrasp = Gtk::ComboBox.new(listatrasp)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combotrasp.pack_start(renderer1,false)
	combotrasp.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combotrasp.pack_start(renderer1,false)
	combotrasp.set_attributes(renderer1, :text => 1)
	boxmodc16.pack_start(combotrasp.popdown, false, false, 5)

	#Modello 4

	labelmod4 = Gtk::Label.new("Modello 4:")
	boxmodc17.pack_end(labelmod4, false, false, 5)
	mod4 = Gtk::Entry.new()
	boxmodc18.pack_start(mod4, false, false, 5)

	#Data modello 4

	labeldatamod4 = Gtk::Label.new("Data modello 4 (GGMMAA):")
	boxmodc19.pack_end(labeldatamod4, false, false, 5)
	datamod4 = Gtk::Entry.new()
	datamod4.max_length=(6)
	boxmodc20.pack_start(datamod4, false , false, 0)

	vispartita.signal_connect("clicked") {
		if cercapartita.text == ""
			Errore.avviso(modpartusc, "Devi indicare un documento da ricercare.")
		else
			selmov = Animals.find(:all, :select => "#{tipodocumento}", :from => "animals", :conditions => ["relaz_id= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "%#{cercapartita.text}%"])
			if selmov.length == 0
				Conferma.conferma(modpartusc, "Non ci sono movimenti disponibili.")
			else
				arrdoc = []
				selmov.each {|x| arrdoc << x["#{tipodocumento}"]}
				if arrdoc.uniq.length == 1
					@arridcapi = []
					selcapi = Animals.trovapartita(@stallaoper.id, tipodocumento, arrdoc[0]).each {|x| @arridcapi << [x.id, x.marca]}
					@datauscingl = selcapi[0].uscita
					documento.text = arrdoc[0]
					combonazdest.set_active(0)
					contanazdest = -1
					if selcapi[0].nazdest_id.to_s != ""
						while combonazdest.active_iter[0] != selcapi[0].nazdest_id
							contanazdest+=1
							combonazdest.set_active(contanazdest)
						end
					else
						combonazdest.set_active(-1)
					end

					if selcapi[0].allevusc_id.to_s != ""
						comboalldest.set_active(0)
						contaalldest = -1
						while comboalldest.active_iter[0] != selcapi[0].allevusc_id.to_i
							contaalldest+=1
							comboalldest.set_active(contaalldest)
						end
						else
						comboalldest.set_active(-1)
					end

					if selcapi[0].macelli_id.to_s != ""
						combomacdest.set_active(0)
						contamacdest = -1
						while combomacdest.active_iter[0] != selcapi[0].macelli_id.to_i
							contamacdest+=1
							combomacdest.set_active(contamacdest)
						end
						else
						combomacdest.set_active(-1)
					end

					combomovusc.set_active(0)
					contamovusc = -1
					while combomovusc.active_iter[0].to_i != selcapi[0].uscite_id.to_i
						contamovusc+=1
						combomovusc.set_active(contamovusc)
					end
					datausc.text = ("#{selcapi[0].uscita.strftime("%d%m%y")}")
					certsan.text = ("#{selcapi[0].certsanusc}")
					if selcapi[0].data_certsanusc != nil
						datacertsan.text = ("#{selcapi[0].data_certsanusc.strftime("%d%m%y")}")
					end
					mod4.text = ("#{selcapi[0].mod4usc}")
					if selcapi[0].data_mod4usc != nil
						datamod4.text = ("#{selcapi[0].data_mod4usc.strftime("%d%m%y")}")
					end
					labeltotcapi.text = ("Capi della partita: #{selcapi.length}")
				else
					require 'visdocumuscita'
					visdocumuscita(arrdoc.uniq, tipodocumento, documento, combonazdest, comboalldest, combomacdest, combotrasp, combomovusc, datausc, certsan, datacertsan, mod4, datamod4, labeltotcapi)
				end
			end
		end
	}

	#Bottone di inserimento

	bottmodpartusc = Gtk::Button.new( "Salva dati" )
	bottmodpartusc.signal_connect("clicked") {
		errore = nil
		begin
			datauscingl = datausc.text[4,2] + datausc.text[2,2] + datausc.text[0,2]
			datauscingl = Time.parse("#{datauscingl}").strftime("%Y")[0,2] + datauscingl
			Time.parse("#{datauscingl}")
			if combomovusc.active == -1
				Errore.avviso(modcapousc, "Mancano dei dati obbligatori.")
				errore = 1
			elsif datausc.text.to_i == 0
				Errore.avviso(modcapousc, "Data di uscita errata.")
				errore = 1
			end
		rescue Exception => errore
			Errore.avviso(modcapousc, "Errore generico")
			errore = 1
		end
		if errore == nil
			if datamod4.text != ""
				datamod4ingl = datamod4.text[4,2] + datamod4.text[2,2] + datamod4.text[0,2]
				datamod4ingl = Time.parse("#{datamod4ingl}").strftime("%Y")[0,2] + datamod4ingl
			else
				datamod4ingl = nil
			end
			if datacertsan.text != ""
				datacertsaningl = datacertsan.text[4,2] + datacertsan.text[2,2] + datacertsan.text[0,2]
				datacertsaningl = Time.parse("#{datacertsaningl}").strftime("%Y")[0,2] + datacertsaningl
			else
				datacertsaningl = nil
			end
			if combomacdest.active == -1
				macdest = ""
			else
				macdest = combomacdest.active_iter[0]
			end
			if comboalldest.active == -1
				alldest = ""
			else
				alldest = comboalldest.active_iter[0]
			end
			if combonazdest.active == -1
				nazdest = ""
			else
				nazdest = combonazdest.active_iter[0]
			end
			@arridcapi.each do |s|
				Animals.update(s[0], {:uscite_id => "#{combomovusc.active_iter[0]}", :uscita => "#{datauscingl.to_i}", :nazdest_id => "#{nazdest}", :certsanusc => "#{certsan.text.upcase}", :data_certsanusc => "#{datacertsaningl.to_i}", :allevusc_id => "#{alldest}", :macelli_id => "#{macdest}", :mod4usc => "#{mod4.text.upcase}", :data_mod4usc => "#{datamod4ingl.to_i}"})
			end
			Conferma.conferma(modpartusc, "Movimento modificato.")
			@arridcapi = []
			documento.text = ""
			@datauscingl = ""
			labeltotcapi.text = ("Capi della partita:")
			combomovusc.active = -1
			datausc.text = ""
			combonazdest.active = -1
			certsan.text = ""
			datacertsan.text = ""
			comboalldest.active = -1
			combomacdest.active = -1
			mod4.text = ""
			datamod4.text = ""
		end
	}
	boxmodc100.pack_start(bottmodpartusc, false, false, 5)

# Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		modpartusc.destroy
	}
	boxmodc100.pack_start(bottchiudi, false, false, 5)
	modpartusc.show_all
end
