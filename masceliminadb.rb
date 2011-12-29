def eliminadb(password)
	begin
		con = Mysql.new("localhost", "aurox", "#{password}")
	rescue Exception => errore
		Errore.avviso(nil, "La password è sbagliata.")
		password = nil
		mchiedipassword(nil, "cancelladb")
	else
		meliminadb = Gtk::Window.new("Lista database di sicurezza")
		meliminadb.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
		meliminadb.set_default_size(400, 490)
		boxeliminadbv = Gtk::VBox.new(false, 5)
		boxeliminadb1 = Gtk::HBox.new(false, 5)
		boxeliminadb2 = Gtk::HBox.new(false, 5)
		boxeliminadb3 = Gtk::HBox.new(false, 5)
		boxeliminadb4 = Gtk::HBox.new(false, 5)
		boxeliminadbv.pack_start(boxeliminadb1, false, false, 5)
		boxeliminadbv.pack_start(boxeliminadb2, false, false, 5)
		boxeliminadbv.pack_start(boxeliminadb3, true, true, 5)
		boxeliminadbv.pack_start(boxeliminadb4, false, false, 5)
		meliminadb.add(boxeliminadbv)
		descrizione = Gtk::Label.new("Lista delle copie di sicurezza del database del programma.\nSi raccomanda di eliminare solo le meno recenti,\nin quanto l'operazione non è reversibile.")
		boxeliminadb1.pack_start(descrizione, true , false, 0)
		seltutti = Gtk::Button.new( "Seleziona tutti" )
		boxeliminadb2.pack_start(seltutti, true , false, 0)
		elimina = Gtk::Button.new( "Elimina" )
		boxeliminadb4.pack_start(elimina, true , false, 0)
		listaeliminadb = Gtk::ListStore.new(String, String)
		con.list_dbs.each do |db|
			if db.start_with?("aurox10_")
				iter = listaeliminadb.append
				iter[0] = db
				#puts Time.parse("#{iter[0].split('_')[1]}")
				iter[1] = Time.parse("#{iter[0].split('_')[1]}").strftime("%d/%m/%Y - %H:%M").to_s
			end
		end
		meliminadbscroll = Gtk::ScrolledWindow.new
		vistaeliminadb = Gtk::TreeView.new(listaeliminadb)
		vistaeliminadb.selection.mode = Gtk::SELECTION_MULTIPLE
		cella = Gtk::CellRendererText.new
		colonna0 = Gtk::TreeViewColumn.new("database", cella)
		colonna0.resizable = true
		colonna0.set_attributes(cella, :text => 0)
		vistaeliminadb.append_column(colonna0)
		cella = Gtk::CellRendererText.new
		colonna1 = Gtk::TreeViewColumn.new("Creato il", cella)
		colonna1.resizable = true
		colonna1.set_attributes(cella, :text => 1)
		vistaeliminadb.append_column(colonna1)
		meliminadbscroll.add(vistaeliminadb)
		seltutti.signal_connect("clicked") {
			vistaeliminadb.selection.select_all
		}
		elimina.signal_connect("clicked") {
			avviso = Gtk::MessageDialog.new(meliminadb, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Le copie selezionate saranno eliminate definitivamente. Procedo?")
			risposta = avviso.run
			avviso.destroy
			if risposta == Gtk::Dialog::RESPONSE_YES
				 #puts "distruggere"
				cancellare = []
				dbsel = vistaeliminadb.selection
				dbsel.selected_each do |model, path, iter|
					cancellare.push(Gtk::TreeRowReference.new(model,path))
					#puts iter[0]
					`mysql -u aurox -p"#{password}" --execute="drop database #{iter[0]}"`
				end
				cancellare.each do |c|
					(path = c.path) and listaeliminadb.remove(listaeliminadb.get_iter(path))
				end
				Conferma.conferma(meliminadb, "Operazione eseguita.")
				password = nil
			else
				Conferma.conferma(meliminadb, "Operazione annullata.")
				password = nil
			end
		}
		boxeliminadb3.pack_start(meliminadbscroll, true, true, 0)
		bottchiudi = Gtk::Button.new( "Chiudi" )
		bottchiudi.signal_connect("clicked") {
			password = nil
			meliminadb.destroy
		}
		boxeliminadb2.pack_start(bottchiudi, true, false, 0)
		meliminadb.show_all

	end
#	end
end
