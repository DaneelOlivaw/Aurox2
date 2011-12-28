# Stampa registro ingresso

def registroingr(mstamparegistro)
	capi = Animals.stamparegistroingr(@stallaoper.contatori_id, "0")
	if capi.length > 0
		foglio = Prawn::Document.new(:page_size => "A4", :top_margin => 20.mm, :left_margin => 10.mm, :right_margin => 10.mm, :bottom_margin => 8.mm, :compress => true, :info => {:Title => "Registro vidimato di ingresso", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now}) #.generate "altro/prova2.pdf" do
		foglio.font_size 8
			selcapi = Array.new
			data = [["Numero ordine", "Marchio di identificazione", "Razza", "Sesso", "Codice della madre", "Nato / acquisto", "Data di nascita", "Data di ingresso", "Provenienza"]]
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
				selcapi << i.id
				data << ["#{i.progreg}", "#{i.marca}", "#{i.razza.cod_razza}", "#{i.sesso}", "#{i.marca_madre}", "#{tipoingr}", "#{i.data_nas.strftime("%d/%m/%Y")}", "#{i.data_ingr.strftime("%d/%m/%Y")}", "#{modingr}"]
			end
			foglio.bounding_box([0, foglio.cursor], :width => 550) do
				foglio.table(data, :column_widths => [40, 90, 35, 35, 90, 40, 55, 55], :cell_style => {:padding => [2, 2]}, :header => true, :width => 550)
			#foglio.stroke_bounds
			end
	#		foglio.repeat :all do
	#			foglio.bounding_box([foglio.bounds.right - 135, 7], :width => 150, :align => :left) do
	#				foglio.text "Stampato in data #{@giorno.strftime("%d/%m/%Y")}"
	#				foglio.stroke_bounds
	#			end

	#			foglio.stroke do
	#				foglio.text "Stampato in data #{@giorno.strftime("%d/%m/%Y")}", :at => [foglio.bounds.right - 135, 0], :width => 150, :align => :right #, :size => 8
	#			end

	#		end
		options = {:at => [foglio.bounds.right - 135, 0], :width => 150, :align => :right, :size => 6}
		string = "Stampato in data #{@giorno.strftime("%d/%m/%Y")}"
		foglio.number_pages string, options
		#puts foglio.compression_enabled?
		foglio.render_file "#{@dir}/registro/registro_ingresso.pdf"
				
		if @sistema == "linux"
			system("evince #{@dir}/registro/registro_ingresso.pdf")
		else
#			foglio.save_as('.\registro\registro_ingresso.pdf')
			@shell.ShellExecute('.\registro\registro_ingresso.pdf', '', '', 'open', 3)
		end
		avviso = Gtk::MessageDialog.new(mstamparegistro, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "La stampa è stata eseguita correttamente?")
		risposta = avviso.run
		avviso.destroy
		if risposta == Gtk::Dialog::RESPONSE_YES
			avviso2 = Gtk::MessageDialog.new(mstamparegistro, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Aggiorno il registro?")
			risposta2 = avviso2.run
			avviso2.destroy
			if risposta2 == Gtk::Dialog::RESPONSE_YES
				selcapi.each do |d|
					Animals.update(d, { :stampacar => "1"})
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
