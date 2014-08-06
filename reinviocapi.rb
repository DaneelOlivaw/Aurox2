def reinviocapi
	mreinviocapi = Gtk::Window.new("Selezione dei movimenti da inviare nuovamente")
	mreinviocapi.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mreinviocapi.set_default_size(400, 650)
	boxreinviocapiv = Gtk::VBox.new(false, 0)
	boxreinviocapi1 = Gtk::HBox.new(false, 5)
	boxreinviocapi2 = Gtk::HBox.new(false, 5)
	boxreinviocapi3 = Gtk::HBox.new(false, 5)
	boxreinviocapi4 = Gtk::HBox.new(false, 5)
	boxreinviocapi5 = Gtk::HBox.new(false, 5)
	boxreinviocapi6 = Gtk::HBox.new(false, 5)
	boxreinviocapi7 = Gtk::HBox.new(false, 5)
	boxreinviocapiv.pack_start(boxreinviocapi1, false, false, 5)
	boxreinviocapiv.pack_start(boxreinviocapi2, false, false, 5)
	boxreinviocapiv.pack_start(boxreinviocapi3, false, false, 5)
	boxreinviocapiv.pack_start(boxreinviocapi4, false, false, 5)
	boxreinviocapiv.pack_start(boxreinviocapi5, false, false, 5)
	boxreinviocapiv.pack_start(boxreinviocapi6, false, false, 5)
	boxreinviocapiv.pack_start(boxreinviocapi7, true, true, 5)
	mreinviocapi.add(boxreinviocapiv)
	labelmarca = Gtk::Label.new("Cerca capo:")
	boxreinviocapi1.pack_start(labelmarca, false, false, 5)
	marca = Gtk::Entry.new()
	boxreinviocapi1.pack_start(marca, false, false, 5)
	labelmovimento = Gtk::Label.new("Tipo di movimento:")
	boxreinviocapi2.pack_start(labelmovimento, false, false, 5)
	movingr = Gtk::RadioButton.new("Ingresso")
	movingr.active=(true)
	tipomov = "I"
	movingr.signal_connect("toggled") {
		if movingr.active?
			tipomov="I"
		end
	}
	boxreinviocapi2.pack_start(movingr, false, false, 5)
	movusc = Gtk::RadioButton.new(movingr, "Uscita")
	movusc.signal_connect("toggled") {
		if movusc.active?
			tipomov="U"
		end
	}
	boxreinviocapi2.pack_start(movusc, false, false, 5)
	labeldata = Gtk::Label.new("Data del movimento:")
	boxreinviocapi3.pack_start(labeldata, false, false, 5)
	data = Gtk::Calendar.new()
	boxreinviocapi4.pack_start(data, true , false, 0)
	cerca = Gtk::Button.new( "Cerca capo" )
	boxreinviocapi5.pack_start(cerca, true , false, 0)
	seltutti = Gtk::Button.new( "Seleziona tutti" )
	boxreinviocapi5.pack_start(seltutti, true , false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mreinviocapi.destroy
	}
	boxreinviocapi5.pack_start(bottchiudi, true, false, 0)
	salva = Gtk::Button.new( "Imposta come non inviati" )
	boxreinviocapi6.pack_start(salva, true , false, 0)
	listareinviocapi = Gtk::ListStore.new(Integer, String)
	cerca.signal_connect("clicked") {
		listareinviocapi.clear
		giorno = "#{data.year}" + "-" + "#{data.month+1}" + "-" + "#{data.day}"
		if tipomov == "I"
			capimod = Animals.find(:all, :conditions => ["relaz_id= ? and fileingr = ? and data_ingr = ? and marca LIKE ?", "#{@stallaoper.id}", "1", "#{giorno}", "%#{marca.text}%"])
		elsif tipomov == "U"
			capimod = Animals.find(:all, :conditions => ["relaz_id= ? and fileusc = ? and uscita = ? and marca LIKE ?", "#{@stallaoper.id}", "1", "#{giorno}", "%#{marca.text}%"])
		end
		capimod.each do |r|
			iter = listareinviocapi.append
			iter[0] = r.id
			iter[1] = r.marca
		end
	}
	mreinviocapiscroll = Gtk::ScrolledWindow.new
	vistareinviocapi = Gtk::TreeView.new(listareinviocapi)
	vistareinviocapi.selection.mode = Gtk::SELECTION_MULTIPLE
	cella = Gtk::CellRendererText.new
	colonna0 = Gtk::TreeViewColumn.new("Id", cella)
	colonna0.resizable = true
	colonna1 = Gtk::TreeViewColumn.new("Marca", cella)
	colonna1.resizable = true
	colonna0.set_attributes(cella, :text => 0)
	colonna1.set_attributes(cella, :text => 1)
	vistareinviocapi.append_column(colonna0)
	vistareinviocapi.append_column(colonna1)
	mreinviocapiscroll.add(vistareinviocapi)
	seltutti.signal_connect("clicked") {
		vistareinviocapi.selection.select_all
	}
	salva.signal_connect("clicked") {
		avviso = Gtk::MessageDialog.new(mreinviocapi, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "I capi selezionati saranno presenti nel prossimo file. Procedo?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			cancellare = []
			caposel = vistareinviocapi.selection
			caposel.selected_each do |model, path, iter|
				cancellare.push(Gtk::TreeRowReference.new(model,path))
				if tipomov == "I"
					Animals.update(iter[0], {:fileingr => "0"})
				elsif tipomov == "U"
					Animals.update(iter[0], {:fileusc => "0"})
				end
			end
			cancellare.each do |c|
				(path = c.path) and listareinviocapi.remove(listareinviocapi.get_iter(path))
			end
			Conferma.conferma(mreinviocapi, "Operazione eseguita.")
		else
			Conferma.conferma(mreinviocapi, "Operazione annullata.")
		end
	}
	boxreinviocapi7.pack_start(mreinviocapiscroll, true, true, 0)
	mreinviocapi.show_all
end
