=begin
def mascimportadb(selezione)

	mimportadb = Gtk::Window.new("Importazione database")
	mimportadb.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
	boximportadbv = Gtk::VBox.new(false, 0)
	boximportadb1 = Gtk::HBox.new(false, 5)
	boximportadb2 = Gtk::HBox.new(false, 5)
	boximportadb3 = Gtk::HBox.new(false, 5)
	boximportadbv.pack_start(boximportadb1, false, false, 5)
	boximportadbv.pack_start(boximportadb2, false, false, 5)
	boximportadbv.pack_start(boximportadb3, false, false, 5)
	mimportadb.add(boximportadbv)

	labelpass = Gtk::Label.new("Password di amministratore:")
	boximportadb1.pack_start(labelpass, false, false, 5)
	password2 = Gtk::Entry.new
	password2.visibility = false
	boximportadb1.pack_start(password2, false, false, 5)

	bottesp = Gtk::Button.new( "OK" )
	boximportadb1.pack_start(bottesp, false, false, 5)

	password2.signal_connect("activate") {
		importadb(mimportadb, password2, selezione)
	}

	bottesp.signal_connect( "clicked" ) {
		importadb(mimportadb, password2, selezione)
	}

	mimportadb.show_all

end
=end

#def importadb(mimportadb, password2, selezione)
def importadb(selezione, password)
puts selezione #.filename
#	if password2.text == ""
#		Errore.avviso(mimportadb, "Inserisci una password.")
#	else
		nomecopia = Time.now.strftime('aurox10_%Y%m%d%H%M')
		if @sistema == "linux"
#			puts Dir.pwd
			`mysqldump -u aurox -p"#{password}" aurox10 > #{@dir}/esportadb/#{nomecopia}`
			#`mysqldump -u aurox -p"#{password.text}" aurox1_0 > #{@dir}/esportadb/#{Time.now.strftime("aurox1_0_%Y%m%d%H%M.sql")} 2>&1`
			`mysqladmin -u aurox -p"#{password}" create "#{nomecopia}"`
			`mysql "#{nomecopia}" < #{@dir}/esportadb/#{nomecopia} -u aurox -p"#{password}" 2>&1`
			#`rm ./esportadb/#{nomecopia}`
			File.delete("#{@dir}/esportadb/#{nomecopia}")
#			comando = `mysql aurox < "#{@selezione.filename}" -u aurox -p'#{password2.text}' 2>&1`
		else
#			Dir.chdir("../esportadb")
#			directory = Dir.pwd
			dir = @dir.tr('\/',  '\\')
			selez = selezione.filename.tr('\/',  '\\')
#			`mysqldump -u aurox -p"#{password2.text}" aurox > "#{directory}"/"#{nomecopia}"`
#			`mysqladmin -u aurox -p"#{password2.text}" create "#{nomecopia}"`
#			`mysql "#{nomecopia}" < "#{directory}"/"#{nomecopia}" -u aurox -p"#{password2.text}" 2>&1`
			`mysqldump -u aurox -p"#{password}" aurox10 > "#{dir}\\esportadb\\#{nomecopia}"`
			`mysqladmin -u aurox -p"#{password}" create "#{nomecopia}"`
			`mysql "#{nomecopia}" < #{dir}\\esportadb\\#{nomecopia} -u aurox -p"#{password}" 2>&1`
			File.delete("#{dir}\\esportadb\\#{nomecopia}")
#			File.delete("#{directory}"/"#{nomecopia}")
##			comando = `mysql aurox < "#{@selezione.filename}" -u aurox -p"#{password2.text}" 2>&1`
		end
		comando = `mysql aurox10 < "#{selezione}" -u aurox -p"#{password}" 2>&1`
		#puts comando
		#puts $?
		if $? != 0
#			puts "sbagliato"
			Errore.avviso(nil, "Password sbagliata.")
			password = ""
			selezione = ""
			selezionadb(nil, "importadb")
		else
			Parameters.update("1", {:ultimobackup => "#{@giorno.strftime("%Y-%m-%d")}"})
			Conferma.conferma(nil, "Database importato correttamente")
#			puts "giusto"
			password = nil
			#mimportadb.destroy
			selezione = nil
		end
#	end
end