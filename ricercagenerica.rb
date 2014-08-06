def ricercagenerica
	mricgen = Gtk::Window.new("Ricerche generiche")
	mricgen.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxricgenv = Gtk::VBox.new(false, 0)
	boxricgen1 = Gtk::HBox.new(false, 5)
	boxricgen2 = Gtk::HBox.new(false, 5)
	boxricgen3 = Gtk::HBox.new(false, 5)
	boxricgen4 = Gtk::HBox.new(false, 5)
	boxricgen5 = Gtk::HBox.new(false, 5)
	boxricgen6 = Gtk::HBox.new(false, 5)
	boxricgenv.pack_start(boxricgen1, false, false, 5)
	boxricgenv.pack_start(boxricgen2, false, false, 5)
	boxricgenv.pack_start(boxricgen3, false, false, 5)
	boxricgenv.pack_start(boxricgen4, false, false, 5)
	boxricgenv.pack_start(boxricgen5, false, false, 5)
	boxricgenv.pack_start(boxricgen6, false, false, 5)
	mricgen.add(boxricgenv)

	labelmovimento = Gtk::Label.new("Tipo di movimento:")
	boxricgen3.pack_start(labelmovimento, false, false, 5)
	movtutti = Gtk::RadioButton.new("Tutti")
	movtutti.active=(true)
	tipomov = "T"
	movtutti.signal_connect("toggled") {
		if movtutti.active?
			tipomov="T"
		end
	}
	boxricgen3.pack_start(movtutti, false, false, 5)
	movingr = Gtk::RadioButton.new(movtutti, "Ingresso")
	movingr.signal_connect("toggled") {
		if movingr.active?
			tipomov="I"
		end
	}
	boxricgen3.pack_start(movingr, false, false, 5)
	movusc = Gtk::RadioButton.new(movtutti, "Uscita")
	movusc.signal_connect("toggled") {
		if movusc.active?
			tipomov="U"
		end
	}
	boxricgen3.pack_start(movusc, false, false, 5)

	labelinizio = Gtk::Label.new("Da:")
	boxricgen4.pack_start(labelinizio, false, false, 5)
	datainizio = Gtk::Entry.new
	datainizio.max_length=(6)
	boxricgen4.pack_start(datainizio, false, false, 5)
	labelfine = Gtk::Label.new("A:")
	boxricgen4.pack_start(labelfine, false, false, 5)
	datafine = Gtk::Entry.new
	datafine.max_length=(6)
	boxricgen4.pack_start(datafine, false, false, 5)
	bottcerca = Gtk::Button.new("Cerca")
	boxricgen6.pack_start(bottcerca, false, false, 5)
	bottcerca.signal_connect("clicked") {
		if tipomov == "U"
			querymov = "and uscito IS NOT NULL"
			ordinamento = "uscita, mod4usc, id"
		else
			querymov = ""
			ordinamento = "data_ingr, id"
		end
		if tipomov == "I"
			orientamento = "portrait"
		else
			orientamento = "landscape"
		end
		begin
			if datainizio.text != ""
				inizioingl = datainizio.text[4,2] + datainizio.text[2,2] + datainizio.text[0,2]
				inizioingl = Time.parse("#{inizioingl}").strftime("%Y")[0,2] + inizioingl
				inizioita = inizioingl.to_date.strftime("%d/%m/%Y")
				if tipomov == "I"
					queryinizio = "and data_ingr >= '#{inizioingl}'"
				elsif tipomov == "U"
					queryinizio = "and uscita >= '#{inizioingl}'"
				else
					queryinizio = "and (data_ingr >= '#{inizioingl}' or uscita >= '#{inizioingl}')"
				end
			else
				queryinizio = ""
				inizioita = ""
			end
			if datafine.text != ""
				fineingl = datafine.text[4,2] + datafine.text[2,2] + datafine.text[0,2]
				fineingl = Time.parse("#{fineingl}").strftime("%Y")[0,2] + fineingl
				fineita = fineingl.to_date.strftime("%d/%m/%Y")
				if tipomov == "I"
					queryfine = "and data_ingr <= '#{fineingl}'"
				elsif tipomov == "U"
					queryfine = "and uscita <= '#{fineingl}'"
				else
					queryfine = "and (data_ingr <= '#{fineingl}' or uscita <= '#{fineingl}')"
				end
			else
				queryfine = ""
				fineita = ""
			end
			selmov = Animals.find(:all, :include => [:relaz, :razza, :ingresso, :allevingr, :nazorig, :nazprov, :naznasprimimp, :uscite, :allevusc, {:macelli, :region}, :nazdest, :trasportatori], :conditions => ["relaz_id = ? #{querymov} #{queryinizio} #{queryfine}", "#{@stallaoper.id}"], :order => "#{ordinamento}")
			require 'visricgenerica'
			visricgenerica(selmov, inizioita, fineita, orientamento)
		end
	}

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mricgen.destroy
	}
	boxricgen6.pack_start(bottchiudi, false, false, 0)
	mricgen.show_all
end
