# Maschera scelta capi da far uscire

def sceltauscite(finestra, modo)
	muscite = Gtk::Window.new("Capi da far uscire")
	muscite.set_default_size(800, 600)
	muscite.maximize
	boxuscv = Gtk::VBox.new(false, 0)
	boxusc0 = Gtk::HBox.new(false, 0)
	boxusc1 = Gtk::HBox.new(false, 0)
	boxusc2 = Gtk::HBox.new(false, 0)
	boxusc3 = Gtk::HBox.new(false, 0)
	separator = Gtk::HSeparator.new
	boxusc4 = Gtk::HBox.new(false, 0)
	muscitescroll1 = Gtk::ScrolledWindow.new
	muscitescroll2 = Gtk::ScrolledWindow.new
	labelselezione = Gtk::Label.new #("Capi presenti")
	labelselezionati = Gtk::Label.new
	boxuscv.pack_start(boxusc0, false, false, 5)
	boxuscv.pack_start(boxusc3, false, false, 5)
	boxuscv.pack_start(boxusc1, true, true, 0)
	boxuscv.pack_start(boxusc2, false, false, 20)
	boxuscv.pack_start(separator, false, true, 5)
	boxuscv.pack_start(boxusc4, false, false, 10)
	muscite.add(boxuscv)
	@uscenti = 0
	@contatore = 0
	@mod4provv = ""
	labelselezione.set_markup("<b>Capi presenti</b>")
	labelselezionati.set_markup("<b>Capi da far uscire: #{@uscenti}</b>")
	lista = Gtk::ListStore.new(Integer, String, Date, String, String)
	tutti = Gtk::Button.new("Elenca tutti")
	tutti.signal_connect( "clicked" ) {
		lista.clear
		Animals.presenti(@stallaoper.id).each do |m|
			itermov = lista.append
			itermov[0] = m.id.to_i
			itermov[1] = m.marca
			itermov[2] = m.data_nas
			itermov[3] = m.data_nas.strftime("%d/%m/%Y").to_s
			if m.data_ingr != nil
				itermov[4] = m.data_ingr.strftime("%d/%m/%Y").to_s
			else
				itermov[4] = ""
			end
		end
	}

	vista = Gtk::TreeView.new(lista)
	vista.selection.mode = Gtk::SELECTION_SINGLE #BROWSE #SINGLE #MULTIPLE
	cella = Gtk::CellRendererText.new
	colonna1 = Gtk::TreeViewColumn.new("Id", cella)
	colonna2 = Gtk::TreeViewColumn.new("Marca", cella)
	colonna3 = Gtk::TreeViewColumn.new("Data nascita", cella)
	colonna4 = Gtk::TreeViewColumn.new("Data ingresso", cella)
	colonna1.set_attributes(cella, :text => 0)
	colonna2.set_attributes(cella, :text => 1)
	colonna3.set_attributes(cella, :text => 3)
	colonna4.set_attributes(cella, :text => 4)
	vista.append_column(colonna1)
	vista.append_column(colonna2)
	vista.append_column(colonna3)
	vista.append_column(colonna4)
	selezione = vista.selection
	cerca = Gtk::Entry.new
	cerca.max_length=(14)
	bottonecerca = Gtk::Button.new("Cerca")
	bottonecerca.signal_connect("clicked") {
		unless defined?(elenca)
			require 'elenca'
		end
		elenca(lista, cerca.text)
	}
	cerca.signal_connect("activate"){
		unless defined?(elenca)
			require 'elenca'
		end
		elenca(lista, cerca.text)
	}

	listasel = Gtk::ListStore.new(Integer, String, Date, String, String)

	vista.signal_connect("row-activated") do |view, path, column|
		unless defined?(trasferisci)
			require 'trasferisci'
		end
		trasferisci(muscite, selezione, listasel, lista, labelselezionati)
	end

	spostasel = Gtk::Button.new( ">>" )
	spostasel.signal_connect( "clicked" ) {
		require 'trasferisci' unless defined?(trasferisci)
		trasferisci(muscite, selezione, listasel, lista, labelselezionati)
	}

	vista2 = Gtk::TreeView.new(listasel)
	cella2 = Gtk::CellRendererText.new
	vista2.selection.mode = Gtk::SELECTION_SINGLE
	colonnasel1 = Gtk::TreeViewColumn.new("Id", cella2)
	colonnasel2 = Gtk::TreeViewColumn.new("Marca", cella2)
	colonnasel1.set_attributes(cella2, :text => 0)
	colonnasel2.set_attributes(cella2, :text => 1)
	vista2.append_column(colonnasel1)
	vista2.append_column(colonnasel2)
	selezione2 = vista2.selection

	spostasel2 = Gtk::Button.new( "<<" )
	spostasel2.signal_connect( "clicked" ) {
		caposel2 = selezione2.selected
		if caposel2 == nil
			Errore.avviso(muscite, "Nessun capo selezionato.")
		else
			path2 = caposel2.path
			itersel2 = lista.append
			itersel2[0] = caposel2[0]
			itersel2[1] = caposel2[1]
			itersel2[2] = caposel2[2]
			itersel2[3] = caposel2[3]
			itersel2[4] = caposel2[4]
			listasel.remove(listasel.get_iter(path2))
			@contatore-=1
			@uscenti -=1
			labelselezionati.set_markup("<b>Capi da far uscire: #{@uscenti}</b>")
		end
	}

	#Motivo uscita

	labelmotivou = Gtk::Label.new("Motivo uscita:")
	boxusc2.pack_start(labelmotivou, false, false, 5)
	listausc = Gtk::ListStore.new(Integer, String)
	if modo == 0
		Uscites.tutti.each do |usc|
			iteru = listausc.append
			iteru[0] = usc.id
			iteru[1] = usc.descr
		end
	else
		Uscites.provv.each do |usc|
			iteru = listausc.append
			iteru[0] = usc.id
			iteru[1] = usc.descr
		end
	end

	combousc = Gtk::ComboBox.new(listausc)
	renderusc = Gtk::CellRendererText.new
	combousc.pack_start(renderusc,false)
	combousc.set_attributes(renderusc, :text => 1)
	renderusc = Gtk::CellRendererText.new
	renderusc.visible=(false)
	combousc.pack_start(renderusc,false)
	combousc.set_attributes(renderusc, :text => 0)
	boxusc2.pack_start(combousc, false, false, 5)
	bottdatiusc = Gtk::Button.new( "Inserisci movimento di uscita" )
	bottdatiusc.signal_connect( "clicked" ) {
		if @contatore.to_i == 0
				Errore.avviso(muscite, "Nessun capo selezionato.")
		else
			listasel.each do |model,path,iter|
			end
			if combousc.active == -1
				Errore.avviso(muscite, "Seleziona un movimento di uscita.")
			elsif combousc.active_iter[0] == 4
				require 'uscmorte'
				uscmorte(finestra, muscite, listasel, combousc)
			elsif combousc.active_iter[0] == 9
				require 'uscmacellazione'
				uscmacellazione(finestra, muscite, listasel, combousc, modo)
			elsif combousc.active_iter[0] == 6
				require 'uscfurto'
				uscfurto(finestra, muscite, listasel, combousc)
			elsif combousc.active_iter[0] == 16
				require 'uscestero'
				uscestero(finestra, muscite, listasel, combousc, modo)
			else
				require 'uscgenerica'
				uscgenerica(finestra, muscite, listasel, combousc, modo)
			end
		end
	}
	muscitescroll1.add(vista)
	muscitescroll2.add(vista2)
	boxusc0.pack_start(tutti, false, false, 50)
	boxusc0.pack_start(cerca, false, false, 5)
	boxusc0.pack_start(bottonecerca, false, false, 5)
	boxusc3.pack_start(labelselezione, true, true, 5)
	boxusc3.pack_start(labelselezionati, true, true, 5)
	boxusc1.pack_start(muscitescroll1, true, true, 5)
	boxusc1.pack_start(spostasel, false, false, 0)
	boxusc1.pack_start(spostasel2, false, false, 0)
	boxusc1.pack_start(muscitescroll2, true, true, 5)
	boxusc2.pack_start(bottdatiusc, false, false, 0)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.set_size_request(100, 30)
	bottchiudi.signal_connect("clicked") {
		muscite.destroy
	}
	boxusc4.pack_start(bottchiudi, true, false, 0)

	muscite.show_all
	if Mod4temps.conta(@stallaoper.id) > 0
		avviso = Gtk::MessageDialog.new(finestra, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Sono presenti dei modelli 4 provvisori; li mostro?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			require 'vismod4provv'
			vismod4provv(Mod4temps.cerca(@stallaoper.id), tutti, muscite, selezione, listasel, lista, labelselezionati, vista, combousc)
		end
	end
end
