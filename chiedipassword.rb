def mchiedipassword(variabile, azione)
	puts "Chiedipassword"
	mpassword = Gtk::Window.new("Esportazione database")
	mpassword.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	#mpassword.focus=(true)
	boxpasswordv = Gtk::VBox.new(false, 0)
	boxpassword1 = Gtk::HBox.new(false, 5)
	boxpassword2 = Gtk::HBox.new(false, 5)
	boxpassword3 = Gtk::HBox.new(false, 5)
	boxpasswordv.pack_start(boxpassword1, false, false, 5)
	boxpasswordv.pack_start(boxpassword2, false, false, 5)
	boxpasswordv.pack_start(boxpassword3, false, false, 5)
	mpassword.add(boxpasswordv)

	labelpass = Gtk::Label.new("Password di amministratore:")
	boxpassword1.pack_start(labelpass, false, false, 5)
	password = Gtk::Entry.new
	password.visibility = false
	boxpassword1.pack_start(password, false, false, 5)

	bottesp = Gtk::Button.new( "OK" )
	boxpassword1.pack_start(bottesp, false, false, 5)

	password.signal_connect("activate") {
		if password.text == ""
			Errore.avviso(mpassword, "Inserisci una password")
		else
			if azione == "cancelladb"
				eliminadb(password.text)
				mpassword.destroy
			elsif azione == "esportadb"
				esportadb(password.text)
				mpassword.destroy
			elsif azione == "importadb"
				importadb(variabile, password.text)
				
				mpassword.destroy
			end
		end
	}

	bottesp.signal_connect( "clicked" ) {
		if password.text == ""
			Errore.avviso(mpassword, "Inserisci una password")
		else
			if azione == "cancelladb"
				eliminadb(password.text)
				mpassword.destroy
			elsif azione == "esportadb"
				esportadb(password.text)
				mpassword.destroy
			elsif azione == "importadb"
				importadb(variabile, password.text)
				mpassword.destroy
			end
		end
	}

	mpassword.show_all

end
