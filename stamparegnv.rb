def registronv(finestra, stallaoper, anno)
	capi = Animals.stamparegistronv(@stallaoper.id, anno)
	if capi.length > 0
		foglio = Prawn::Document.new(:page_size => "A4", :page_layout => :landscape, :top_margin => 10.mm, :left_margin => 5.mm, :right_margin => 10.mm, :bottom_margin => 10.mm, :compress => true, :info => {:Title => "Registro non vidimato", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now})
		foglio.font_size 9
		foglio.repeat :all do
			foglio.text "Registro non vidimato della stalla #{@stallaoper.stalle.cod317} di #{@stallaoper.ragsoc.ragsoc}",:align => :center, :style => :bold
		end
		data = [["Numero ordine", "Marchio di identificazione", "Razza", "Sesso", "Codice della madre", "N/A", "Data di nascita", "Data di ingresso", "Provenienza", "Motivo uscita", "Data uscita", "Destinazione", "Marca precedente", "Mod. 4"]]
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

			data << ["#{i.progreg}", "#{i.marca}", "#{i.razza.cod_razza}", "#{i.sesso}", "#{i.marca_madre}", "#{tipoingr}", "#{i.data_nas.strftime("%d/%m/%Y")}", "#{i.data_ingr.strftime("%d/%m/%Y")}", "#{modingr}", "#{tipousc}", "#{i.uscita.strftime("%d/%m/%Y")}", "#{destinazione}", "#{i.marca_prec}", "#{docusc}"]
		end
		foglio.bounding_box([0, foglio.cursor], :width => 815) do
		#foglio.stroke_bounds
			foglio.table(data, :column_widths => [39, 76, 33, 33, 76, 25, 52, 52, 106, 34, 52, 111, 76, 50], :cell_style => {:size => 8, :padding => [2, 2]}, :header => true) #, :width => 1000)
		end
		options = {:at => [foglio.bounds.right-135, 0], :width => 150, :align => :right, :size => 8} #, :start_count_at => 100, :total_pages => 2456}
		foglio.move_down 10
		string = "pag. <page> di <total>"
		foglio.number_pages string, options
		foglio.render_file "#{@dir}/regnv/registronv.pdf"

		if @sistema == "linux"
			system("evince #{@dir}/regnv/registronv.pdf")
		else
			@shell.ShellExecute('.\regnv\registronv.pdf', '', '', 'open', 3)
		end
	else
		Conferma.conferma(finestra, "Non ci sono dati da stampare.")
	end
end
