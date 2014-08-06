def visdocumuscita(arrdoc, tipodocumento, documento, combonazdest, comboalldest, combomacdest, combotrasp, combomovusc, datausc, certsan, datacertsan, mod4, datamod4, labeltotcapi)
	mvisdocusc = Gtk::Window.new("Selezione documento di uscita")
	mvisdocusc.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	mvisdocusc.set_default_size(700, 400)
	mvisdocuscscroll = Gtk::ScrolledWindow.new
	boxmovv = Gtk::VBox.new(false, 0)
	boxmov1 = Gtk::HBox.new(false, 0)
	boxmov2 = Gtk::HBox.new(false, 0)
	boxmovv.pack_start(boxmov1, false, false, 5)
	boxmovv.pack_start(boxmov2, true, true, 5)
	mvisdocusc.add(boxmovv)
	hash2 = Hash.new
	arr2 = Array.new
	lista = Gtk::ListStore.new(String, String, Integer)
	arrdoc.each do |m|
		sel = Animals.find(:all, :from => "animals", :select => "uscita", :conditions => ["relaz_id= ? and #{tipodocumento} LIKE ?", "#{@stallaoper.id}", "#{m}"])
		itermov = lista.append
		itermov[0] = m
		itermov[1] = sel[0].uscita.strftime("%d/%m/%Y")
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
	mvisdocuscscroll.add(vista)
	boxmov2.pack_start(mvisdocuscscroll, true, true, 0)
	bottchiudi = Gtk::Button.new( "Chiudi" )
	bottchiudi.signal_connect("clicked") {
		mvisdocusc.destroy
	}
	boxmovv.pack_start(bottchiudi, false, false, 0)

	vista.signal_connect("row-activated") do |view, path, column|
		selmov = vista.selection
		@arridcapi = []
		@selcapi = Animals.trovapartita(@stallaoper.id, tipodocumento, selmov.selected[0]).each {|x| @arridcapi << [x.id, x.marca]}
		@datauscingl = @selcapi[0].uscita
		documento.text = selmov.selected[0]
		unless combonazdest == nil
			combonazdest.set_active(0)
			contanazdest = -1
			if @selcapi[0].nazdest_id.to_s != ""
				while combonazdest.active_iter[0] != @selcapi[0].nazdest_id
					contanazdest+=1
					combonazdest.set_active(contanazdest)
				end
			else
				combonazdest.set_active(-1)
			end
			if @selcapi[0].allevusc_id.to_s != ""
				comboalldest.set_active(0)
				contaalldest = -1
				while comboalldest.active_iter[0] != @selcapi[0].allevusc_id.to_i
					contaalldest+=1
					comboalldest.set_active(contaalldest)
				end
				else
				comboalldest.set_active(-1)
			end

			if @selcapi[0].macelli_id.to_s != ""
				combomacdest.set_active(0)
				contamacdest = -1
				while combomacdest.active_iter[0] != @selcapi[0].macelli_id.to_i
					contamacdest+=1
					combomacdest.set_active(contamacdest)
				end
				else
				combomacdest.set_active(-1)
			end

			if @selcapi[0].trasportatori_id.to_s != ""
				combotrasp.set_active(0)
				contatrasp = -1
				while combotrasp.active_iter[0] != @selcapi[0].trasportatori_id
					contatrasp+=1
					combotrasp.set_active(contatrasp)
				end
				else
				combotrasp.set_active(-1)
			end

			combomovusc.set_active(0)
			contamovusc = -1
			while combomovusc.active_iter[0].to_i != @selcapi[0].uscite_id.to_i
				contamovusc+=1
				combomovusc.set_active(contamovusc)
			end
			datausc.text = ("#{@selcapi[0].uscita.strftime("%d%m%y")}")
			certsan.text = ("#{@selcapi[0].certsanusc}")
			if @selcapi[0].data_certsanusc != nil
				datacertsan.text = ("#{@selcapi[0].data_certsanusc.strftime("%d%m%y")}")
			end
			mod4.text = ("#{@selcapi[0].mod4usc}")
			if @selcapi[0].data_mod4usc != nil
				datamod4.text = ("#{@selcapi[0].data_mod4usc.strftime("%d%m%y")}")
			end
		end
		labeltotcapi.text = ("Capi della partita: #{@selcapi.length}")
		mvisdocusc.destroy
	end
	mvisdocusc.show_all
end
