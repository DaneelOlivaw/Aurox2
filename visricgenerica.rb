# Visualizza registro

def visricgenerica(selrg, datainizio, datafine, orientamento)
	mvisrg = Gtk::Window.new("Vista registro")
	#mvisrg.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mvisrg.set_default_size(800, 600)
	mvisrg.maximize
	mvisrgscroll = Gtk::ScrolledWindow.new #(hadjustment = nil, vadjustment = nil)
	boxrgv = Gtk::VBox.new(false, 0)
	boxrg1 = Gtk::HBox.new(false, 0)
	boxrg2 = Gtk::HBox.new(false, 0)
	boxrgv.pack_start(boxrg1, false, false, 5)
	boxrgv.pack_start(boxrg2, true, true, 5)
	mvisrg.add(boxrgv)
=begin
	def ricercareg(selrg, listarg, labelcontorg)
		selrg.each do |m|
			iterreg = listarg.append
			iterreg[0] = m.id.to_i
			iterreg[1] = m.progressivo
			iterreg[2] = m.marca
			iterreg[3] = m.razza
			iterreg[4] = m.sesso
			iterreg[5] = m.madre
			iterreg[6] = m.tipoingresso
			iterreg[7] = m.datanascita.strftime("%d/%m/%Y")
			iterreg[8] = m.dataingresso.strftime("%d/%m/%Y")
			iterreg[9] = m.provenienza
			iterreg[10] = m.tipouscita
			if m.datauscita != nil
				iterreg[11] = m.datauscita.strftime("%d/%m/%Y")
			else
				iterreg[11] = ""
			end
			iterreg[12] = m.destinazione
			iterreg[13] = m.marcaprec
			iterreg[14] = m.mod4ingr
			iterreg[15] = m.mod4usc
			iterreg[16] = m.certsaningr
			iterreg[17] = m.certsanusc
			iterreg[18] = m.ragsoc
		end
		labelcontorg.text = ("Movimenti trovati: #{selrg.length}")
	end
=end
#	regingressi = Gtk::Button.new( "Visualizza ingressi" )
#	reguscite = Gtk::Button.new( "Visualizza uscite" )
#	regpresenti = Gtk::Button.new( "Visualizza presenti in stalla" )
#	regricerca = Gtk::Button.new( "Cerca capo" )
#	regricercaentry = Gtk::Entry.new
	labelcontorg = Gtk::Label.new("Movimenti trovati: 0")
	listarg = Gtk::ListStore.new(Integer, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String, String)
	vistarg = Gtk::TreeView.new(listarg)
	#puts vistarg.headers_clickable?
	vistarg.headers_clickable = true
	#puts vistarg.headers_clickable?
	vistarg.headers_visible = true
	vistarg.selection.mode = Gtk::SELECTION_SINGLE #BROWSE #SINGLE #MULTIPLE
#	vistarg.show_expanders = (true)
	vistarg.rules_hint = true
	disordine = Array.new
	ordine = Array.new
	riempimentoricgen(selrg, listarg, labelcontorg, datainizio, datafine, disordine)
	#puts disordine.inspect
#	vistarg.set_enable_grid_lines(true)

#	regingressi.signal_connect("clicked") {
#		listarg.clear
#		selrg = Registros.find(:all, :conditions => ["relaz_id= ?", "#{@stallaoper.id}"])
#		ricercareg(selrg, listarg, labelcontorg)
#	}
#	reguscite.signal_connect("clicked") {
#		listarg.clear
#		selrg = Registros.find(:all, :conditions => ["relaz_id= ? and tipouscita IS NOT NULL", "#{@stallaoper.id}"], :order => "datauscita, id")
#		#selrg = Registros.find(:all, :conditions => ["relaz_id= ? and tipouscita != ?", "#{@stallaoper.id}", "NULL"], :order => "datauscita, id")
#		ricercareg(selrg, listarg, labelcontorg)
#	}

#	regpresenti.signal_connect("clicked") {
#		listarg.clear
#		selrg = Registros.find(:all, :from => 'registros', :conditions => ["relaz_id= ? and tipouscita IS NULL", "#{@stallaoper.id}"]) # and uscito='0'")
#		ricercareg(selrg, listarg, labelcontorg)
#	}
#	regricerca.signal_connect("clicked") {
#		listarg.clear
#		#selrg = Registros.find(:all, :conditions => "relaz_id='#{@stallaoper.id}' and marca LIKE '%#{regricercaentry.text}%'")
#		#ActiveRecord::Base.logger = Logger.new(STDOUT)
#		selrg = Registros.find(:all, :conditions => ["relaz_id= ? and marca LIKE ?", "#{@stallaoper.id}", "%#{regricercaentry.text}%"])
#		#Registros.find(:all, :conditions => "relaz_id='#{@stallaoper.id}' and marca LIKE '%#{regricercaentry.text}%'").to_sql
#		ricercareg(selrg, listarg, labelcontorg)
#	}
		cella = Gtk::CellRendererText.new
		colonna0 = Gtk::TreeViewColumn.new("Id", cella)
		colonna0.resizable = true
		colonna0.clickable = true
		colonna0.reorderable = true
		colonna0.sort_indicator = true

		colonna1 = Gtk::TreeViewColumn.new("Progressivo", cella)
		colonna1.resizable = true
		colonna2 = Gtk::TreeViewColumn.new("Marca", cella)
		colonna2.resizable = true
		colonna3 = Gtk::TreeViewColumn.new("Razza", cella)
		colonna4 = Gtk::TreeViewColumn.new("Sesso", cella)
		colonna5 = Gtk::TreeViewColumn.new("Madre", cella)
		colonna5.resizable = true
		colonna6 = Gtk::TreeViewColumn.new("Tipo ingresso", cella)
		colonna7 = Gtk::TreeViewColumn.new("Data di nascita", cella)
		colonna8 = Gtk::TreeViewColumn.new("Data ingresso", cella)
		colonna9 = Gtk::TreeViewColumn.new("Provenienza", cella)
		colonna10 = Gtk::TreeViewColumn.new("Tipo uscita", cella)
		colonna11 = Gtk::TreeViewColumn.new("Data uscita", cella)
		colonna12 = Gtk::TreeViewColumn.new("Destinazione", cella)
		colonna13 = Gtk::TreeViewColumn.new("Marca precedente", cella)
		colonna14 = Gtk::TreeViewColumn.new("Mod. 4 ingresso", cella)
		colonna15 = Gtk::TreeViewColumn.new("Mod. 4 uscita", cella)
		colonna16 = Gtk::TreeViewColumn.new("Cert. san. ingresso", cella)
		colonna17 = Gtk::TreeViewColumn.new("Cert. san. uscita", cella)
		colonna18 = Gtk::TreeViewColumn.new("Ragione sociale", cella)
		colonna19 = Gtk::TreeViewColumn.new("non visibile", cella)
		colonna0.set_attributes(cella, :text => 0)
		#colonna0.sort_column_id = 0
		colonna1.set_attributes(cella, :text => 1)
		colonna2.set_attributes(cella, :text => 2)
		colonna3.set_attributes(cella, :text => 3)
		colonna4.set_attributes(cella, :text => 4)
		colonna5.set_attributes(cella, :text => 5)
		colonna6.set_attributes(cella, :text => 6)
		colonna7.set_attributes(cella, :text => 7)

		colonna8.set_attributes(cella, :text => 8)
		colonna9.set_attributes(cella, :text => 9)
		colonna10.set_attributes(cella, :text => 10)
		colonna11.set_attributes(cella, :text => 11)
		colonna12.set_attributes(cella, :text => 12)
		colonna13.set_attributes(cella, :text => 13)
		colonna14.set_attributes(cella, :text => 14)
		colonna15.set_attributes(cella, :text => 15)
		colonna16.set_attributes(cella, :text => 16)
		colonna17.set_attributes(cella, :text => 17)
		colonna18.set_attributes(cella, :text => 18)
		colonna19.set_attributes(cella, :text => 19)
		colonna7.sort_column_id = 19
		vistarg.append_column(colonna0)
		vistarg.append_column(colonna1)
		vistarg.append_column(colonna2)
		vistarg.append_column(colonna3)
		vistarg.append_column(colonna4)
		vistarg.append_column(colonna5)
		vistarg.append_column(colonna6)
		vistarg.append_column(colonna7)
		vistarg.append_column(colonna8)
		vistarg.append_column(colonna9)
		vistarg.append_column(colonna10)
		vistarg.append_column(colonna11)
		vistarg.append_column(colonna12)
		vistarg.append_column(colonna13)
		vistarg.append_column(colonna14)
		vistarg.append_column(colonna15)
		vistarg.append_column(colonna16)
		vistarg.append_column(colonna17)
		vistarg.append_column(colonna18)
		vistarg.append_column(colonna19)
	mvisrgscroll.add(vistarg)
	boxrg2.pack_start(mvisrgscroll, true, true, 0)
#	boxrg1.pack_start(regingressi, false, false, 0)
#	boxrg1.pack_start(reguscite, false, false, 0)
#	boxrg1.pack_start(regpresenti, false, false, 0)
#	boxrg1.pack_start(regricerca, false, false, 5)
#	boxrg1.pack_start(regricercaentry, false, false, 0)
	boxrg1.pack_start(labelcontorg, false, false, 5)
	
	listarg.signal_connect("sort_column_changed"){
		if listarg.sort_column_id[1].inspect.include?("ascending")
			ordine = disordine.sort_by { |hsh| hsh["nascitaepoch"] }
		elsif listarg.sort_column_id[1].inspect.include?("descending")
			ordine = disordine.sort_by { |hsh| hsh["nascitaepoch"] }.reverse!
		end
		#puts ordine.inspect
#		puts "ordine"
#		puts listarg.sort_column_id.inspect
#		puts listarg.sort_column_id[1].inspect
#		puts "ascendente" if 
	}
#	listarg.signal_connect("rows_reordered"){ #? #(path, iter, new_order)
#		puts "ordine"
#	}
	bottstampa = Gtk::Button.new( "Stampa" )
	bottstampa.signal_connect("clicked") {
		if ordine == []
			#puts "vuoto"
			ordine = disordine
		else
			#puts "pieno"
		end
#		listarg.each do |m, p, i|
#			puts m.inspect
#			puts p.inspect
#			puts i.inspect
#		end
		#stampareggenerico(selrg, datainizio, datafine, orientamento)
		puts ordine[0].inspect
		stamparicgenerica(ordine, datainizio, datafine, orientamento)
	}
	boxrgv.pack_start(bottstampa, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mvisrg.destroy
	}
	boxrgv.pack_start(bottchiudi, false, false, 0)
	mvisrg.show_all
end
