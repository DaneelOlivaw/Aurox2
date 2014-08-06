def aggiornaprogramma(finestra, modo)
	begin
		require 'zip/zipfilesystem'
		require 'net/http'
		progressivo = []
		http = Net::HTTP.start("posta.coopnoi.it")
		testo = http.get("/aurox/")
		testo.body.each do |s|
				if s.include?("Aurox")
					progressivo << s.split('_')[1].split('.')[0].to_i
				end
			end
		http.finish
		if progressivo.max > Parameters.parametri.versione.to_i
			avviso = Gtk::MessageDialog.new(finestra, Gtk::Dialog::DESTROY_WITH_PARENT, Gtk::MessageDialog::QUESTION, Gtk::MessageDialog::BUTTONS_YES_NO, "Ci sono degli aggiornamenti al programma. Li scarico ora?")
			risposta = avviso.run
			avviso.destroy
			if risposta == Gtk::Dialog::RESPONSE_YES
				# Scarico file aggiornamento
				File.open("#{@dir}/Aurox2.zip", "wb") { |file|
					file.write(http.get("/upload/Aurox2_#{progressivo.max}.zip").body)
				}
				# Crea directory dove decomprimere l'archio dell'aggiornamento
				nomedir = @giorno.strftime("bkpcodice_%Y%m%d%H%M")
				FileUtils.mkdir("#{nomedir}")
				Dir.foreach("#{@dir}") do |f|
					# Copia i files del programma in uso sulla directory di backup (temporanea)
					File.copy("#{@dir}/#{f}", "#{@dir}/#{nomedir}/") if f.include?(".rb")
					# Elimina i files appena copiati dalla posizione di lavoro
					#File.delete("#{@dir}/#{f}") if f.include?(".rb")
				end
				# Crea un archivio compresso coi files di backup dentro una directory apposita
				Zip::ZipFile.open("#{@dir}/vecchi/#{nomedir}.zip", true) {
					|zf|
				 	Dir["#{nomedir}\/\*"].each { |f| zf.add(f, f) if f.include?(".rb") }
				 }
				 #Elimina la directory di backup
				Dir.foreach("#{@dir}/#{nomedir}") do |n|
					File.delete("#{@dir}/#{nomedir}/#{n}") if n != '.' && n != '..'
				end
				Dir.delete("#{nomedir}")
				#File.delete("#{@dir}/invio/#{f}") if f.include?(".asc")
				# Decomprime l'archivio con l'aggiornamento
				aggdb = 0
				Zip::ZipFile::open("#{@dir}/Aurox2.zip") { |zf|
					zf.each { |e|
						fpath = File.join("#{@dir}", e.name)
						aggdb = 1 if e.name.include?("migrazioni")
						FileUtils.mkdir_p(File.dirname(fpath))
						zf.extract(e, fpath) {true}
					}
				}
				@fine = 0
				if aggdb == 1
					mpassword = Gtk::Window.new("Salva database")
					mpassword.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
					#mpassword.focus=(true)
					boxpasswordv = Gtk::VBox.new(false, 0)
					boxpassword1 = Gtk::HBox.new(false, 5)
					boxpassword2 = Gtk::HBox.new(false, 5)
					boxpassword3 = Gtk::HBox.new(false, 5)
					boxpasswordv.pack_start(boxpassword1, false, false, 5)
					boxpasswordv.pack_start(boxpassword2, false, false, 5)
					boxpasswordv.pack_start(boxpassword3, false, false, 5)
					mpassword.add(boxpasswordv)
					labelpass = Gtk::Label.new("Password di amministratore:")
					boxpassword1.pack_start(labelpass, false, false, 5)
					password = Gtk::Entry.new
					password.visibility = false
					boxpassword1.pack_start(password, false, false, 5)
					bottesp = Gtk::Button.new( "OK" )
					boxpassword1.pack_start(bottesp, false, false, 5)
					password.signal_connect("activate") {
						if password.text == ""
							Errore.avviso(mpassword, "Inserisci una password")
						else
							if @sistema == "linux"
								comando = `mysqldump -u aurox -p"#{password.text}" aurox10 > #{@dir}/esportadb/#{Time.now.strftime("aurox10_%Y%m%d%H%M.sql")} 2>&1`
							else
								comando = `mysqldump -u aurox -p"#{password.text}" aurox10 > .\\esportadb\\#{Time.now.strftime("aurox10_%Y%m%d%H%M.sql")} 2>&1`
							end
							if $? != 0
								Errore.avviso(nil, "Password sbagliata")
								password.text = ""
							else
								Parameters.update("1", {:ultimobackup => "#{@giorno.strftime("%Y-%m-%d")}"})
								require "modificadatabase"
								modificadatabase
								Conferma.conferma(nil, "Database esportato correttamente")
								password.text = ""
								mpassword.destroy
								File.delete("#{@dir}/Aurox2.zip")
								# Crea l'avviabile per win
								if @sistema == "win"
									File.copy("#{@dir}/aurox.rb", "#{@dir}/aurox.rbw")
								end
								Conferma.conferma(finestra, "Aggiornamento eseguito con successo. Chiudere il programma e riavviarlo.")
								Parameters.update("1", {:versione => "#{progressivo.max}"})
							end
						end
					}

						bottesp.signal_connect( "clicked" ) {
							if password.text == ""
								Errore.avviso(mpassword, "Inserisci una password")
							else
								if @sistema == "linux"
									comando = `mysqldump -u aurox -p"#{password.text}" aurox10 > #{@dir}/esportadb/#{Time.now.strftime("aurox10_%Y%m%d%H%M.sql")} 2>&1`
								else
									comando = `mysqldump -u aurox -p"#{password.text}" aurox10 > .\\esportadb\\#{Time.now.strftime("aurox10_%Y%m%d%H%M.sql")} 2>&1`
								end
								if $? != 0
									Errore.avviso(nil, "Password sbagliata")
									password.text = ""
								else
									Parameters.update("1", {:ultimobackup => "#{@giorno.strftime("%Y-%m-%d")}"})
									require "modificadatabase"
									modificadatabase
									Conferma.conferma(nil, "Database esportato correttamente")
									password.text = ""
									mpassword.destroy
									File.delete("#{@dir}/Aurox2.zip")
									# Crea l'avviabile per win
									if @sistema == "win"
										File.copy("#{@dir}/aurox.rb", "#{@dir}/aurox.rbw")
									end
									Conferma.conferma(finestra, "Aggiornamento eseguito con successo. Chiudere il programma e riavviarlo.")
									Parameters.update("1", {:versione => "#{progressivo.max}"})
								end
							end
						}
						mpassword.show_all
				else
					File.delete("#{@dir}/Aurox2.zip")
					# Crea l'avviabile per win
					if @sistema == "win"
						File.copy("#{@dir}/aurox.rb", "#{@dir}/aurox.rbw")
					end
					Conferma.conferma(finestra, "Aggiornamento eseguito con successo. Chiudere il programma e riavviarlo.")
					Parameters.update("1", {:versione => "#{progressivo.max}"})
				end
			else
				Conferma.conferma(finestra, "L'aggiornamento non sarà eseguito.")
			end
		else
			Conferma.conferma(finestra, "Non ci sono aggiornamenti disponibili.")
		end
	rescue Exception => errore
		if errore.to_s.include?("450")
			Conferma.conferma(finestra, "Non ci sono aggiornamenti disponibili.")
		elsif errore.to_s.include?("connect")
			Errore.avviso(finestra, "Ci sono problemi di connessione col server remoto; controllare se la propria linea è attiva.")
		else
			Errore.avviso(finestra, "Errore generico, non posso effettuare l'aggiornamento.")
		end
	end
end
