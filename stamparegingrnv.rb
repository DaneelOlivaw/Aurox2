require 'stamparegnv'
def mascregnonvidim
	mregnonvidim = Gtk::Window.new("Stampa registro non vidimato")
	mregnonvidim.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxregnvv = Gtk::VBox.new(false, 0)
	boxregnv1 = Gtk::HBox.new(false, 5)
	boxregnv2 = Gtk::HBox.new(false, 5)
	boxregnv3 = Gtk::HBox.new(false, 5)
	boxregnvv.pack_start(boxregnv1, false, false, 5)
	boxregnvv.pack_start(boxregnv2, false, false, 5)
	boxregnvv.pack_start(boxregnv3, false, false, 5)
	mregnonvidim.add(boxregnvv)

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
	boxregnv1.pack_start(labelanno, false, false, 5)
	boxregnv1.pack_start(comboanno, false, false, 0)

	stampaingrnv = Gtk::Button.new("Stampa registro di carico")
	boxregnvv.pack_start(stampaingrnv, false, false, 5)
	stampauscnv = Gtk::Button.new("Stampa registro di scarico")
	boxregnvv.pack_start(stampauscnv, false, false, 5)
	stamparegnv = Gtk::Button.new("Stampa registro nuovo")
	boxregnvv.pack_start(stamparegnv, false, false, 5)

	stampaingrnv.signal_connect("clicked") {
		#rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
#		if Animals.find(:first, :conditions => ["contatori_id= ? and YEAR(data_ingr) = ?", "#{@stallaoper.contatori_id}", "#{comboanno.active_iter[0]}"]) == nil
#			Conferma.conferma(mregnonvidim, "Nessun capo presente.")
#		else
#			conto = Animals.find(:first, :conditions => ["contatori_id= ? and YEAR(data_ingr) = ?", "#{@stallaoper.contatori_id}", "#{comboanno.active_iter[0]}"])
			#puts conto.class
			#puts conto
			registroingrnv(comboanno.active_iter[0])
		#end
	}
	stampauscnv.signal_connect("clicked") {
		#rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
		#if Animals.find(:all, :conditions => ["contatori_id= ? and uscite_id != 'null' and YEAR(uscita) = ?", "#{@stallaoper.contatori_id}", "#{comboanno.active_iter[0]}"], :order => ["uscita, id"]).length == 0
		#	Conferma.conferma(mregnonvidim, "Nessun capo presente.")
		#else
			registrouscnv(mregnonvidim, @stallaoper.contatori_id, comboanno.active_iter[0])
		#end
	}
	stamparegnv.signal_connect("clicked") {
		#rel = Relazs.find(:first, :conditions => "id = '#{@stallaoper.id}'")
		#if Animals.find(:all, :conditions => ["contatori_id= ? and uscito = ? and YEAR(uscita) = ?", "#{@stallaoper.contatori_id}", "1", "#{comboanno.active_iter[0]}"], :order => ["data_ingr, id"]).length == 0
		#	Conferma.conferma(mregnonvidim, "Nessun capo presente.")
		#else
			registronv(mregnonvidim, @stallaoper.contatori_id, comboanno.active_iter[0])
		#end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mregnonvidim.destroy
	}
	boxregnvv.pack_start(bottchiudi, false, false, 0)
	mregnonvidim.show_all
end

def registroingrnv(anno)
	capi = Animals.stamparegistroingrnv(@stallaoper.contatori_id, anno)
	if capi.length > 0
		#foglio = PDF::Writer.new(:paper => "A4") # , :font_size => 5)
		foglio = Prawn::Document.new(:page_size => "A4", :top_margin => 15.mm, :left_margin => 10.mm, :right_margin => 10.mm, :bottom_margin => 10.mm, :compress => true, :info => {:Title => "Registro non vidimato di ingresso", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now}) #.generate "altro/prova2.pdf" do
		foglio.font_size 9
		foglio.repeat :all do
			foglio.text "Registro non vidimato di carico della stalla #{@stallaoper.stalle.cod317} di #{@stallaoper.ragsoc.ragsoc}",:align => :center, :style => :bold
		end

	#	foglio.bounding_box([0, foglio.cursor], :width => 550) do
		data = [["Numero ordine", "Marchio di identificazione", "Razza", "Sesso", "Codice della madre", "Nato / acquisto", "Data di nascita", "Data di ingresso", "Provenienza"]]
		capi.each do |i, index|
			if i.ingresso_id == 1
				tipoingr = "N"
	#		elsif i.cm_ing == 19
	#			arrayreg[5] = "C"
			else
				tipoingr = "A"
			end

			if i.ingresso_id == 13 or i.ingresso_id == 23 or i.ingresso_id == 32
				if i.certsaningr.to_s != ""
					modingr = i.certsaningr
				else
					modingr = i.rifloc
				end
			else
				modingr = i.allevingr.cod317
			end
				data << ["#{i.progreg}", "#{i.marca}", "#{i.razza.cod_razza}", "#{i.sesso}", "#{i.marca_madre}", "#{tipoingr}", "#{i.data_nas.strftime("%d/%m/%Y")}", "#{i.data_ingr.strftime("%d/%m/%Y")}", "#{modingr}"]
		end
		foglio.bounding_box([0, foglio.cursor], :width => 550) do
			#puts data.inspect
			foglio.table(data, :column_widths => [40, 90, 35, 35, 90, 40, 55, 55], :cell_style => {:size => 8, :padding => [2, 2]}, :header => true, :width => 550)
		#foglio.stroke_bounds
		end
			options = {:at => [foglio.bounds.right - 135, 0], :width => 150, :align => :right, :size => 8}
			string = "pag. <page> di <total>"
			foglio.number_pages string, options
			#puts foglio.compression_enabled?
			foglio.render_file "#{@dir}/regnv/registro_ingressonv.pdf"
		if @sistema == "linux"
			system("evince #{@dir}/regnv/registro_ingressonv.pdf")
		else
	#		foglio.save_as('.\regnv\registro_ingressonv.pdf')
	#		@shell.ShellExecute('./regnv/registro_ingressonv.pdf', '', '', 'open', 3)
			@shell.ShellExecute('.\regnv\registro_ingressonv.pdf', '', '', 'open', 3)
		end
	else
		Conferma.conferma(mascregnonvidim, "Non ci sono dati da stampare.")
	end
end
