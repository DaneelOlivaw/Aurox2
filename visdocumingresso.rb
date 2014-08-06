def visdocumingresso(arrdoc, tipodocumento, documento, combonazprov, comboallprov, combomovingr, dataingr, certsan, rifloc, mod4, datamod4, labeltotcapi)
	mvisdocingr = Gtk::Window.new("Selezione documento di ingresso")
	mvisdocingr.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mvisdocingr.set_default_size(700, 400)
	mvisdocingrscroll = Gtk::ScrolledWindow.new
	boxmovv = Gtk::VBox.new(false, 0)
	boxmov1 = Gtk::HBox.new(false, 0)
	boxmov2 = Gtk::HBox.new(false, 0)
	boxmovv.pack_start(boxmov1, false, false, 5)
	boxmovv.pack_start(boxmov2, true, true, 5)
	mvisdocingr.add(boxmovv)
	hash2 = Hash.new
	arr2 = Array.new
	lista = Gtk::ListStore.new(String, String, Integer)
	arrdoc.each do |m|
		sel = Animals.find(:all, :select => "data_ingr", :from => "animals", :conditions => ["relaz_id= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "#{m}"])
		itermov = lista.append
		itermov[0] = m
		itermov[1] = sel[0].data_ingr.strftime("%d/%m/%Y")
		itermov[2] = sel.length
	end
	vista = Gtk::TreeView.new(lista)
	vista.selection.mode = Gtk::SELECTION_SINGLE
	vista.rules_hint = true
	cella = Gtk::CellRendererText.new
	colonna1 = Gtk::TreeViewColumn.new("Documento ingresso", cella)
	colonna1.resizable = true
	colonna1.set_attributes(cella, :text => 0)
	vista.append_column(colonna1)
	cella = Gtk::CellRendererText.new
	colonna1 = Gtk::TreeViewColumn.new("Data", cella)
	colonna1.resizable = true
	colonna1.set_attributes(cella, :text => 1)
	vista.append_column(colonna1)
	cella = Gtk::CellRendererText.new
	colonna1 = Gtk::TreeViewColumn.new("Capi", cella)
	colonna1.resizable = true
	colonna1.set_attributes(cella, :text => 2)
	vista.append_column(colonna1)
	mvisdocingrscroll.add(vista)
	boxmov2.pack_start(mvisdocingrscroll, true, true, 0)

	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mvisdocingr.destroy
	}
	boxmovv.pack_start(bottchiudi, false, false, 0)

	vista.signal_connect("row-activated") do |view, path, column|
		selmov = vista.selection
		@arridcapi = []
		@selcapi = Animals.trovapartita(@stallaoper.id, tipodocumento, selmov.selected[0]).each {|x| @arridcapi << [x.id, x.marca]}
		@dataingringl = @selcapi[0].data_ingr
		documento.text = selmov.selected[0]
		unless combonazprov == nil
			combonazprov.set_active(0)
			contanazprov = -1
			if @selcapi[0].nazprov_id != ""
				while combonazprov.active_iter[0] != @selcapi[0].nazprov_id
					contanazprov+=1
					combonazprov.set_active(contanazprov)
				end
			else
				combonazprov.set_active(-1)
			end
			if @selcapi[0].allevingr_id.to_s != ""
				comboallprov.set_active(0)
				contaallprov = -1
				while comboallprov.active_iter[0] != @selcapi[0].allevingr_id.to_i
					contaallprov+=1
					comboallprov.set_active(contaallprov)
				end
				else
				comboallprov.set_active(-1)
			end
			combomovingr.set_active(0)
			contamovingr = -1
			while combomovingr.active_iter[0].to_i != @selcapi[0].ingresso_id.to_i
				contamovingr+=1
				combomovingr.set_active(contamovingr)
			end
			dataingr.text = ("#{@selcapi[0].data_ingr.strftime("%d%m%y")}")
			if @selcapi[0].certsaningr != nil
				certsan.text = @selcapi[0].certsaningr
			end
			if @selcapi[0].rifloc != nil
				rifloc.text = @selcapi[0].rifloc
			end
			mod4.text = ("#{@selcapi[0].mod4ingr}")
			if @selcapi[0].data_mod4ingr != nil
				datamod4.text = ("#{@selcapi[0].data_mod4ingr.strftime("%d%m%y")}")
			end
		end
		@totcapi = @selcapi.length
		labeltotcapi.text = ("Capi della partita: #{@selcapi.length}")
		@documento = selmov.selected[0]
		mvisdocingr.destroy
	end
	mvisdocingr.show_all
end
