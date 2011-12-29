def mascallmod4
	mallmod4 = Gtk::Window.new("Stampa dell'allegato al Modello 4")
	mallmod4.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxallmod4v = Gtk::VBox.new(false, 0)
	boxallmod41 = Gtk::HBox.new(false, 5)
	boxallmod42 = Gtk::HBox.new(false, 5)
	boxallmod43 = Gtk::HBox.new(false, 5)
	boxallmod4v.pack_start(boxallmod41, false, false, 5)
	boxallmod4v.pack_start(boxallmod42, false, false, 5)
	boxallmod4v.pack_start(boxallmod43, false, false, 5)
	mallmod4.add(boxallmod4v)
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

	stampa = Gtk::Button.new("Stampa l'allegato")
	boxallmod43.pack_start(stampa, false, false, 5)
	stampa.signal_connect("clicked") {
		capi = Animals.find(:all, :from => "animals", :conditions => ["relaz_id= ? and mod4usc= ?", "#{@stallaoper.id}", "#{@stallaoper.stalle.cod317}/#{comboanno.active_iter[0]}/#{m4.text}"])
		if capi.length == 0
			Errore.avviso(mallmod4, "Questo modello 4 non esiste.") #.avvia
		else
			stampaallegato(m4, comboanno.active_iter[0], capi)
		end
	}
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mallmod4.destroy
	}
	boxallmod4v.pack_start(bottchiudi, false, false, 0)
	mallmod4.show_all
end

def stampaallegato(m4, anno, capi)
	foglio = Prawn::Document.new(:page_size => "A4", :top_margin => 5.mm, :left_margin => 25.mm, :right_margin => 15.mm, :bottom_margin => 10.mm, :compress => true, :info => {:Title => "Stampa allegato mod. 4", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now}) #.generate "altro/prova2.pdf" do
	foglio.repeat :all do
		foglio.text "Azienda agricola #{@stallaoper.ragsoc.ragsoc}\nAllegato del Modello 4 #{@stallaoper.stalle.cod317}/#{anno}/#{m4.text} - Capi totali: #{capi.length}",:align => :center, :style => :bold
	end
	stringa = String.new
	capi.each do |i|
		stringa += (i.marca.ljust(14) + '  ')
	end
	foglio.move_down 5
	foglio.bounding_box([0, foglio.cursor], :width => 490) do
		foglio.font("Courier")
		foglio.text(stringa, :align => :left, :font_size => 12, :leading => -2.5)
		#foglio.stroke_bounds
	end
	foglio.font "Helvetica"
	options = {:at => [foglio.bounds.right - 135, 0], :width => 150, :align => :right, :size => 8}
	string = "pag. <page> di <total>"
	foglio.number_pages string, options
	foglio.render_file "#{@dir}/altro/allegato.pdf"

	if @sistema == "linux"
		system("evince #{@dir}/altro/allegato.pdf")
	else
#		foglio.save_as('.\altro\allegato.pdf')
		@shell.ShellExecute('.\altro\allegato.pdf', '', '', 'open', 3)
	end
end
