# Finestra di stampa vidimati

def mascvidimati
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

#	pagregcar = @stallaoper.contatori.pagregcar.split("/")
#	pagregscar = @stallaoper.contatori.pagregscar.split("/")
#	pagreg = @stallaoper.contatori.pagreg.split("/")
#	if pagregcar[1].to_i == @giorno.strftime("%y").to_i
#		npagc = pagregcar[0].to_i
#		annopagc = pagregcar[1]
#	else
#		npagc = 0
#		annopagc = @giorno.strftime("%y")
#	end
#	if pagregscar[1].to_i == @giorno.strftime("%y").to_i
#		npags = pagregscar[0].to_i
#		annopags = pagregscar[1]
#	else
#		npags = 0
#		annopags = @giorno.strftime("%y")
#	end
#	if pagreg[1].to_i == @giorno.strftime("%y").to_i
#		npagr = pagreg[0].to_i
#		annopagr = pagreg[1]
#	else
#		npagr = 0
#		annopagr = @giorno.strftime("%y")
#	end
	labelnpagine = Gtk::Label.new("Numero pagine da stampare:")
	boxvidim1.pack_start(labelnpagine, false, false, 5)
	npagine = Gtk::Entry.new()
	boxvidim1.pack_start(npagine, false, false, 5)
#	labelultimo = Gtk::Label.new("Ultimo numero stampato:")
#	boxvidim3.pack_start(labelultimo, false, false, 5)
#	nultimo = Gtk::Entry.new()
#	boxvidim3.pack_start(nultimo, false, false, 5)
#	labeltiporeg = Gtk::Label.new("Tipo di registro:")
#	boxvidim2.pack_start(labeltiporeg, false, false, 5)
#	tiporeg1 = Gtk::RadioButton.new("Carico")
#	tiporeg1.active=(true)
#	tiporeg="C"
#	nultimo.text = "#{npagc}/#{annopagc}"
#	tiporeg1.signal_connect("toggled") {
#		if tiporeg1.active?
#			tiporeg="C"
#			nultimo.text = "#{npagc}/#{annopagc}"
#		end
#	}
#	boxvidim2.pack_start(tiporeg1, false, false, 5)
#	tiporeg2 = Gtk::RadioButton.new(tiporeg1, "Scarico")
#	tiporeg2.signal_connect("toggled") {
#		if tiporeg2.active?
#			tiporeg="S"
#			nultimo.text = "#{npags}/#{annopags}"
#		end
#	}
#	boxvidim2.pack_start(tiporeg2, false, false, 5)
#	tiporeg3 = Gtk::RadioButton.new(tiporeg1, "Nuovo")
#	tiporeg3.signal_connect("toggled") {
#		if tiporeg3.active?
#			tiporeg="N"
#			nultimo.text = "#{npagr}/#{annopagr}"
#		end
#	}
#	boxvidim2.pack_start(tiporeg3, false, false, 5)
	stampavidim = Gtk::Button.new( "STAMPA" )
	boxvidim4.pack_start(stampavidim, true, false, 5)
	stampavidim.signal_connect("clicked") {
		if npagine.text == "" #or nultimo.text == ""
			Errore.avviso(mvidimati, "Mancano dei dati.")
		else
#			if tiporeg == "S"
#				orientation = :landscape
#				testotiporeg = "SCARICO"
#				inizio = 428
#			elsif tiporeg == "C"
#				orientation = :portrait
#				testotiporeg = "CARICO"
#				inizio = 303
#			else
#				orientation = :landscape
#				testotiporeg = "CARICO E SCARICO"
#				inizio = 448
#			end
			#registro = PDF::Writer.new(:paper => "A4", :orientation => orientation) # , :font_size => 5)
			registro = Prawn::Document.new(:page_size => "A4", :page_layout => :landscape, :top_margin => 7.mm, :left_margin => 10.mm, :right_margin => 10.mm, :bottom_margin => 10.mm, :compress => true, :info => {:Title => "Registro vidimato", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now}) #.generate "altro/prova2.pdf" do
			registro.font_size 8
			#registro.select_font("Helvetica")
			#registro.margins_mm(10, 10)
			#prog = nultimo.text.split('/')
			prpagina = 1 #prog[0].to_i
			#prpagina += 1
			riga = registro.cursor
			registro.repeat :all do
				#options = {:width => 150, :align => :center, :size => 9}
				#string = "REGISTRO AZIENDALE DI #{testotiporeg} BOVINI - PAG. <page> - STALLA #{@stallaoper.stalle.cod317}"
				#registro.number_pages string, options
				#puts registro.cursor
				registro.text "REGISTRO AZIENDALE N. #{@stallaoper.ultimoreg+1} - STALLA #{@stallaoper.stalle.cod317} - #{@stallaoper.stalle.via} - #{@stallaoper.stalle.comune}" #, :align => :center
				registro.text "RAGIONE SOCIALE: #{@stallaoper.ragsoc.ragsoc}" #, :align => :center
				registro.text "DETENTORE: #{@stallaoper.detentori.detentore} - PROPRIETARIO: #{@stallaoper.prop.prop}"
				registro.stroke do
					registro.horizontal_rule
				end
			end
			cont = npagine.text.to_i
			cont -= 1
			while cont != 0
				registro.start_new_page
				cont -= 1
			end
			#puts riga
			#:at => [foglio.bounds.right - 135, 0]
			#puts registro.bounds.right
			#:at => [700, riga]
			string = "PAG. <page> DI #{npagine.text}"
			options = {:at => [registro.bounds.right - string.length - 30, riga], :width => 100, :align => :left, :start_count_at => prpagina} # :size => 9}
			
			registro.number_pages string, options
			#registro.number_pages string, options
			registro.render_file "#{@dir}/vidim/vidimati.pdf"
			if @sistema == "linux"
				system("evince #{@dir}/vidim/vidimati.pdf")
			else
	#			registro.save_as('.\vidim\vidimati_ingresso.pdf')
				#@shell.ShellExecute('./vidim/vidimati.pdf', '', '', 'open', 3)
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
#					somma = npagine.text.to_i + prog[0].to_i
#					if tiporeg == "C"
#						Contatoris.update(@stallaoper.contatori.id, { :pagregcar => "#{somma}/#{prog[1]}"})
#					elsif tiporeg == "S"
#						Contatoris.update(@stallaoper.contatori.id, { :pagregscar => "#{somma}/#{prog[1]}"})
#					elsif tiporeg == "N"
#						Contatoris.update(@stallaoper.contatori.id, { :pagreg => "#{somma}/#{prog[1]}"})
#					end
						Relazs.update(@stallaoper.id, { :ultimoreg => "#{@stallaoper.ultimoreg+1}"})
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
