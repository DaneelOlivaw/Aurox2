def mascsceltamod(capo)
	msceltamod = Gtk::Window.new("Scelta movimento da modificare")
	msceltamod.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxmodv = Gtk::VBox.new(false, 0)
	boxmod1 = Gtk::HBox.new(false, 5)
	boxmod2 = Gtk::HBox.new(false, 5)
	boxmod3 = Gtk::HBox.new(false, 5)
	boxmodv.pack_start(boxmod1, false, false, 5)
	boxmodv.pack_start(boxmod2, false, false, 5)
	boxmodv.pack_start(boxmod3, false, false, 5)
	msceltamod.add(boxmodv)

	bottmodingr = Gtk::Button.new("Modifica movimento di ingresso e dati del capo")
	boxmodv.pack_start(bottmodingr, false, false, 5)
	bottmodusc = Gtk::Button.new("Modifica movimento di uscita")
	boxmodv.pack_start(bottmodusc, false, false, 5)

	bottmodingr.signal_connect("clicked") {
		if capo.selected[49] == "SI"
			Conferma.conferma(msceltamod, "Attenzione: il movimento è stato stampato nel registro vidimato; ricordarsi di correggere il cartaceo a mano previo accordo col funzionario preposto.")
		end
		modificacapo(capo)
	}
	bottmodusc.signal_connect("clicked") {
		if capo.selected[50] == "SI"
			Conferma.conferma(msceltamod, "Attenzione: il movimento è stato stampato nel registro vidimato; ricordarsi di correggere il cartaceo a mano previo accordo col funzionario preposto.")
		end
		modificacapousc(capo)
	}

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		msceltamod.destroy
	}
	boxmodv.pack_start(bottchiudi, false, false, 0)
	msceltamod.show_all
end
