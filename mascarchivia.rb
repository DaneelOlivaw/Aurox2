require "archivia"

# L'archiviazione elimina dalla tabella "animals" tutti i capi che sono usciti dalla stalla, sono stati inviati via file e sono stati stampati nel registro.


def mascarchivia
	marchivia = Gtk::Window.new("Archivia i capi")
	marchivia.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxarcv = Gtk::VBox.new(false, 0)
	boxarc1 = Gtk::HBox.new(false, 5)
	boxarc2 = Gtk::HBox.new(false, 5)
	boxarc3 = Gtk::HBox.new(false, 5)
	boxarcv.pack_start(boxarc1, false, false, 5)
	boxarcv.pack_start(boxarc2, false, false, 5)
	boxarcv.pack_start(boxarc3, false, false, 5)
	marchivia.add(boxarcv)

	arranni = []
	arranni2 = [@giorno.strftime("%Y").to_s]
	#puts arranni2.inspect
	#arranni = [(@giorno.strftime("%Y").to_i), (@giorno.strftime("%Y").to_i) -1, (@giorno.strftime("%Y").to_i) -2]

# Controllo dei capi da archiviare e greazione delle annate selezionabili.

	capi = Animals.find(:all, :conditions => ["relaz_id= ? and uscito = ? and fileusc= ? and fileingr = ? and stampacar = ? and stampascar = ?", "#{@stallaoper.id}", "1", "1", "1", "1", "1"])
	#puts capi.length
	capi.each do |c|
		arranni << c.uscita.strftime("%Y")
	end
	arranni.uniq!
	#puts arranni.inspect

# Controllo dei capi che non possono essere archiviati e generazione delle annate da non archiviare.

	capi2 = Animals.find(:all, :conditions => ["relaz_id= ? and (uscito = ? or fileusc= ? or fileingr = ? or stampacar = ? or stampascar = ?)", "#{@stallaoper.id}", "0", "0", "0", "0", "0"])
	#puts capi2.length
	capi2.each do |c|
#		if c.uscita != nil
		arranni2 << c.data_ingr.strftime("%Y")
#		end
	end
	arranni2.uniq!
	#puts arranni2.inspect

# Creazione della lista delle annate archiviabili ( se è presente un capo che non può essere archiviato, tutta l'annata dovrà aspettare.)

	anniarchiviare = arranni - arranni2
	#puts anniarchiviare.inspect

	lista = Gtk::ListStore.new(String)
	anniarchiviare.each do |a|
		iter = lista.append
		iter[0] = a
	end

	comboanno = Gtk::ComboBox.new(lista)

	renderer1 = Gtk::CellRendererText.new
	comboanno.pack_start(renderer1,false)
	comboanno.set_attributes(renderer1, :text => 0)
	comboanno.active=(0)
	labelanno = Gtk::Label.new("Seleziona l'anno:")
	boxarc1.pack_start(labelanno, false, false, 5)
	boxarc1.pack_start(comboanno, false, false, 0)

	bottarchivia = Gtk::Button.new("Esegui l\'archiviazione dei capi")
	boxarcv.pack_start(bottarchivia, false, false, 5)
	bottarchivia.signal_connect("clicked") {
	
		avviso = Gtk::MessageDialog.new(marchivia, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Attenzione: la procedura sposterà i capi dell\'anno selezionato dall\'attuale tabella di lavoro a quella di archivio; procedo con l\'operazione?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			puts "DISTRUGGI!!!"
			capiarc = Animals.find(:all, :conditions => ["relaz_id= ? and YEAR(uscita) = ? and uscito = ? and fileusc= ? and fileingr = ? and stampacar = ? and stampascar = ?", "#{@stallaoper.id}", "#{comboanno.active_iter[0]}", "1", "1", "1", "1", "1"])
			puts capiarc.length
			archivia(capiarc, marchivia, lista)
			#creafile(window)
		else
			Conferma.conferma(marchivia, "Operazione annullata.")
		end


	
	}


	bottchiudi = Gtk::Button.new( "Chiudi" )
	boxarcv.pack_start(bottchiudi, false, false, 5)
	bottchiudi.signal_connect("clicked") {
		marchivia.destroy
	}
	
	
	
	
#	stampauscnv = Gtk::Button.new("Stampa registro di scarico")
#	boxarcv.pack_start(stampauscnv, false, false, 5)
#	stampaarc = Gtk::Button.new("Stampa registro nuovo")
#	boxarcv.pack_start(stampaarc, false, false, 5)
	marchivia.show_all

	if anniarchiviare.empty?
		puts "Vuota"
		Errore.avviso(marchivia, "Non ci sono capi da archiviare.")
		marchivia.destroy
	end
end
