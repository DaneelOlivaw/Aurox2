# Inserimento dei dati di uscita dei capi

def uscgenerica(finestra, muscite, listasel, combousc, modo)
	mdatiuscita = Gtk::Window.new("Compravendita o altro")
	mdatiuscita.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxuscv = Gtk::VBox.new(false, 0)
	boxusc1 = Gtk::HBox.new(false, 5)
	boxusc2 = Gtk::HBox.new(false, 5)
	boxusc3 = Gtk::HBox.new(false, 5)
	boxusc4 = Gtk::HBox.new(false, 5)
	boxusc5 = Gtk::HBox.new(false, 5)
	boxusc6 = Gtk::HBox.new(false, 5)
	boxusc7 = Gtk::HBox.new(false, 5)
	boxusc8 = Gtk::HBox.new(false, 5)
	boxusc9 = Gtk::HBox.new(false, 5)
	boxusc10 = Gtk::HBox.new(false, 5)
	boxuscv.pack_start(boxusc1, false, false, 5)
	boxuscv.pack_start(boxusc2, false, false, 5)
	boxuscv.pack_start(boxusc3, false, false, 5)
	boxuscv.pack_start(boxusc4, false, false, 5)
	boxuscv.pack_start(boxusc5, false, false, 5)
	boxuscv.pack_start(boxusc6, false, false, 5)
	boxuscv.pack_start(boxusc7, false, false, 5)
	boxuscv.pack_start(boxusc8, false, false, 5)
	boxuscv.pack_start(boxusc9, false, false, 5)
	boxuscv.pack_start(boxusc10, false, false, 5)
	mdatiuscita.add(boxuscv)

	stringacapi = ""
	hashallev = {"id" => "", "ragsoc" => "", "cod317" => "", "via" => "", "comune" => "", "provincia" => ""}
	hashtrasp = {"id" => "", "nometrasp" => "", "tipomezzo" => "", "marca" => "", "targamotrice" => "", "targarimorchio" => "", "via" => "", "comune" => "", "provincia" => "", "autorizzazione" => "", "datarilascio" => ""}

	#Data uscita

	labeldatausc = Gtk::Label.new("Data uscita (GGMMAA):")
	boxusc2.pack_start(labeldatausc, false, false, 5)
	datausc = Gtk::Entry.new()
	datausc.max_length =(6)
	boxusc2.pack_start(datausc, false, false, 5)

	#Allevamento / mercato di destinazione

	labelallevdest = Gtk::Label.new("Codice allevamento / mercato di destinazione:")
	boxusc3.pack_start(labelallevdest, false, false, 5)
	listall = Gtk::ListStore.new(Integer, String, String, String, String, String, String)
	#selalldest = Allevuscs.find(:all, :order => "ragsoc")
	Allevuscs.tutti.each do |alldest|
		iteralldest = listall.append
		iteralldest[0] = alldest.id
		iteralldest[1] = alldest.ragsoc
		iteralldest[2] = alldest.idfisc
		iteralldest[3] = alldest.cod317
		iteralldest[4] = alldest.via
		iteralldest[5] = alldest.comune
		iteralldest[6] = alldest.provincia
	end
	comboalldest = Gtk::ComboBox.new(listall)
	renderusc = Gtk::CellRendererText.new
	renderusc.visible=(false)
	comboalldest.pack_start(renderusc,false)
	comboalldest.set_attributes(renderusc, :text => 0)
	renderusc = Gtk::CellRendererText.new
	comboalldest.pack_start(renderusc,false)
	comboalldest.set_attributes(renderusc, :text => 1)
	renderusc = Gtk::CellRendererText.new
	renderusc.visible=(false)
	comboalldest.pack_start(renderusc,false)
	comboalldest.set_attributes(renderusc, :text => 2)
	renderusc = Gtk::CellRendererText.new
	comboalldest.pack_start(renderusc,false)
	comboalldest.set_attributes(renderusc, :text => 3)
	boxusc3.pack_start(comboalldest, false, false, 5)

	#Inserimento nuovo allevamento

	nallev = Gtk::Button.new("Nuovo allevamento")
	nallev.signal_connect( "released" ) {
		require 'nuovoallevamento'
		nuovoallevamento(listall)
	}
	boxusc3.pack_start(nallev, false, false, 5)

	#Nazione destinazione

	labelnazdest = Gtk::Label.new("Nazione di destinazione:")
	boxusc4.pack_start(labelnazdest, false, false, 5)
	listanazdest = Gtk::ListStore.new(Integer, String, String)
	Nazdests.tutti.each do |nd|
	iter1 = listanazdest.append
	iter1[0] = nd.id.to_i
	iter1[1] = nd.nome
	iter1[2] = nd.codice
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
	boxusc4.pack_start(combonazdest, false, false, 0)
	combonazdest.set_active(0)
	z = -1
	while combonazdest.active_iter[0] != 24
		z+=1
		combonazdest.set_active(z)
	end

	# Nome trasportatore

	labeltrasp = Gtk::Label.new("Nome trasportatore:")
	boxusc6.pack_start(labeltrasp, false, false, 5)
	listatrasp = Gtk::ListStore.new(Integer, String, String, String, String, String, String, String, String, String, Date)
	Trasportatoris.tutti.each do |trasp|
		itertrasp = listatrasp.append
		itertrasp[0] = trasp.id
		itertrasp[1] = trasp.nometrasp
		itertrasp[2] = trasp.tipomezzo
		itertrasp[3] = trasp.marca
		itertrasp[4] = trasp.targamotrice
		itertrasp[5] = trasp.targarimorchio
		itertrasp[6] = trasp.via
		itertrasp[7] = trasp.comune
		itertrasp[8] = trasp.provincia
		itertrasp[9] = trasp.autorizzazione
		itertrasp[10] = trasp.datarilascio
	end
	combotrasp = Gtk::ComboBox.new(listatrasp)
	rendertrasp = Gtk::CellRendererText.new
	rendertrasp.visible=(false)
	combotrasp.pack_start(rendertrasp,false)
	combotrasp.set_attributes(rendertrasp, :text => 0)
	rendertrasp = Gtk::CellRendererText.new
	combotrasp.pack_start(rendertrasp,false)
	combotrasp.set_attributes(rendertrasp, :text => 1)
	boxusc6.pack_start(combotrasp, false, false, 5)

	unless @stallaoper.trasportatori_id.to_i <= 0
		combotrasp.set_active(0)
		contatrasp = -1
		while combotrasp.active_iter[0] != @stallaoper.trasportatori_id
			contatrasp+=1
			combotrasp.set_active(contatrasp)
		end
		else
		combotrasp.set_active(-1)
	end

	#Inserimento nuovo trasportatore

	ntrasp = Gtk::Button.new("Nuovo trasportatore")
	ntrasp.signal_connect( "released" ) {
		require 'nuovotrasportatore'
		nuovotrasportatore(listatrasp)
	}
	boxusc6.pack_start(ntrasp, false, false, 5)

	#Marca sostitutiva

	labelmarcasost = Gtk::Label.new("Marca sostitutiva:")
	boxusc7.pack_start(labelmarcasost, false, false, 5)
	marcasost = Gtk::Entry.new()
	boxusc7.pack_start(marcasost, false, false, 5)

	# Modello 4

	labelmod4usc = Gtk::Label.new("Modello 4:")
	boxusc8.pack_start(labelmod4usc, false, false, 5)
	mod4usc = Gtk::Entry.new()
	progmod4 = @stallaoper.mod4usc.split("/")
	progmod41 = progmod4[0].to_i
	boxusc8.pack_start(mod4usc, false, false, 5)

	# Data modello 4

	labeldatamod4usc = Gtk::Label.new("Data Modello 4 (GGMMAA):")
	boxusc8.pack_start(labeldatamod4usc, false, false, 5)
	datamod4usc = Gtk::Entry.new()
	datamod4usc.max_length=(6)
	boxusc8.pack_start(datamod4usc, false, false, 5)
	datausc.signal_connect_after("focus-out-event") {
		datausc.text = datausc.text + @giorno.strftime("%y").to_s if datausc.text.length == 4
		if datausc.text[4,2] == progmod4[1]
			nmod4 = progmod41 + 1
		else
			nmod4 = 1
		end
		mod4usc.text = ("#{nmod4}")
		datamod4usc.text =("#{datausc.text}")
	}

	unless @mod4provv == ""
		datausc.text = @mod4provv[4].strftime("%d%m%y")
		unless @mod4provv[5].to_i == 0
			comboalldest.set_active(0)
			combotrasp.set_active(0)
			z = -1
			while comboalldest.active_iter[0] != @mod4provv[5]
				z+=1
				comboalldest.set_active(z)
			end
		end
		z = -1
		while combotrasp.active_iter[0] != @mod4provv[9]
			z+=1
			combotrasp.set_active(z)
		end
		mod4usc.text = @mod4provv[0].split("/")[2]
	end

	#Bottone di inserimento uscite

	bottmovusc = Gtk::Button.new( "Inserisci" )
	bottmovusc.signal_connect("clicked") {
		errore = nil
			if datausc.text == ""
				Errore.avviso(mdatiuscita, "Mancano dati.")
				errore = 1
			elsif combousc.active_iter[0] == 3 or 10 or 11 or 16 or 20 or 28 or 29 or 30
				if comboalldest.active == -1 or combotrasp.active == -1 or combonazdest.active == -1 or mod4usc.text == "" or datamod4usc.text == ""
					Errore.avviso(mdatiuscita, "Mancano dati: altri casi.")
					errore = 1
				end
			end
		if errore == nil
			begin
				if datausc.text.to_i != 0
					datauscingl = @giorno.strftime("%Y")[0,2] + datausc.text[4,2] + datausc.text[2,2] + datausc.text[0,2]
					Time.parse("#{datauscingl}")
				else
					Errore.avviso(mdatiuscita, "Data uscita errata.")
					errore = 1
				end
				if datamod4usc.text != ""
					if datamod4usc.text.to_i != 0
						datamod4uscingl = @giorno.strftime("%Y")[0,2] + datamod4usc.text[4,2] + datamod4usc.text[2,2] + datamod4usc.text[0,2]
						Time.parse("#{datamod4uscingl}")
					else
						Errore.avviso(mdatiuscita, "Data mod4 errata.")
						errore = 1
					end
				end
			rescue Exception => errore
				Errore.avviso(mdatiuscita, "Controllare le date")
			end
		end
	if errore == nil
		if comboalldest.active == -1 or comboalldest.sensitive? == false
			valcomboalldest = ""
		else
			mod4 = "#{@stallaoper.stalle.cod317}/#{Time.parse("#{datamod4uscingl}").strftime("%Y")}/#{mod4usc.text}"
			idalldest = comboalldest.active_iter[0]
			valcomboalldest = comboalldest.active_iter[1]
			alldestidfisc = comboalldest.active_iter[2]
			alldest317 = comboalldest.active_iter[3]
			alldir = Relazs.cercagestito(alldest317, valcomboalldest)
		end
		if combonazdest.active == -1 or combonazdest.sensitive? == false
			valcombonazdest = ""
		else
			valcombonazdest = combonazdest.active_iter[0]
		end
		if combotrasp.active == -1 or combotrasp.sensitive? == false
			valcombotrasp = ""
		else
			valcombotrasp = combotrasp.active_iter[0]
		end
		listasel.each do |model,path,iter|
			marcauscid = iter[0]
			if modo == 0
				Animals.update(marcauscid, {:uscita => "#{datauscingl}", :uscite_id => "#{combousc.active_iter[0]}", :allevusc_id => "#{idalldest}", :nazdest_id => "#{valcombonazdest}", :trasportatori_id => "#{valcombotrasp}", :mod4usc => "#{mod4}", :data_mod4usc => "#{datamod4uscingl.to_i}", :marcasost => "#{marcasost.text}", :uscito => "1"})
			else
				stringacapi << "#{marcauscid}" +","
			end
		end
		if modo == 0
			Relazs.update(@stallaoper.id, { :mod4usc => "#{mod4usc.text}/#{Time.parse("#{datamod4uscingl}").strftime("%y")}"})
			@stallaoper.mod4usc = mod4usc.text + "/" + Time.parse("#{datamod4uscingl}").strftime("%y")
			Conferma.conferma(mdatiuscita, "Capi usciti correttamente.")
			if alldir.length > 0
				avviso = Gtk::MessageDialog.new(finestra, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "L'allevamento di destinazione è tra le stalle gestite; procedo con il caricamento automatico?")
				risposta = avviso.run
				avviso.destroy
				if risposta == Gtk::Dialog::RESPONSE_YES
					require 'insautomatico'
					insautomatico(finestra, listasel, valcomboalldest, alldest317, alldir, combousc.active_iter[0], datausc.text, mod4, datamod4usc.text)
				else
					Conferma.conferma(finestra, "Operazione annullata.")
				end
			end
			mdatiuscita.destroy
			muscite.destroy
		else
			if @mod4provv == ""
				Mod4temps.create(:relaz_id => "#{@stallaoper.id.to_i}", :mod4 => "#{@stallaoper.stalle.cod317}/#{Time.parse("#{datamod4uscingl}").strftime("%Y")}/#{mod4usc.text}", :capi => "#{stringacapi.chop}", :datamod4 => "#{datamod4uscingl.to_i}", :datausc => "#{datauscingl}", :allevamenti_id => "#{idalldest}",:uscite_id => "#{combousc.active_iter[0]}", :naz_dest => "#{valcombonazdest}", :trasportatori_id => "#{valcombotrasp}")
			else
				Mod4temps.update(@mod4provv[10], {:mod4 => "#{@stallaoper.stalle.cod317}/#{Time.parse("#{datamod4uscingl}").strftime("%Y")}/#{mod4usc.text}", :capi => "#{stringacapi.chop}", :datamod4 => "#{datamod4uscingl.to_i}", :datausc => "#{datauscingl}", :allevamenti_id => "#{idalldest}",:uscite_id => "#{combousc.active_iter[0]}", :naz_dest => "#{valcombonazdest}", :trasportatori_id => "#{valcombotrasp}"})
			end
			Conferma.conferma(mdatiuscita, "Modello 4 provvisorio creato, ora puoi stamparlo.")
			arrmarche = []
			listasel.each do |model,path,iter|
				arrmarche << iter[1]
			end
			hashallev = {"id" => "#{comboalldest.active_iter[0]}", "ragsoc" => "#{comboalldest.active_iter[1]}", "cod317" => "#{comboalldest.active_iter[3]}", "via" => "#{comboalldest.active_iter[4]}", "comune" => "#{comboalldest.active_iter[5]}", "provincia" => "#{comboalldest.active_iter[6]}"}
			hashtrasp = {"id" => "#{combotrasp.active_iter[0]}", "nometrasp" => "#{combotrasp.active_iter[1]}", "tipomezzo" => "#{combotrasp.active_iter[2]}", "marca" => "#{combotrasp.active_iter[3]}", "targamotrice" => "#{combotrasp.active_iter[4]}", "targarimorchio" => "#{combotrasp.active_iter[5]}", "via" => "#{combotrasp.active_iter[6]}", "comune" => "#{combotrasp.active_iter[7]}", "provincia" => "#{combotrasp.active_iter[8]}", "autorizzazione" => "#{combotrasp.active_iter[9]}", "datarilascio" => "#{combotrasp.active_iter[10]}"}
			require 'stampamod4provv'
			stampamod4provv(mdatiuscita, arrmarche, combousc.active_iter[0], nil, hashallev, hashtrasp, @stallaoper.stalle.cod317 + "/" + Time.parse("#{datamod4uscingl}").strftime("%Y") + "/" + mod4usc.text, Time.parse("#{datauscingl}").strftime("%d/%m/%Y"))
		end
	end
	}
	boxusc10.pack_start(bottmovusc, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mdatiuscita.destroy
		muscite.present
	}
	boxusc10.pack_start(bottchiudi, false, false, 0)
	mdatiuscita.show_all
end
