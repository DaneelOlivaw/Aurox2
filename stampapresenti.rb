require 'prawn'
require "prawn/measurement_extensions"

def stampapres(finestra)
	selcapi = Animals.presenti2(@stallaoper.id)
	if selcapi.length > 0
		foglio = Prawn::Document.new(:page_size => "A4", :top_margin => 15.mm, :left_margin => 10.mm, :right_margin => 10.mm, :bottom_margin => 10.mm, :compress => true, :info => {:Title => "Stampa presenti in stalla", :Author => "Aurox",:Creator => "Aurox", :Producer => "Prawn", :CreationDate => Time.now})

		foglio.font_size 9
		#foglio.font("Helvetica")
		formato = foglio.font.inspect
		foglio.repeat :all do
			#:align => center
			#text "Bau", :style => :bold, :align => :center
			#draw_text "Capi presenti nella stalla #{@stallaoper.stalle.cod317} di #{@stallaoper.ragsoc.ragsoc} in data #{@giorno.strftime("%d/%m/%Y")}: #{selcapi.length}", :style => :bold, :align => :center, :at => bounds.top_left
			foglio.text "Capi presenti nella stalla #{@stallaoper.stalle.cod317} di #{@stallaoper.ragsoc.ragsoc} in data #{@giorno.strftime("%d/%m/%Y")}: #{selcapi.length}",:align => :center, :style => :bold
			#foglio.draw_text "pagina <page> di <total>", :at => foglio.bounds.bottom_right
			#foglio.move_down 10
		end
		#foglio.move_down 10
		#puts foglio.cursor.inspect
		foglio.bounding_box([0, foglio.cursor], :width => 550) do

		data = [["Numero ordine", "Marchio di identificazione", "Razza", "Sesso", "Codice della madre", "Nato / acquisto", "Data di nascita", "Data di ingresso", "Provenienza"]]
		selcapi.each do |i|
			if i.ingresso_id == 1
				tipoingr = "N"
	#		elsif i.cm_ing == 19
	#			arrayreg[5] = "C"
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
		#puts data.length
		#puts formato
		#foglio.table(data, )

		foglio.table(data, :column_widths => [40, 90, 35, 35, 90, 40, 55, 55], :cell_style => {:size => 8, :padding => [2, 2]}, :header => true, :width => 550)
		#foglio.stroke_bounds
		end
		options = {:at => [foglio.bounds.right - 135, 0], :width => 150, :align => :right, :size => 8}
		string = "pag. <page> di <total>"
		foglio.number_pages string, options
		#puts foglio.compression_enabled?
		foglio.render_file "#{@dir}/altro/presenze.pdf"

		if @sistema == "linux"
			system("evince #{@dir}/altro/presenze.pdf")
		else
#			foglio.save_as('.\altro\presenze.pdf')
			@shell.ShellExecute('.\altro\presenze.pdf', '', '', 'open', 3)
		end
	else
		Conferma.conferma(finestra, "Non ci sono dati da stampare.")
	end
end
