def stampaallegatomod4
	mallmod4 = Gtk::Window.new("Stampa Modello 4 e allegato")
	mallmod4.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxallmod4v = Gtk::VBox.new(false, 0)
	boxallmod41 = Gtk::HBox.new(false, 5)
	boxallmod42 = Gtk::HBox.new(false, 5)
	boxallmod43 = Gtk::HBox.new(false, 5)
	boxallmod4v.pack_start(boxallmod41, false, false, 5)
	boxallmod4v.pack_start(boxallmod42, false, false, 5)
	boxallmod4v.pack_start(boxallmod43, false, false, 5)
	mallmod4.add(boxallmod4v)
	hashmacello = {"id" => "", "nomemac" => "", "bollomac" => "", "region_id" => "", "via" => "", "comune" => "", "provincia" => ""}
	hashallev = {"id" => "", "ragsoc" => "", "cod317" => "", "via" => "", "comune" => "", "provincia" => ""}
	hashtrasp = {"id" => "", "nometrasp" => "", "tipomezzo" => "", "marca" => "", "targamotrice" => "", "targarimorchio" => "", "via" => "", "comune" => "", "provincia" => "", "autorizzazione" => "", "datarilascio" => ""}
	labelmod4 = Gtk::Label.new("Numero modello 4:")
	boxallmod41.pack_start(labelmod4, false, false, 5)
	m4 = Gtk::Entry.new()
	boxallmod41.pack_start(m4, false, false, 5)

	anni = Gtk::ListStore.new(Integer)
	arranni = [(@giorno.strftime("%Y").to_i), (@giorno.strftime("%Y").to_i) -1, (@giorno.strftime("%Y").to_i) -2]
	arranni.each do |a|
		iter = anni.append
		iter[0] = a
	end
	comboanno = Gtk::ComboBox.new(anni)
	renderer1 = Gtk::CellRendererText.new
	comboanno.pack_start(renderer1,false)
	comboanno.set_attributes(renderer1, :text => 0)
	comboanno.active=(0)
	labelanno = Gtk::Label.new("Seleziona l'anno:")
	boxallmod42.pack_start(labelanno, false, false, 5)
	boxallmod42.pack_start(comboanno, false, false, 0)

	stampamod4 = Gtk::Button.new("Stampa mod4")
	boxallmod43.pack_start(stampamod4, false, false, 5)
	macello = []
	allev = []
	trasportatore = []
	stampamod4.signal_connect("clicked") {
		errore = 0
		capi = Animals.trovapartita("#{@stallaoper.id}", "mod4usc", "#{@stallaoper.stalle.cod317}/#{comboanno.active_iter[0]}/#{m4.text}")
		if capi.length == 0
			Errore.avviso(mallmod4, "Questo modello 4 non esiste.") #.avvia
			errore = 1
		else
			if capi[0].uscite_id == 9
				if capi[0].macelli.via.to_s == "" or capi[0].macelli.comune.to_s == "" or capi[0].macelli.provincia.to_s == ""
					Errore.avviso(mallmod4, "Manca l'indirizzo del macello, inseriscilo.")
					require 'modmacello'
					modmacello(capi[0].macelli_id)
					errore = 1
				else
					macello = Macellis.cercaid(capi[0].macelli_id)
					trasportatore = Trasportatoris.cercaid(capi[0].trasportatori_id)
				end
			else
				if capi[0].allevusc.via.to_s == "" or capi[0].allevusc.comune.to_s == "" or capi[0].allevusc.provincia.to_s == ""
					Errore.avviso(mallmod4, "Manca l'indirizzo dell'allevamento, inseriscilo.")
					require 'modallevamenti'
					modallevamenti(capi[0].allevusc_id)
					errore = 1
				else
					allev = Allevuscs.cercaid(capi[0].allevusc_id)
					trasportatore = Trasportatoris.cercaid(capi[0].trasportatori_id)
				end
			end
		end
		if errore == 0
			if capi[0].uscite_id == 9
				hashmacello = {"id" => "#{macello.id}", "nomemac" => "#{macello.nomemac}", "bollomac" => "#{macello.bollomac}", "regione" => "#{macello.region.regione}", "via" => "#{macello.via}", "comune" => "#{macello.comune}", "provincia" => "#{macello.provincia}"}
			else
				hashallev = {"id" => "#{allev.id}", "ragsoc" => "#{allev.ragsoc}", "cod317" => "#{allev.cod317}", "via" => "#{allev.via}", "comune" => "#{allev.comune}", "provincia" => "#{allev.provincia}"}
			end
			hashtrasp = {"id" => "#{trasportatore.id}", "nometrasp" => "#{trasportatore.nometrasp}", "tipomezzo" => "#{trasportatore.tipomezzo}", "marca" => "#{trasportatore.marca}", "targamotrice" => "#{trasportatore.targamotrice}", "targarimorchio" => "#{trasportatore.targarimorchio}", "via" => "#{trasportatore.via}", "comune" => "#{trasportatore.comune}", "provincia" => "#{trasportatore.provincia}", "autorizzazione" => "#{trasportatore.autorizzazione}", "datarilascio" => "#{trasportatore.datarilascio}"}
			require 'modello4'
			modello4("#{@stallaoper.stalle.cod317}/#{comboanno.active_iter[0]}/#{m4.text}", capi[0].uscite_id, hashmacello, hashallev, hashtrasp, capi.length, capi[0].data_mod4usc.strftime("%d/%m/%Y"), mallmod4, nil)
		end
	}

	stampa = Gtk::Button.new("Stampa l'allegato")
	boxallmod43.pack_start(stampa, false, false, 5)
	stampa.signal_connect("clicked") {
		capi = Animals.trovapartita("#{@stallaoper.id}", "mod4usc", "#{@stallaoper.stalle.cod317}/#{comboanno.active_iter[0]}/#{m4.text}")
		if capi.length == 0
			Errore.avviso(mallmod4, "Questo modello 4 non esiste.")
		else
			require 'allegatomod4'
			marche = []
			capi.each do |c|
				marche << c.marca			
			end
			allegatomod4("#{@stallaoper.stalle.cod317}/#{comboanno.active_iter[0]}/#{m4.text}", marche, nil)
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mallmod4.destroy
	}
	boxallmod4v.pack_start(bottchiudi, false, false, 0)
	mallmod4.show_all
end
