def aggiornaprogramma(finestra, modo)
	#puts "aggiornaprogramma"
	output = `git fetch 2>&1`
	if output.to_s != ""
		puts output
		Parameters.update("1", {:aggiornamento => "1"})
	end
	if Parameters.parametri.aggiornamento == true
		puts "Aggiornamento pronto"
		#puts "Output = #{output}"
#	if output.include?("5")
		#puts "Ci sono modifiche"
		avviso = Gtk::MessageDialog.new(finestra, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Ci sono degli aggiornamenti al programma. Li scarico ora?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			`git pull`
			Conferma.conferma(finestra, "Aggiornamento eseguito con successo. Chiudere il programma e riavviarlo.")
			Parameters.update("1", {:aggiornamento => "0"})
		else
			Conferma.conferma(finestra, "L'aggiornamento non sarà eseguito.")
		end
	else
		if modo == "manuale"
			Conferma.conferma(finestra, "Non ci sono aggiornamenti disponibili.")
		end
		#puts "Nessuna modifica"
	end
end
