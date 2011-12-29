def aggiornaprogramma(finestra, modo)
	puts "aggiornaprogramma"
	if `git remote update`.include?("Counting objects")
		puts "Ci sono modifiche"
		avviso = Gtk::MessageDialog.new(finestra, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Ci sono degli aggiornamenti al programma. Li scarico ora?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			`git pull`
			Conferma.conferma(finestra, "Aggiornamento eseguito con successo. Chiudere il programma e riavviarlo.")
		else
			Conferma.conferma(finestra, "L'aggiornamento non sarà eseguito.")
		end
	else
		if modo == "manuale"
			Conferma.conferma(finestra, "Non ci sono aggiornamenti disponibili.")
		end
		puts "Nessuna modifica"
	end
end
