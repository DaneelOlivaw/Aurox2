#Maschera per l'inserimento automatico dei movimenti di ingresso verso una stalla gestita

def insautomatico(finestra, listasel, alldestragsoc, alldest317, alldir, motivousc, datausc, mod4, datamod4usc)
	minsaut = Gtk::Window.new("Inserimento automatico")
	minsaut.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxinsautv = Gtk::VBox.new(false, 0)
	boxinsaut1 = Gtk::HBox.new(false, 5)
	boxinsaut2 = Gtk::HBox.new(false, 5)
	boxinsaut3 = Gtk::HBox.new(false, 5)
	boxinsaut4 = Gtk::HBox.new(false, 5)
	boxinsaut5 = Gtk::HBox.new(false, 5)
	boxinsaut6 = Gtk::HBox.new(false, 5)
	boxinsaut7 = Gtk::HBox.new(false, 5)
	boxinsaut8 = Gtk::HBox.new(false, 5)
	boxinsaut9 = Gtk::HBox.new(false, 5)
	boxinsautv.pack_start(boxinsaut1, false, false, 5)
	boxinsautv.pack_start(boxinsaut2, false, false, 5)
	boxinsautv.pack_start(boxinsaut3, false, false, 5)
	boxinsautv.pack_start(boxinsaut4, false, false, 5)
	boxinsautv.pack_start(boxinsaut5, false, false, 5)
	boxinsautv.pack_start(boxinsaut6, false, false, 5)
	boxinsautv.pack_start(boxinsaut7, false, false, 5)
	boxinsautv.pack_start(boxinsaut8, false, false, 5)
	boxinsautv.pack_start(boxinsaut9, false, false, 5)
	minsaut.add(boxinsautv)

	listadet = Gtk::ListStore.new(Integer, String, Integer)
	combodet = Gtk::ComboBox.new(listadet)
	listaprop = Gtk::ListStore.new(Integer, String, Integer, String, String)
	comboprop = Gtk::ComboBox.new(listaprop)
	labelstalla = Gtk::Label.new("Stalla di destinazione:")
	boxinsaut1.pack_start(labelstalla, false, false, 5)
	stalla = Gtk::Entry.new
	stalla.text = alldest317
	stalla.editable=(false)
	boxinsaut1.pack_start(stalla, false, false, 5)

	labelragsoc = Gtk::Label.new("Ragione sociale di destinazione:")
	boxinsaut2.pack_start(labelragsoc, false, false, 5)
	ragsoc = Gtk::Entry.new
	ragsoc.text = alldestragsoc
	ragsoc.editable=(false)
	boxinsaut2.pack_start(ragsoc, false, false, 5)

	alldir.each do |p|
		iter = listadet.append
		iter[0] = p.id.to_i
		iter[1] = p.detentori.detentore.to_s
		iter[2] = p.detentori_id.to_i
	end
	arrconfronto = []
	x = nil
	listadet.each do |modello, percorso, iterat|
	(iterat[1] == x) and arrconfronto.push(Gtk::TreeRowReference.new(modello, percorso))
	x = iterat[1]
	end
	arrconfronto.each do |rif|
		(percorso = rif.path) and listadet.remove(listadet.get_iter(percorso))
	end

	renderer = Gtk::CellRendererText.new
	combodet.pack_start(renderer,false)
	renderer.visible=(false)
	combodet.set_attributes(renderer, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	combodet.pack_start(renderer1,false)
	combodet.set_attributes(renderer1, :text => 1)
	renderer2 = Gtk::CellRendererText.new
	renderer2.visible=(false)
	combodet.pack_start(renderer2,false)
	combodet.set_attributes(renderer2, :text => 2)
	renderer3 = Gtk::CellRendererText.new
	combodet.pack_start(renderer3,false))
	labeldet = Gtk::Label.new("Seleziona il detentore di destinazione:")
	boxinsaut3.pack_start(labeldet, false, false, 5)
	boxinsaut3.pack_start(combodet, false, false, 0)

	combodet.signal_connect( "changed" ) {
		if combodet.active != -1
			selprop = []
			alldir.each do |a|
				if a.detentori_id == combodet.active_iter[2]
					selprop << a
				end
			end
			listaprop.clear
			selprop.each do |p|
				iter = listaprop.append
				iter[0] = p.id.to_i
				iter[1] = p.prop.prop.to_s
				iter[2] = p.prop_id.to_i
				iter[3] = p.atp
				iter[4] = "-"
			end
		end
	}

	renderer = Gtk::CellRendererText.new
	comboprop.pack_start(renderer,false)
	renderer.visible=(false)
	comboprop.set_attributes(renderer, :text => 0)
	renderer1 = Gtk::CellRendererText.new
	comboprop.pack_start(renderer1,false)
	comboprop.set_attributes(renderer1, :text => 1)
	renderer2 = Gtk::CellRendererText.new
	renderer2.visible=(false)
	comboprop.pack_start(renderer2,false)
	comboprop.set_attributes(renderer2, :text => 2)
	renderer3 = Gtk::CellRendererText.new
	comboprop.pack_start(renderer3,false)
	comboprop.set_attributes(renderer3, :text => 4)
	renderer4 = Gtk::CellRendererText.new
	comboprop.pack_start(renderer4,false)
	comboprop.set_attributes(renderer4, :text => 3)
	labelprop = Gtk::Label.new("Seleziona il proprietario di destinazione:")
	boxinsaut4.pack_start(labelprop, false, false, 5)
	boxinsaut4.pack_start(comboprop, false, false, 0)

	labeldataingr = Gtk::Label.new("Data ingresso (GGMMAA):")
	boxinsaut4.pack_start(labeldataingr, false, false, 5)
	dataingr = Gtk::Entry.new
	dataingr.text = datausc
	boxinsaut4.pack_start(dataingr, false, false, 5)
	labelmod4 = Gtk::Label.new("Modello 4 di ingresso:")
	boxinsaut5.pack_start(labelmod4, false, false, 5)
	mod4ingr = Gtk::Entry.new
	mod4ingr.text = mod4
	boxinsaut5.pack_start(mod4ingr, false, false, 5)
	labeldatamod4 = Gtk::Label.new("Data modello 4:")
	boxinsaut6.pack_start(labeldatamod4, false, false, 5)
	datamod4ingr = Gtk::Entry.new
	datamod4ingr.text = datamod4usc
	boxinsaut6.pack_start(datamod4ingr, false, false, 5)

	#Motivo ingresso

	labelmotivoi = Gtk::Label.new("Motivo ingresso:")
	boxinsaut7.pack_start(labelmotivoi, false, false, 5)
	listaing = Gtk::ListStore.new(Integer, String)
	Ingressos.tutti.each do |ing|
		iteri = listaing.append
		iteri[0] = ing.id
		iteri[1] = ing.descr
	end

	comboing = Gtk::ComboBox.new(listaing)
	rendering = Gtk::CellRendererText.new
	comboing.pack_start(rendering,false)
	comboing.set_attributes(rendering, :text => 1)
	rendering = Gtk::CellRendererText.new
	rendering.visible=(false)
	comboing.pack_start(rendering,false)
	comboing.set_attributes(rendering, :text => 0)
	boxinsaut7.pack_start(comboing, false, false, 5)

	if motivousc == 3
		comboing.set_active(0)
		z = -1
		while comboing.active_iter[0] != 2
			z+=1
			comboing.set_active(z)
		end
	elsif motivousc == 20
		comboing.set_active(0)
		z = -1
		while comboing.active_iter[0] != 19
			z+=1
			comboing.set_active(z)
		end
	end

	allprov = Allevingrs.find(:first, :conditions => ["cod317 = ? and ragsoc = ?", "#{@stallaoper.stalle.cod317}", "#{@stallaoper.ragsoc.ragsoc}"])

	#Bottone di inserimento ingressi

	bottinserisci = Gtk::Button.new( "Inserisci" )
	boxinsaut9.pack_start(bottinserisci, false, false, 5)

	bottinserisci.signal_connect("clicked") {
		if comboprop.active == -1
			Errore.avviso(minsaut, "Seleziona un proprietario.")
		else
			progreg = Relazs.find(:first, :conditions => ["id = ? ", "#{comboprop.active_iter[0]}"]).progreg.split('/')
			dataingringl = @giorno.strftime("%Y")[0,2] + dataingr.text[4,2] + dataingr.text[2,2] + dataingr.text[0,2]
			datamod4ingl = @giorno.strftime("%Y")[0,2] + datamod4ingr.text[4,2] + datamod4ingr.text[2,2] + datamod4ingr.text[0,2]
			if progreg[1].to_i != dataingr.text[4,2].to_i
				Errore.avviso(minsaut, "Attenzione: il numero progressivo del registro della stalla #{alldest317} riporta l\'anno #{Time.parse("#{progreg[1]}").strftime("%Y")[0,2] + progreg[1]} mentre la data di ingresso l\'anno #{dataingringl[0,4]}; non è possibile proseguire con l\'inserimento automatico. Controllare i dati e proseguire col caricamento classico.")
			else
				progr = progreg[0].to_i
				listasel.each do |model,path,iter|
					capousc = Animals.find(:first, :conditions => ["id = ?", "#{iter[0]}"])
					progr += 1
					Animals.create(:relaz_id => "#{comboprop.active_iter[0]}", :progreg => "#{progr}/#{progreg[1]}", :ingresso_id => "#{comboing.active_iter[0]}", :marca => "#{capousc.marca}", :specie=> "#{capousc.specie}", :razza_id => "#{capousc.razza_id}", :data_nas => "#{capousc.data_nas}", :stalla_nas => "#{capousc.stalla_nas}", :sesso => "#{capousc.sesso}", :nazorig_id => "#{capousc.nazorig_id}", :naznasprimimp_id => "#{capousc.naznasprimimp_id}", :data_applm => "#{capousc.data_applm}", :ilg => "#{capousc.ilg}", :embryo => "#{capousc.embryo}", :marca_prec => "#{capousc.marca_prec}", :marca_madre => "#{capousc.marca_madre}", :marca_padre => "#{capousc.marca_padre}", :data_ingr => "#{dataingringl}", :allevingr_id => "#{allprov.id}", :nazprov_id => "#{capousc.nazprov_id}", :mod4ingr => "#{mod4}", :data_mod4ingr => "#{datamod4ingl}")
				end
			Relazs.update(comboprop.active_iter[0], { :progreg => "#{progr}/#{progreg[1]}"})
			Conferma.conferma(minsaut, "Capi inseriti correttamente.")
			minsaut.destroy
			end
		end
	}
	minsaut.show_all
end
