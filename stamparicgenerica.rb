# Stampa registro ingresso

def stamparicgenerica(ordine, datainizio, datafine, orientamento)
	#puts orientamento
#	foglio = PDF::Writer.new(:paper => "A4", :orientation => :"{orientamento}") # , :font_size => 5)
	if orientamento == "portrait"
		#foglio = PDF::Writer.new(:paper => "A4", :orientation => :portait) # , :font_size => 5)
		foglio = Prawn::Document.new(:page_size => "A4", :page_layout => :portrait, :top_margin => 7.mm, :left_margin => 5.mm, :right_margin => 13.mm, :bottom_margin => 12.mm, :compress => true, :info => {:Title => "Capi per data", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now})
		#foglio.margins_mm(7, 5, 12, 13)
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
		#foglio = PDF::Writer.new(:paper => "A4", :orientation => :landscape) # , :font_size => 5)
		foglio = Prawn::Document.new(:page_size => "A4", :page_layout => :landscape, :top_margin => 7.mm, :left_margin => 5.mm, :right_margin => 13.mm, :bottom_margin => 12.mm, :compress => true, :info => {:Title => "Capi per data", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now})
		#foglio.margins_mm(7, 5, 12, 13)
		detentore = @stallaoper.detentori.detentore
		proprietario = @stallaoper.prop.prop
	end
	if datafine == ""
		fine = @giorno.strftime("%d/%m/%Y")
	else
		fine = datafine
	end
	#foglio.margins_mm(15, 10, 10)
	#foglio.margins_mm(7, 5, 12, 13)
	foglio.font "Helvetica"
	foglio.font_size 8
#	foglio.start_page_numbering(10, 10, 6, :center, "<PAGENUM>/08", 1)
	foglio.repeat :all do
		#testo = "<b>Movimenti della stalla #{@stallaoper.stalle.cod317} di #{@stallaoper.ragsoc.ragsoc} dal #{datainizio} al #{fine}: #{ordine.length}</b>"
		foglio.text "MOVIMENTI DELLA STALLA #{@stallaoper.stalle.cod317} DAL #{datainizio} AL #{fine}: #{ordine.length}"
		foglio.text "RAGIONE SOCIALE:  #{@stallaoper.ragsoc.ragsoc}"
		foglio.text "DETENTORE:  #{detentore}  -  PROPRIETARIO:  #{proprietario}"
#		foglio.stroke do
#			foglio.horizontal_rule
#		end
	end

	largcol = []
	selcapi = Array.new
	if orientamento == "portrait"
		data = [["Numero ordine", "Marchio di identificazione", "Razza", "Sesso", "Codice della madre", "Nato / acquisto", "Data di nascita", "Data di ingresso", "Provenienza"]]
		ordine.each do |i|
			if i["tipoingresso"] == 1
				tipoingr = "N"
	#		elsif i.cm_ing == 19
	#			arrayreg[5] = "C"
			else
				tipoingr = "A"
			end
#			if i["tipoingresso"] == 13 or i["tipoingresso"] == 23 or i["tipoingresso"] == 32
#				if i["certsaningr"].to_s != ""
#					modingr = i["certsaningr"]
#				else
#					modingr = i["rifloc"]
#				end
#			else
#				#modingr = i.allevingr.cod317
#			end
			largcol = [40, 90, 35, 35, 76, 40, 55, 55, 120]
			data << ["#{i["prog"]}", "#{i["marca"]}", "#{i["razza"]}", "#{i["sesso"]}", "#{i["madre"]}", "#{tipoingr}", "#{i["datanascita"]}", "#{i["dataingresso"]}", "#{i["provenienza"]}"]
		end
	else
		data = [["Numero ordine", "Marchio di identificazione", "Razza", "Sesso", "Codice della madre", "N/A", "Data di nascita", "Data di ingresso", "Provenienza", "Motivo uscita", "Data uscita", "Destinazione", "Marca precedente", "Mod. 4 / cert. san."]]
		ordine.each do |i|
			#puts i.marca
			if i["tipoingresso"] == 1
				tipoingr = "N"
			else
				tipoingr = "A"
			end

#			if i["tipoingresso"] == 13 or i["tipoingresso"] == 23 or i["tipoingresso"] == 32
#				if i["certsaningr"] != ""
#					modingr = i["certsaningr"]
#				else
#					modingr = i["rifloc"]
#				end
#			else
#				modingr = i.allevingr.cod317
#			end
			#puts i["tipouscita"]
			if i["tipouscita"].to_s != ""
				if i["tipouscita"] == 4
					tipousc = "M"
					docusc = i["certsanusc"]
				elsif i["tipouscita"] == 6
					tipousc = "F"
					docusc = ""
				else
					#puts i["marca"]
					tipousc = "V"
					mod4 = i["mod4usc"].split("/")
					mod4anno = mod4[1]
					mod4num = mod4[2]
					docusc = mod4num + "/" + mod4anno.to_s[2,2]
					#docusc = i["mod4usc"]
				end
			end
#			if i["tipouscita"] == 4 or i["tipouscita"] == 6 or i["tipouscita"] == 10 or i["tipouscita"] == 11
#				destinazione = ""
#			elsif i["tipouscita"] == 9
#				destinazione = i.macelli.nomemac
#			else
#				destinazione = i.allevusc.cod317
#			end

			if i["destinazione"].to_s.length > 18
				destinazione = i["destinazione"][0..16] + "..."
			else
				destinazione = i["destinazione"]
			end
			largcol = [40, 76, 33, 33, 76, 25, 52, 52, 106, 34, 52, 111, 76, 50]
			data << ["#{i["prog"]}", "#{i["marca"]}", "#{i["razza"]}", "#{i["sesso"]}", "#{i["madre"]}", "#{tipoingr}", "#{i["datanascita"]}", "#{i["dataingresso"]}", "#{i["provenienza"]}", "#{tipousc}", "#{i["datauscita"]}", "#{destinazione}", "#{i["marcaprec"]}", "#{docusc}"]
		end

	end
	foglio.bounding_box([0, foglio.cursor], :width => 816) do
	#foglio.stroke_bounds
		foglio.table(data, :column_widths => largcol, :cell_style => {:size => 8, :padding => [2, 2]}, :header => true) #, :width => 1000)
	end

	options = {:at => [foglio.bounds.right - 135, 0], :width => 150, :align => :right, :size => 8}
	string = "pag. <page> di <total>"
	foglio.number_pages string, options
	foglio.render_file "#{@dir}/altro/registro_generico.pdf"

	if @sistema == "linux"
		system("evince #{@dir}/altro/registro_generico.pdf")
	else
#			foglio.save_as('.\registro\registro_ingresso.pdf')
		@shell.ShellExecute('.\altro\registro_generico.pdf', '', '', 'open', 3)
	end
end
