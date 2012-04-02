# Stampa registro ingresso

def stampapresgiorni(capi, giorni, numcapi, valtipo)
	#puts capi.inspect
	foglio = Prawn::Document.new(:page_size => "A4", :page_layout => :portrait, :top_margin => 7.mm, :left_margin => 5.mm, :right_margin => 13.mm, :bottom_margin => 12.mm, :compress => true, :info => {:Title => "Capi permanenza", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now})
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

	foglio.font "Helvetica"
	foglio.font_size 8
#	foglio.start_page_numbering(10, 10, 6, :center, "<PAGENUM>/08", 1)
	foglio.repeat :all do
		#testo = "<b>Movimenti della stalla #{@stallaoper.stalle.cod317} di #{@stallaoper.ragsoc.ragsoc} dal #{datainizio} al #{fine}: #{ordine.length}</b>"
		foglio.text "CAPI PRESENTI DA ALMENO #{giorni} GIORNI: #{numcapi}"
		foglio.text "RAGIONE SOCIALE:  #{@stallaoper.ragsoc.ragsoc}"
		foglio.text "DETENTORE:  #{detentore}  -  PROPRIETARIO:  #{proprietario}"
#		foglio.stroke do
#			foglio.horizontal_rule
#		end
	end

	data = Array.new
	largcol = []
	data = [["Numero ordine", "Marchio di identificazione", "Razza", "Sesso", "Codice della madre", "Nato / acquisto", "Data di nascita", "Data di ingresso", "Giorni di presenza", "Data di uscita"]]
	capi.each do |i, index|
		if i.ingresso_id == 1
			tipoingr = "N"
	#		elsif i.cm_ing == 19
	#			arrayreg[5] = "C"
		else
			tipoingr = "A"
		end
		#puts i[13]
		if valtipo == "presenti"
				giorni = @giorno.to_date - i.data_ingr
				datauscita = ""
		else
			giorni = i.uscita - i.data_ingr
			datauscita = i.uscita.strftime("%d/%m/%Y")
		end
		#data << {"prog" => i["prog"], "marca" => i["marca"], "razza" => i["razza}", "sesso" => "#{i.sesso}", "madre" => "#{i.madre}",	"nc" => "#{i.tipoingresso}", "nascita" => "#{i.datanascita}", "ingresso" => "#{i.dataingresso}", "prov" => "#{i.provenienza}"}
		data << ["#{i.progreg}", "#{i.marca}", "#{i.razza.cod_razza}", "#{i.sesso}", "#{i.marca_madre}", tipoingr, "#{i.data_nas.strftime("%d/%m/%Y")}", "#{i.data_ingr.strftime("%d/%m/%Y")}", giorni, datauscita]
		#data << ["#{i["prog"]}", "#{i["marca"]}", "#{i["razza"]}", "#{i["sesso"]}", "#{i["madre"]}", "#{tipoingr}", "#{i["datanascita"]}", "#{i["dataingresso"]}", "#{i["provenienza"]}"]
		
		largcol = [40, 90, 35, 35, 76, 40, 55, 55] #, 100, 55]
	end
	#puts data.inspect
	if data.length != 0
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
end
