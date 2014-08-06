def stampapresenti(finestra)
	selcapi = Animals.presenti2(@stallaoper.id)
	if selcapi.length > 0
		foglio = Prawn::Document.new(:page_size => "A4", :top_margin => 5.mm, :left_margin => 6.mm, :right_margin => 10.mm, :bottom_margin => 10.mm, :compress => true, :info => {:Title => "Stampa presenti in stalla", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now})
		foglio.font_size 9
		formato = foglio.font.inspect
		foglio.repeat :all do
			foglio.text "CAPI PRESENTI NELLA STALLA #{@stallaoper.stalle.cod317} IN DATA #{@giorno.strftime("%d/%m/%Y")}: #{selcapi.length}"
			foglio.move_down 2
			foglio.text "RAGIONE SOCIALE:  #{@stallaoper.prop.prop}"
			foglio.move_down 2
			if @stallaoper.detentori.detentore.length > 40
				detentore = @stallaoper.detentori.detentore[0..40] + "..."
			else
				detentore = @stallaoper.detentori.detentore
			end
			if @stallaoper.prop.prop.length > 40
				proprietario = @stallaoper.prop.prop[0..40] + "..."
			else
				proprietario = @stallaoper.prop.prop
			end
			foglio.text "DETENTORE:  #{detentore}  -  PROPRIETARIO:  #{proprietario}"
		end
		foglio.bounding_box([0, foglio.cursor-5], :width => 550) do
			data = [["Numero ordine", "Marchio di identificazione", "Razza", "Sesso", "Codice della madre", "Nato / acquisto", "Data di nascita", "Data di ingresso", "Provenienza"]]
			selcapi.each do |i|
				if i.ingresso_id == 1 or i.ingresso_id == 7
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
				data << ["#{i.progreg}", "#{i.marca}", "#{i.razza.cod_razza}", "#{i.sesso}", "#{i.marca_madre}", "#{tipoingr}", "#{i.data_nas.strftime("%d/%m/%Y")}", "#{i.data_ingr.strftime("%d/%m/%Y")}", "#{modingr}"]
			end
			foglio.table(data) do |tabella|
				tabella.column_widths = [40, 90, 35, 35, 90, 40, 55, 55]
				tabella.cell_style = {:size => 8, :padding => [2, 3]}
				tabella.header = true
				tabella.width = 550
				tabella.column(0).align = :right
				tabella.row(0).style(:align => :center, :font_style => :bold)
			end
		end
		options = {:at => [foglio.bounds.right - 135, 0], :width => 150, :align => :right, :size => 8}
		string = "pag. <page> di <total>"
		foglio.number_pages string, options
		foglio.render_file "#{@dir}/altro/presenze.pdf"

		if @sistema == "linux"
			system("evince #{@dir}/altro/presenze.pdf")
		else
			@shell.ShellExecute('.\altro\presenze.pdf', '', '', 'open', 3)
		end
	else
		Conferma.conferma(finestra, "Non ci sono dati da stampare.")
	end
end
