# Uscita per furto

def uscfurto(finestra, muscite, listasel, combousc)
	mdatifurto = Gtk::Window.new("Furto")
	mdatifurto.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxuscv = Gtk::VBox.new(false, 0)
	boxusc1 = Gtk::HBox.new(false, 5)
	boxusc2 = Gtk::HBox.new(false, 5)
	boxuscv.pack_start(boxusc1, false, false, 5)
	boxuscv.pack_start(boxusc2, false, false, 5)
	mdatifurto.add(boxuscv)

	#Data uscita

	labeldatausc = Gtk::Label.new("Data uscita (GGMMAA):")
	boxusc1.pack_start(labeldatausc, false, false, 5)
	datausc = Gtk::Entry.new()
	datausc.max_length =(6)
	boxusc1.pack_start(datausc, false, false, 5)

	#Bottone di inserimento uscite

	bottmovusc = Gtk::Button.new( "Inserisci" )
	bottmovusc.signal_connect("clicked") {
		begin
			datausc.text = datausc.text + @giorno.strftime("%y").to_s if datausc.text.length == 4
			errore = nil
			if datausc.text == ""
				Errore.avviso(mdatifurto, "Mancano dati.")
				errore = 1
			elsif datausc.text.to_i == 0
				Errore.avviso(mdatifurto, "Data uscita errata.")
				errore = 1
			else
				datauscingl = @giorno.strftime("%Y")[0,2] + datausc.text[4,2] + datausc.text[2,2] + datausc.text[0,2]
				Time.parse("#{datauscingl}")
			end
		rescue Exception => errore
			Errore.avviso(mdatifurto, "Controllare le date")
		end
		if errore == nil
			listasel.each do |model,path,iter|
				marcauscid = iter[0]
				Animals.update(marcauscid, {:uscita => "#{datauscingl}", :uscite_id => "#{combousc.active_iter[0]}", :uscito => "1"})
			end
		Conferma.conferma(mdatifurto, "Capi usciti correttamente.")
			mdatifurto.destroy
			muscite.destroy
			finestra.present
		end
	}
	boxusc2.pack_start(bottmovusc, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mdatifurto.destroy
		muscite.present
	}
	boxusc2.pack_start(bottchiudi, false, false, 0)
	mdatifurto.show_all
end
