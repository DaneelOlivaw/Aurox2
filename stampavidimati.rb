# Finestra di stampa vidimati

def stampavidimati
	mvidimati = Gtk::Window.new("Stampa fogli da vidimare")
	mvidimati.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boxvidimv = Gtk::VBox.new(false, 0)
	boxvidim1 = Gtk::HBox.new(false, 5)
	boxvidim2 = Gtk::HBox.new(false, 5)
	boxvidim3 = Gtk::HBox.new(false, 5)
	boxvidim4 = Gtk::HBox.new(false, 5)
	boxvidimv.pack_start(boxvidim1, false, false, 5)
	boxvidimv.pack_start(boxvidim2, false, false, 5)
	boxvidimv.pack_start(boxvidim3, false, false, 5)
	boxvidimv.pack_start(boxvidim4, false, false, 5)
	mvidimati.add(boxvidimv)

	labelnreg = Gtk::Label.new("Registro aziendale numero: #{@stallaoper.ultimoreg+1}")
	boxvidim1.pack_start(labelnreg, false, false, 5)
	labelnpagine = Gtk::Label.new("Numero pagine da stampare:")
	boxvidim2.pack_start(labelnpagine, false, false, 5)
	npagine = Gtk::Entry.new()
	boxvidim2.pack_start(npagine, false, false, 5)

	stampavidim = Gtk::Button.new( "STAMPA" )
	boxvidim4.pack_start(stampavidim, true, false, 5)
	stampavidim.signal_connect("clicked") {
		if npagine.text == "" #or nultimo.text == ""
			Errore.avviso(mvidimati, "Mancano dei dati o sono stati inseriti non correttamente.")
		else
			registro = Prawn::Document.new(:page_size => "A4", :page_layout => :landscape, :top_margin => 7.mm, :left_margin => 10.mm, :right_margin => 10.mm, :bottom_margin => 10.mm, :compress => true, :info => {:Title => "Registro vidimato", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now})
			registro.font_size 8
			prpagina = 1
			riga = registro.cursor
			registro.repeat :all do
				registro.text "REGISTRO AZIENDALE N. #{@stallaoper.ultimoreg+1} - STALLA #{@stallaoper.stalle.cod317} - #{@stallaoper.stalle.via} - #{@stallaoper.stalle.comune}"
				registro.text "RAGIONE SOCIALE: #{@stallaoper.ragsoc.ragsoc}"
				registro.text "DETENTORE: #{@stallaoper.detentori.detentore} - PROPRIETARIO: #{@stallaoper.prop.prop}"
				registro.stroke do
					registro.horizontal_rule
				end
			end
			(2..npagine.text.to_i).each do
				registro.start_new_page
			end
			string = "PAG. <page> DI #{npagine.text}"
			options = {:at => [registro.bounds.right - string.length - 30, riga], :width => 100, :align => :left, :start_count_at => prpagina} # :size => 9}
			registro.number_pages string, options
			registro.render_file "#{@dir}/vidim/vidimati.pdf"
			if @sistema == "linux"
				system("evince #{@dir}/vidim/vidimati.pdf")
			else
				@shell.ShellExecute('.\vidim\vidimati.pdf', '', '', 'open', 3)
			end

			avviso = Gtk::MessageDialog.new(mvidimati, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "La stampa è stata eseguita correttamente?")
			risposta = avviso.run
			avviso.destroy
			if risposta == Gtk::Dialog::RESPONSE_YES
				avviso2 = Gtk::MessageDialog.new(mvidimati, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Procedo con l'aggiornamento dei dati?")
				risposta2 = avviso2.run
				avviso2.destroy
				if risposta2 == Gtk::Dialog::RESPONSE_YES
						Relazs.update(@stallaoper.id, { :ultimoreg => "#{@stallaoper.ultimoreg+1}"})
						@stallaoper.ultimoreg +=1
				else
					Conferma.conferma(mvidimati, "I dati non sono stati aggiornati.")
				end
			else
				Conferma.conferma(mvidimati, "Si dovrà rilanciare la stampa.")
			end
		end
	}
	bottchiudi = Gtk::Button.new( "CHIUDI" )
	bottchiudi.signal_connect("clicked") {
		mvidimati.destroy
	}
	boxvidim4.pack_start(bottchiudi, true, false, 0)
	mvidimati.show_all
end
