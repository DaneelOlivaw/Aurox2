require "compattazione"
def masccompatta
	mcompatta = Gtk::Window.new("compatta l'archivio")
	mcompatta.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxcompv = Gtk::VBox.new(false, 5)
	boxcomp1 = Gtk::HBox.new(false, 5)
	boxcomp2 = Gtk::HBox.new(false, 5)
	boxcomp3 = Gtk::HBox.new(false, 5)
	mcompatta.add(boxcompv)
	nota = Gtk::Label.new("La compattazione dell'archivio consiste\nnella copia dei dati della tabella archivio\nin un file apposito e loro cancellazione dalla tabella.\nL'operazione non è reversibile o annullabile,\nper cui si raccomanda di fare attenzione.\n")
	boxcompv.pack_start(nota, false, false, 5)
	#anni = Gtk::ListStore.new(Integer)
	arranni = []
	boxcompv.pack_start(boxcomp1, false, false, 5)
	boxcompv.pack_start(boxcomp2, false, false, 5)
	boxcompv.pack_start(boxcomp3, false, false, 5)
	#arranni = [(@giorno.strftime("%Y").to_i), (@giorno.strftime("%Y").to_i) -1, (@giorno.strftime("%Y").to_i) -2]
	capi = Archives.find(:all, :conditions => ["relaz_id= ?", "#{@stallaoper.id}"])
#	puts capi.length

#	if capi.length == 0
#		Errore.avviso(mcompatta, "Non ci sono capi da compattare.")
#		mcompatta.destroy
#	end
	capi.each do |c|
		arranni << c.data_uscita.strftime("%Y")
	end
	arranni.uniq!
	#puts arranni.inspect


	lista = Gtk::ListStore.new(String)
	arranni.each do |a|
		iter = lista.append
		iter[0] = a
	end

	comboanno = Gtk::ComboBox.new(lista)

	renderer1 = Gtk::CellRendererText.new
	comboanno.pack_start(renderer1,false)
	comboanno.set_attributes(renderer1, :text => 0)
	comboanno.active=(0)
	labelanno = Gtk::Label.new("Seleziona l'anno:")
	boxcomp1.pack_start(labelanno, false, false, 5)
	boxcomp1.pack_start(comboanno, false, false, 0)

	bottcompatta = Gtk::Button.new("Esegui la compattazione dell'archivio")
	boxcompv.pack_start(bottcompatta, false, false, 5)
	bottcompatta.signal_connect("clicked") {
	
		avviso = Gtk::MessageDialog.new(mcompatta, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Attenzione: si stanno cancellando dall'archivio i capi dell'anno #{comboanno.active_iter[0]}; procedo con l\'operazione?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			puts "DISTRUGGI!!!"
			capicomp = Archives.find(:all, :conditions => ["relaz_id= ? and YEAR(data_uscita) = ?", "#{@stallaoper.id}", "#{comboanno.active_iter[0]}"])
			puts capicomp.length
			compattazione(mcompatta, capicomp, comboanno.active_iter[0], lista)
			#creafile(window)
		else
			Conferma.conferma(mcompatta, "Operazione annullata.")
		end


	
	}


	bottchiudi = Gtk::Button.new( "Chiudi" )
	boxcompv.pack_start(bottchiudi, false, false, 5)
	bottchiudi.signal_connect("clicked") {
		mcompatta.destroy
	}
	
	
	
	
#	stampauscnv = Gtk::Button.new("Stampa registro di scarico")
#	boxcompv.pack_start(stampauscnv, false, false, 5)
#	stampaarc = Gtk::Button.new("Stampa registro nuovo")
#	boxcompv.pack_start(stampaarc, false, false, 5)
	mcompatta.show_all

	#if annicompattare.empty?
#		puts "Vuota"
#		Errore.avviso(mcompatta, "Non ci sono capi da compattare.")
#		mcompatta.destroy
#	end
end
