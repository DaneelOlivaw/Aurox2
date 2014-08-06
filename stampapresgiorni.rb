# Stampa registro ingresso

def stampapresgiorni(capi, giorni, numcapi, valtipo)
	foglio = Prawn::Document.new(:page_size => "A4", :page_layout => :portrait, :top_margin => 5.mm, :left_margin => 6.mm, :right_margin => 10.mm, :bottom_margin => 15.mm, :compress => true, :info => {:Title => "Capi permanenza", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now})
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

	foglio.font "Helvetica"
	foglio.font_size 8
	foglio.repeat :all do
		foglio.text "CAPI PRESENTI NELLA STALLA #{@stallaoper.stalle.cod317} DA ALMENO #{giorni}  GIORNI: #{numcapi}"
		foglio.text "RAGIONE SOCIALE:  #{@stallaoper.ragsoc.ragsoc}"
		foglio.text "DETENTORE:  #{detentore}  -  PROPRIETARIO:  #{proprietario}"
	end

	data = Array.new
	largcol = []
	data = [["Numero ordine", "Marchio di identificazione", "Razza", "Sesso", "Codice della madre", "Nato / acquisto", "Data di nascita", "Data di ingresso", "Giorni di presenza", "Data di uscita"]]
	capi.each do |i, index|
		if i.ingresso_id == 1 or i.ingresso_id == 7
			tipoingr = "N"
		else
			tipoingr = "A"
		end
		if valtipo == "presenti"
				giorni = @giorno.to_date - i.data_ingr
				datauscita = ""
		else
			giorni = i.uscita - i.data_ingr
			datauscita = i.uscita.strftime("%d/%m/%Y")
		end
		data << ["#{i.progreg}", "#{i.marca}", "#{i.razza.cod_razza}", "#{i.sesso}", "#{i.marca_madre}", tipoingr, "#{i.data_nas.strftime("%d/%m/%Y")}", "#{i.data_ingr.strftime("%d/%m/%Y")}", giorni, datauscita]
		largcol = [40, 90, 35, 35, 76, 40, 55, 55]
	end
	if data.length != 0
		foglio.bounding_box([0, foglio.cursor], :width => 816) do
			foglio.table(data) do |tabella|
				tabella.column_widths = largcol
				tabella.cell_style = {:size => 8, :padding => [2, 3]}
				tabella.header = true
				tabella.column(0).align = :right
				tabella.row(0).style(:align => :center, :font_style => :bold)
			end
		end
		options = {:at => [foglio.bounds.right - 135, 0], :width => 150, :align => :right, :size => 8}
		string = "pag. <page> di <total>"
		foglio.number_pages string, options
		foglio.render_file "#{@dir}/altro/registro_generico.pdf"

		if @sistema == "linux"
			system("evince #{@dir}/altro/registro_generico.pdf")
		else
			@shell.ShellExecute('.\altro\registro_generico.pdf', '', '', 'open', 3)
		end
	end
end
