#Importa database

def selezionadatabase(finestra, importadb)

	selezione = Gtk::FileChooserDialog.new("Seleziona il file da importare", finestra, Gtk::FileChooser::ACTION_OPEN, nil, [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL], [Gtk::Stock::OPEN, Gtk::Dialog::RESPONSE_ACCEPT])
	selezione.current_folder=("#{@dir}/importadb")
	filtro = Gtk::FileFilter.new
	filtro.add_pattern("*.sql")
	selezione.filter=(filtro)
	if selezione.run == Gtk::Dialog::RESPONSE_ACCEPT
		require 'chiedipassword'
		chiedipassword(selezione.filename, "importadb")
		selezione.destroy
	end
end
