def modpartitaingresso
	modpartingr = Gtk::Window.new("Modifica dati partita in ingresso")
	modpartingr.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	modpartingr.set_default_size(600, 500)
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
	boxmodcv1.pack_start(boxmodcv11, false, false, 0)
	boxmodcv1.pack_start(boxmodcv12, false, false, 0)
	boxgrande.pack_start(boxmodcv1, true, true)
	boxgen.pack_start(boxricerca, false, false, 5)
	boxgen.pack_start(boxrisultato, false, false, 5)
	boxgen.pack_start(boxgrande, true, true)
	boxgen.pack_start(boxmodc100, false, false)
	modpartingr.add(boxgen)

	@arridcapi = []
	@dataingringl = ""

	docum1 = Gtk::RadioButton.new("Modello 4")
	boxricerca.pack_start(docum1, false, false, 5)
	docum2 = Gtk::RadioButton.new(docum1, "Certificato sanitario")
	boxricerca.pack_start(docum2, false, false, 5)
	docum3 = Gtk::RadioButton.new(docum1, "Riferimento locale")
	boxricerca.pack_start(docum3, false, false, 5)
	tipodocumento = "mod4ingr"
	docum1.active=(true)
	docum1.signal_connect("toggled") {
		if docum1.active?
			tipodocumento="mod4ingr"
		end
	}
	docum2.signal_connect("toggled") {
		if docum2.active?
			tipodocumento="certsaningr"
		end
	}
	docum3.signal_connect("toggled") {
		if docum3.active?
			tipodocumento="rifloc"
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
			Errore.avviso(modpartingr, "Devi selezionare un documento.")
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

	#Modifica motivo ingresso

	labelmovingr = Gtk::Label.new("Motivo ingresso:")
	listamovingr = Gtk::ListStore.new(Integer, String)
	selmovoingr = Ingressos.find(:all)
	selmovoingr.each do |u|
		iter1 = listamovingr.append
		iter1[0] = u.id.to_i
		iter1[1] = u.descr
	end

	combomovingr = Gtk::ComboBox.new(listamovingr)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combomovingr.pack_start(renderer1,false)
	combomovingr.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combomovingr.pack_start(renderer1,false)
	combomovingr.set_attributes(renderer1, :text => 1)
	boxmodc1.pack_end(labelmovingr, false, false, 5)
	boxmodc2.pack_start(combomovingr.popdown, false, false, 0)

	#Modifica data ingresso

	labeldataingr = Gtk::Label.new("Data di ingresso (GGMMAA):")
	boxmodc3.pack_end(labeldataingr, false, false, 5)
	dataingr = Gtk::Entry.new()
	dataingr.max_length=(6)
	boxmodc4.pack_start(dataingr, false , false, 0)

	#Nazione di provenienza

	labelnazprov = Gtk::Label.new("Nazione di provenienza:")
	boxmodc5.pack_end(labelnazprov, false, false, 5)
	listanazprov = Gtk::ListStore.new(Integer, String, String)
	listanazprov.clear
	selnazprov = Nazprovs.find(:all, :order => "nome")
	selnazprov.each do |n|
		iter1 = listanazprov.append
		iter1[0] = n.id
		iter1[1] = n.nome
		iter1[2] = n.codice
	end
	combonazprov = Gtk::ComboBox.new(listanazprov)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazprov.pack_start(renderer1,false)
	combonazprov.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combonazprov.pack_start(renderer1,false)
	combonazprov.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	combonazprov.pack_start(renderer1,false)
	combonazprov.set_attributes(renderer1, :text => 2)
	boxmodc6.pack_start(combonazprov.popdown, false, false, 0)

	#Certificato sanitario

	labelcertsan = Gtk::Label.new("Certificato sanitario:")
	boxmodc7.pack_end(labelcertsan, false, false, 5)
	certsan = Gtk::Entry.new()
	certsan.max_length=(21)
	certsan.width_chars=(21)
	boxmodc8.pack_start(certsan, false, false, 5)

	#Riferimento locale

	labelrifloc = Gtk::Label.new("Riferimento locale:")
	boxmodc9.pack_end(labelrifloc, false, false, 5)
	rifloc = Gtk::Entry.new()
	rifloc.max_length=(6)
	boxmodc10.pack_start(rifloc, false , false, 0)

	#Allevamento provenienza

	labelallprov = Gtk::Label.new("Allevamento di provenienza:")
	boxmodc11.pack_end(labelallprov, false, false, 5)
	listaallprov = Gtk::ListStore.new(Integer, String, String, String)
	listaallprov.clear
	selallprov = Allevingrs.find(:all, :order => "ragsoc")
	selallprov.each do |a|
		iter1 = listaallprov.append
		iter1[0] = a.id
		iter1[1] = a.ragsoc
		iter1[2] = a.idfisc
		iter1[3] = a.cod317
	end
	comboallprov = Gtk::ComboBox.new(listaallprov)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboallprov.pack_start(renderer1,false)
	comboallprov.set_attributes(renderer1, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	comboallprov.pack_start(renderer1,false)
	comboallprov.set_attributes(renderer1, :text => 1)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboallprov.pack_start(renderer1,false)
	comboallprov.set_attributes(renderer1, :text => 2)
	renderer1 = Gtk::CellRendererText.new
	renderer1.visible=(false)
	comboallprov.pack_start(renderer1,false)
	comboallprov.set_attributes(renderer1, :text => 3)
	boxmodc12.pack_start(comboallprov.popdown, false, false, 5)

	#Modello 4

	labelmod4 = Gtk::Label.new("Modello 4:")
	boxmodc13.pack_end(labelmod4, false, false, 5)
	mod4 = Gtk::Entry.new()
	boxmodc14.pack_start(mod4, false, false, 5)

	#Data modello 4

	labeldatamod4 = Gtk::Label.new("Data modello 4 (GGMMAA):")
	boxmodc15.pack_end(labeldatamod4, false, false, 5)
	datamod4 = Gtk::Entry.new()
	datamod4.max_length=(6)
	boxmodc16.pack_start(datamod4, false , false, 0)

	vispartita.signal_connect("clicked") {
		if cercapartita.text == ""
			Errore.avviso(modpartingr, "Devi indicare un documento da ricercare.")
		else
				selmov = Animals.find(:all, :select => "#{tipodocumento}", :from => "animals", :conditions => ["relaz_id= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "%#{cercapartita.text}%"])
			if selmov.length == 0
				Conferma.conferma(modpartingr, "Non ci sono movimenti disponibili.")
			else
				arrdoc = []
				selmov.each {|x| arrdoc << x["#{tipodocumento}"]}
				if arrdoc.uniq.length == 1
					@arridcapi = []
					selcapi = Animals.trovapartita(@stallaoper.id, tipodocumento, arrdoc[0]).each {|x| @arridcapi << [x.id, x.marca]}
					selcapi.each {|x| @arridcapi << [x.id, x.marca]}
					@dataingringl = selcapi[0].data_ingr
					documento.text = arrdoc[0]
					combonazprov.set_active(0)
					contanazprov = -1
					if selcapi[0].nazprov_id.to_s != ""
						while combonazprov.active_iter[0] != selcapi[0].nazprov_id
							contanazprov+=1
							combonazprov.set_active(contanazprov)
						end
					else
						combonazprov.set_active(-1)
					end
					if selcapi[0].allevingr_id.to_s != ""
						comboallprov.set_active(0)
						contaallprov = -1
						while comboallprov.active_iter[0] != selcapi[0].allevingr_id.to_i
							contaallprov+=1
							comboallprov.set_active(contaallprov)
						end
						else
						comboallprov.set_active(-1)
					end
					combomovingr.set_active(0)
					contamovingr = -1
					while combomovingr.active_iter[0].to_i != selcapi[0].ingresso_id.to_i
						contamovingr+=1
						combomovingr.set_active(contamovingr)
					end
					dataingr.text = ("#{selcapi[0].data_ingr.strftime("%d%m%y")}")
					certsan.text = ("#{selcapi[0].certsaningr}")
					rifloc.text = ("#{selcapi[0].rifloc}")
					mod4.text = ("#{selcapi[0].mod4ingr}")
					if selcapi[0].data_mod4ingr != nil
						datamod4.text = ("#{selcapi[0].data_mod4ingr.strftime("%d%m%y")}")
					end
					labeltotcapi.text = ("Capi della partita: #{selcapi.length}")
				else
					require 'visdocumingresso'
					visdocumingresso(arrdoc.uniq, tipodocumento, documento, combonazprov, comboallprov, combomovingr, dataingr, certsan, rifloc, mod4, datamod4, labeltotcapi)
				end
			end
		end
	}

	#Bottone di inserimento

	bottmodpartingr = Gtk::Button.new( "Salva dati" )
	bottmodpartingr.signal_connect("clicked") {
		errore = nil
		begin
			dataingringl = dataingr.text[4,2] + dataingr.text[2,2] + dataingr.text[0,2]
			dataingringl = Time.parse("#{dataingringl}").strftime("%Y")[0,2] + dataingringl
			Time.parse("#{dataingringl}")
			if combomovingr.active == -1
				Errore.avviso(modpartingr, "Mancano dei dati obbligatori.")
				errore = 1
			elsif dataingr.text.to_i == 0
				Errore.avviso(modpartingr, "Data di uscita errata.")
				errore = 1
			end
		rescue Exception => errore
			Errore.avviso(modpartingr, "Errore generico")
			errore = 1
		end
		if errore == nil
			if datamod4.text != ""
				datamod4ingl = datamod4.text[4,2] + datamod4.text[2,2] + datamod4.text[0,2]
				datamod4ingl = Time.parse("#{datamod4ingl}").strftime("%Y")[0,2] + datamod4ingl
			else
				datamod4ingl = nil
			end
			if comboallprov.active == -1
				allprov = ""
			else
				allprov = comboallprov.active_iter[0]
			end
			if combonazprov.active == -1
				nazprov = ""
			else
				nazprov = combonazprov.active_iter[0]
			end
			@arridcapi.each do |s|
				Animals.update(s[0], {:ingresso_id => "#{combomovingr.active_iter[0]}", :data_ingr => "#{dataingringl.to_i}", :nazprov_id => "#{nazprov}", :certsaningr => "#{certsan.text.upcase}", :rifloc => "#{rifloc.text.upcase}", :allevingr_id => "#{allprov}", :mod4ingr => "#{mod4.text.upcase}", :data_mod4ingr => "#{datamod4ingl.to_i}"})
			end
			Conferma.conferma(modpartingr, "Movimento modificato.")
			@arridcapi = []
			documento.text = ""
			@dataingringl = ""
			labeltotcapi.text = ("Capi della partita:")
			combomovingr.active = -1
			dataingr.text = ""
			combonazprov.active = -1
			certsan.text = ""
			rifloc.text = ""
			comboallprov.active = -1
			mod4.text = ""
			datamod4.text = ""
		end
	}
	boxmodc100.pack_start(bottmodpartingr, false, false, 5)

# Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		modpartingr.destroy
	}
	boxmodc100.pack_start(bottchiudi, false, false, 5)
	modpartingr.show_all
end
