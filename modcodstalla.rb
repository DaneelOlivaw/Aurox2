#Modifica proprietari

def modcodstalla
	mmodcodstalla = Gtk::Window.new("Modifica codice di stalla")
	mmodcodstalla.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmodcodstallav = Gtk::VBox.new(false, 0)
	boxmodcodstalla1 = Gtk::HBox.new(false, 5)
	boxmodcodstalla2 = Gtk::HBox.new(false, 5)
	boxmodcodstalla3 = Gtk::HBox.new(false, 5)
	boxmodcodstalla4 = Gtk::HBox.new(false, 5)
	boxmodcodstalla5 = Gtk::HBox.new(false, 5)
	boxmodcodstallav.pack_start(boxmodcodstalla1, false, false, 5)
	boxmodcodstallav.pack_start(boxmodcodstalla2, false, false, 5)
	boxmodcodstallav.pack_start(boxmodcodstalla3, false, false, 5)
	boxmodcodstallav.pack_start(boxmodcodstalla4, false, false, 5)
	boxmodcodstallav.pack_start(boxmodcodstalla5, false, false, 5)
	mmodcodstalla.add(boxmodcodstallav)

	#Combo di scelta codice di stalla

	labelcodstalla = Gtk::Label.new("Selezona proprietario:")
	boxmodcodstalla1.pack_start(labelcodstalla, false, false, 5)

	def caricastalla
		@listastalle = Gtk::ListStore.new(Integer, String, String, String)
		@listastalle.clear
		Stalles.seleziona.each do |s|
			iter1 = @listastalle.append
			iter1[0] = s.id
			iter1[1] = s.cod317
			iter1[2] = s.via
			iter1[3] = s.comune
		end
	end
	caricastalla
	combostalle = Gtk::ComboBox.new(@listastalle)
	renderer1 = Gtk::CellRendererText.new
	combostalle.pack_start(renderer1,false)
	combostalle.set_attributes(renderer1, :text => 1)
	boxmodcodstalla1.pack_start(combostalle.popdown, false, false, 0)

	#Codice 317

	labelcod317 = Gtk::Label.new("Codice 317:")
	boxmodcodstalla2.pack_start(labelcod317, false, false, 5)
	cod317 = Gtk::Entry.new
	cod317.max_length=(50)
	boxmodcodstalla2.pack_start(cod317, false, false, 5)

	#Via

	labelvia = Gtk::Label.new("Indirizzo:")
	boxmodcodstalla3.pack_start(labelvia, false, false, 5)
	via = Gtk::Entry.new
	via.max_length=(50)
	boxmodcodstalla3.pack_start(via, false, false, 5)

	#Comune

	labelcomune = Gtk::Label.new("Comune:")
	boxmodcodstalla4.pack_start(labelcomune, false, false, 5)
	comune = Gtk::Entry.new
	comune.max_length=(50)
	boxmodcodstalla4.pack_start(comune, false, false, 5)

	combostalle.signal_connect( "changed" ) {
		cod317.text=("#{combostalle.active_iter[1]}")
		via.text=("#{combostalle.active_iter[2]}")
		comune.text=("#{combostalle.active_iter[3]}")
	}

	#Bottone di inserimento

	modstalla = Gtk::Button.new( "Modifica codice di stalla" )
	modstalla.signal_connect("clicked") {
		if cod317.text== "" or via.text == "" or comune.text== ""
			Errore.avviso(mmodcodstalla, "Servono tutti i dati.")
		else
			Stalles.update(combostalle.active_iter[0], {:cod317 => "#{cod317.text.upcase}", :via => "#{via.text.upcase}", :comune => "#{comune.text.upcase}"})
			cod317.text= ""
			via.text = ""
			comune.text= ""
			caricastalla
			combostalle.model=(@listastalle)
		end
	}
	boxmodcodstalla5.pack_start(modstalla, false, false, 0)

	bottelimina = Gtk::Button.new( "Elimina" )
	bottelimina.signal_connect("clicked") {
		if Relazs.count(:conditions => ["stalle_id = ?", combostalle.active_iter[0]]) == 0
			avviso = Gtk::MessageDialog.new(mmodcodstalla, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Proseguo con l'eleminazione del codice di stalla?")
			risposta = avviso.run
			avviso.destroy
			if risposta == Gtk::Dialog::RESPONSE_YES
				Stalles.delete(combostalle.active_iter[0])
				Conferma.conferma(mmodcodstalla, "Codice di stalla eliminato.")
				cod317.text= ""
				via.text = ""
				comune.text= ""
				caricastalla
				combostalle.model=(@listastalle)
			else
				Conferma.conferma(mmodcodstalla, "Operazione annullata.")
			end
		else
			Conferma.conferma(mmodcodstalla, "Il codice di stalla non può essere eliminato perché in uso.")
		end
	}
	boxmodcodstalla5.pack_start(bottelimina, false, false, 0)

	#Bottone di chiusura finestra

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mmodcodstalla.destroy
	}
	boxmodcodstalla5.pack_start(bottchiudi, false, false, 0)
	mmodcodstalla.show_all
end
