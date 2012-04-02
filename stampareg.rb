def registronuovo(mstamparegistro)
	capi = Animals.stamparegistro(@stallaoper.id, 0)
	presenti = Animals.presenti2(@stallaoper.id).length
	if capi.length > 0
		foglio = Prawn::Document.new(:page_size => "A4", :page_layout => :landscape, :top_margin => 20.mm, :left_margin => 6.mm, :right_margin => 10.mm, :bottom_margin => 15.mm, :compress => true, :info => {:Title => "Registro vidimato", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now})
		selcapi = Array.new
		data = [["Numero ordine", "Marchio di identificazione", "Razza", "Sesso", "Codice della madre", "N/A", "Data di nascita", "Data di ingresso", "Provenienza", "Motivo uscita", "Data uscita", "Destinazione", "Marca precedente", "Mod. 4 / cert. san."]]
		capi.each do |i, index|
			if i.ingresso_id == 1
				tipoingr = "N"
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
			if i.uscite_id == 4
				tipousc = "M"
				docusc = i.certsanusc
			elsif i.uscite_id == 6
				tipousc = "F"
				docusc = ""
			else
				tipousc = "V"
				mod4 = i.mod4usc.split("/")
				mod4anno = mod4[1]
				mod4num = mod4[2]
				docusc = mod4num + "/" + mod4anno.to_s[2,2]
			end

			if i.uscite_id == 4 or i.uscite_id == 6 or i.uscite_id == 10 or i.uscite_id == 11
				destinazione = ""
			elsif i.uscite_id == 9
				destinazione = i.macelli.nomemac
			else
				destinazione = i.allevusc.cod317
			end

			if destinazione.length > 18
				destinazione = destinazione[0..16] + "..."
	#		else
	#			destinazione = i.destinazione
			end
			selcapi << i.id
			data << ["#{i.progreg}", "#{i.marca}", "#{i.razza.cod_razza}", "#{i.sesso}", "#{i.marca_madre}", "#{tipoingr}", "#{i.data_nas.strftime("%d/%m/%Y")}", "#{i.data_ingr.strftime("%d/%m/%Y")}", "#{modingr}", "#{tipousc}", "#{i.uscita.strftime("%d/%m/%Y")}", "#{destinazione}", "#{i.marca_prec}", "#{docusc}"]
		end
		foglio.bounding_box([0, foglio.cursor], :width => 816) do
		#foglio.stroke_bounds
			foglio.table(data, :column_widths => [40, 76, 33, 33, 76, 25, 52, 52, 106, 34, 52, 111, 76, 50], :cell_style => {:size => 8, :padding => [2, 2]}, :header => true) #, :width => 1000)
		end
		options = {:at => [foglio.bounds.right-135, 0], :width => 150, :align => :right, :size => 6} #, :start_count_at => 100, :total_pages => 2456}
		#foglio.move_down 10
		string = "Stampato in data #{@giorno.strftime("%d/%m/%Y")} - rimanenze: #{presenti}"
		foglio.number_pages string, options
		foglio.render_file "#{@dir}/registro/registro.pdf"

		if @sistema == "linux"
			system("evince #{@dir}/registro/registro.pdf")
			else
			@shell.ShellExecute('.\registro\registro.pdf', '', '', 'open', 3)
		end

		avviso = Gtk::MessageDialog.new(@mstamparegistro, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "La stampa è stata eseguita correttamente?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			avviso2 = Gtk::MessageDialog.new(@mstamparegistro, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Aggiorno il registro?")
			risposta2 = avviso2.run
			avviso2.destroy
			if risposta2 == Gtk::Dialog::RESPONSE_YES
				selcapi.each do |d|
					Animals.update(d, { :stampascar => "1"})
				end
				Conferma.conferma(mstamparegistro, "Il registro è stato aggiornato.")
			else
				Conferma.conferma(mstamparegistro, "Il registro non è stato aggiornato.")
			end
		else
			Conferma.conferma(mstamparegistro, "Si dovrà rilanciare la stampa.")
		end
	else
		Conferma.conferma(mstamparegistro, "Non ci sono dati da stampare.")
	end
end
