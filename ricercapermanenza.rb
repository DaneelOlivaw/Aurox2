# Ricerca capi per giorni di permanenza

def ricercapermanenza
	require 'stampapresgiorni'
	mvisperm = Gtk::Window.new("Ricerca capi per giorni di permanenza")
	mvisperm.set_default_size(800, 600)
	mvisperm.maximize
	mvispermscroll = Gtk::ScrolledWindow.new
	boxvisp = Gtk::VBox.new(false, 0)
	boxvisp1 = Gtk::HBox.new(false, 0)
	boxvisp2 = Gtk::HBox.new(false, 0)
	boxvisp3 = Gtk::HBox.new(false, 0)
	boxvisp.pack_start(boxvisp1, false, false, 5)
	boxvisp.pack_start(boxvisp2, false, false, 5)
	boxvisp.pack_start(boxvisp3, true, true, 5)
	mvisperm.add(boxvisp)
	selperm = 0
	giornipres = 0
	def ricercaperm(selperm, listaperm, labelcontoperm, valtipo)
		selperm.each do |m|
			iterreg = listaperm.append
			iterreg[0] = m.id.to_i
			iterreg[1] = m.progreg
			iterreg[2] = m.marca
			iterreg[3] = m.razza.cod_razza
			iterreg[4] = m.sesso
			iterreg[5] = m.marca_madre
			iterreg[6] = m.ingresso_id.to_s
			iterreg[7] = m.data_nas.strftime("%d/%m/%Y")
			iterreg[8] = m.data_ingr.strftime("%d/%m/%Y")
			if m.ingresso_id == 13 or m.ingresso_id == 23 or m.ingresso_id == 32
				if m.certsaningr.to_s != ""
					modingr = m.certsaningr
				else
					modingr = m.rifloc
				end
			else
				modingr = m.allevingr.cod317
			end
			iterreg[10] = m.mod4ingr
			iterreg[11] = m.certsaningr
			if valtipo == "presenti"
				iterreg[13] = @giorno.to_date - m.data_ingr
			else
				iterreg[13] = m.uscita - m.data_ingr
			end
			iterreg[14] = m.uscita.strftime("%d/%m/%Y") if m.uscita != nil
		end
		labelcontoperm.text = ("Movimenti trovati: #{selperm.length}")
	end

	labeltipocapi = Gtk::Label.new("Seleziona i capi interessati:")
	boxvisp1.pack_start(labeltipocapi, false, false, 5)
	tipo1 = Gtk::RadioButton.new("Presenti")
	tipo1.active=(true)
	valtipo="presenti"
	tipo1.signal_connect("toggled") {
		if tipo1.active?
			valtipo="presenti"
		end
	}
	boxvisp1.pack_start(tipo1, false, false, 5)
	tipo2 = Gtk::RadioButton.new(tipo1, "Usciti l'anno: ")
	tipo2.signal_connect("toggled") {
		if tipo2.active?
			valtipo="usciti"
		end
	}
	boxvisp1.pack_start(tipo2, false, false, 5)

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
	boxvisp1.pack_start(comboanno, false, false, 0)

	trova210 = Gtk::Button.new( "210 giorni" )
	altrigiorni = Gtk::Button.new( "giorni: " )
	altrigiornientry = Gtk::Entry.new
	labelcontoperm = Gtk::Label.new("Movimenti trovati: 0")
	listaperm = Gtk::ListStore.new(Integer, String, String, String, String, String, String, String, String, String, String, String, String, Integer, String)
	vistaperm = Gtk::TreeView.new(listaperm)
	trova210.signal_connect("clicked") {
		listaperm.clear
		giornipres = 210
		if valtipo == "presenti"
			giorno = Time.parse("#{@giorno.strftime("%Y-%m-%d")}") - 210.day
			selperm = Animals.find(:all, :conditions => ["relaz_id= ? and uscito = ? and data_ingr <= ?", "#{@stallaoper.id}", "0", "#{giorno.to_date}"])
		else
			selperm = Animals.find(:all, :select => "*, DATEDIFF(uscita,data_ingr) as perman", :conditions => ["relaz_id= ? and YEAR(uscita) = ? and DATEDIFF(uscita,data_ingr) >= ?", "#{@stallaoper.id}", "#{comboanno.active_iter[0]}", "#{giornipres}"])
		end
		ricercaperm(selperm, listaperm, labelcontoperm, valtipo)
	}
	altrigiorni.signal_connect("clicked") {
		listaperm.clear
		giornipres = altrigiornientry.text
		if valtipo == "presenti"
			giornolibero = Time.parse("#{@giorno.strftime("%Y-%m-%d")}") - altrigiornientry.text.to_i.day
			selperm = Animals.find(:all, :conditions => ["relaz_id= ? and uscito = ? and data_ingr <= ?", "#{@stallaoper.id}", "0", "#{giornolibero.strftime("%Y-%m-%d")}"])
		else
			selperm = Animals.find(:all, :select => "*, DATEDIFF(uscita,data_ingr) as perman", :conditions => ["relaz_id= ? and YEAR(uscita) = ? and DATEDIFF(uscita,data_ingr) >= ?", "#{@stallaoper.id}", "#{comboanno.active_iter[0]}", giornipres])
			selperm.each do |s|
			end
		end
		ricercaperm(selperm, listaperm, labelcontoperm, valtipo)
	}
	cella = Gtk::CellRendererText.new
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
	colonna10 = Gtk::TreeViewColumn.new("Mod. 4 ingresso", cella)
	colonna11 = Gtk::TreeViewColumn.new("Cert. san. ingresso", cella)
	colonna13 = Gtk::TreeViewColumn.new("Giorni permanenza", cella)
	colonna14 = Gtk::TreeViewColumn.new("Uscita", cella)
	colonna1.set_attributes(cella, :text => 1)
	colonna2.set_attributes(cella, :text => 2)
	colonna3.set_attributes(cella, :text => 3)
	colonna4.set_attributes(cella, :text => 4)
	colonna5.set_attributes(cella, :text => 5)
	colonna6.set_attributes(cella, :text => 6)
	colonna7.set_attributes(cella, :text => 7)
	colonna8.set_attributes(cella, :text => 8)
	colonna10.set_attributes(cella, :text => 10)
	colonna11.set_attributes(cella, :text => 11)
	colonna13.set_attributes(cella, :text => 13)
	colonna14.set_attributes(cella, :text => 14)
	vistaperm.append_column(colonna1)
	vistaperm.append_column(colonna2)
	vistaperm.append_column(colonna3)
	vistaperm.append_column(colonna4)
	vistaperm.append_column(colonna5)
	vistaperm.append_column(colonna6)
	vistaperm.append_column(colonna7)
	vistaperm.append_column(colonna8)
	vistaperm.append_column(colonna10)
	vistaperm.append_column(colonna11)
	vistaperm.append_column(colonna13)
	vistaperm.append_column(colonna14)
	mvispermscroll.add(vistaperm)
	boxvisp3.pack_start(mvispermscroll, true, true, 0)
	boxvisp2.pack_start(trova210, false, false, 0)
	boxvisp2.pack_start(altrigiorni, false, false, 5)
	boxvisp2.pack_start(altrigiornientry, false, false, 0)
	boxvisp2.pack_start(labelcontoperm, false, false, 5)
	bottstampa = Gtk::Button.new( "Stampa" )
	bottstampa.signal_connect("clicked") {
		stampapresgiorni(selperm, giornipres, selperm.length, valtipo)
	}
	boxvisp.pack_start(bottstampa, false, false, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mvisperm.destroy
	}
	boxvisp.pack_start(bottchiudi, false, false, 0)
	mvisperm.show_all
end
