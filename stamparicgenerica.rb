# Stampa registro ingresso

def stamparicgenerica(ordine, datainizio, datafine, orientamento)
	if orientamento == "portrait"
		foglio = Prawn::Document.new(:page_size => "A4", :page_layout => :portrait, :top_margin => 5.mm, :left_margin => 6.mm, :right_margin => 10.mm, :bottom_margin => 15.mm, :compress => true, :info => {:Title => "Capi per data", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now})
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
	else
		foglio = Prawn::Document.new(:page_size => "A4", :page_layout => :landscape, :top_margin => 5.mm, :left_margin => 6.mm, :right_margin => 10.mm, :bottom_margin => 15.mm, :compress => true, :info => {:Title => "Capi per data", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now})
		detentore = @stallaoper.detentori.detentore
		proprietario = @stallaoper.prop.prop
	end
	if datafine == ""
		fine = @giorno.strftime("%d/%m/%Y")
	else
		fine = datafine
	end
	foglio.font "Helvetica"
	foglio.font_size 8
	foglio.repeat :all do
		foglio.text "MOVIMENTI DELLA STALLA #{@stallaoper.stalle.cod317} DAL #{datainizio} AL #{fine}: #{ordine.length}"
		foglio.text "RAGIONE SOCIALE:  #{@stallaoper.ragsoc.ragsoc}"
		foglio.text "DETENTORE:  #{detentore}  -  PROPRIETARIO:  #{proprietario}"
	end

	largcol = []
	selcapi = Array.new
	if orientamento == "portrait"
		data = [["Numero ordine", "Marchio di identificazione", "Razza", "Sesso", "Codice della madre", "Nato / acquisto", "Data di nascita", "Data di ingresso", "Provenienza"]]
		ordine.each do |i|
			if i["tipoingresso"] == 1 or i["tipoingresso"] == 7
				tipoingr = "N"
			else
				tipoingr = "A"
			end
			largcol = [40, 90, 35, 35, 76, 40, 55, 55, 120]
			data << ["#{i["prog"]}", "#{i["marca"]}", "#{i["razza"]}", "#{i["sesso"]}", "#{i["madre"]}", "#{tipoingr}", "#{i["datanascita"]}", "#{i["dataingresso"]}", "#{i["provenienza"]}"]
		end
	else
		data = [["Numero ordine", "Marchio di identificazione", "Razza", "Sesso", "Codice della madre", "N/A", "Data di nascita", "Data di ingresso", "Provenienza", "Motivo uscita", "Data uscita", "Destinazione", "Marca precedente", "Mod. 4 / cert. san."]]
		ordine.each do |i|
			if i["tipoingresso"].to_i == 1
				tipoingr = "N"
			else
				tipoingr = "A"
			end
			if i["tipouscita"].to_s != ""
				if i["tipouscita"].to_i == 4
					tipousc = "M"
					docusc = i["certsanusc"]
				elsif i["tipouscita"].to_i == 6
					tipousc = "F"
					docusc = ""
				else
					tipousc = "V"
					mod4 = i["mod4usc"].split("/")
					mod4anno = mod4[1]
					mod4num = mod4[2]
					docusc = mod4num + "/" + mod4anno.to_s[2,2]
				end
			end
			largcol = [40, 76, 33, 33, 76, 25, 52, 52, 106, 34, 52, 111, 76, 50]
			data << ["#{i["prog"]}", "#{i["marca"]}", "#{i["razza"]}", "#{i["sesso"]}", "#{i["madre"]}", "#{tipoingr}", "#{i["datanascita"]}", "#{i["dataingresso"]}", "#{i["provenienza"]}", "#{tipousc}", "#{i["datauscita"]}", "#{i["destinazione"]}", "#{i["marcaprec"]}", "#{docusc}"]
		end

	end
	foglio.bounding_box([0, foglio.cursor], :width => 816) do
		foglio.table(data) do |tabella|
			tabella.column_widths = largcol
			tabella.cell_style = {:size => 8, :padding => [2, 3]}
			tabella.header = true
			tabella.column(11).single_line = true
			tabella.column(0).align = :right
			tabella.column(13).align = :right
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
