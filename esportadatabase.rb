#Esporta database

def esportadatabase(password, azione)
	if @sistema == "linux"
		comando = `mysqldump -u aurox -p"#{password}" aurox10 > #{@dir}/esportadb/#{Time.now.strftime("aurox10_%Y%m%d%H%M.sql")} 2>&1`
	else
		comando = `mysqldump -u aurox -p"#{password}" aurox10 > .\\esportadb\\#{Time.now.strftime("aurox10_%Y%m%d%H%M.sql")} 2>&1`
	end
	if $? != 0
		Errore.avviso(nil, "Password sbagliata")
		password = nil
		require 'chiedipassword' unless defined?(chiedipassword)
		chiedipassword(nil, "esportadb")
	else
		Parameters.update("1", {:ultimobackup => "#{@giorno.strftime("%Y-%m-%d")}"})
		if azione == "aggiornadb"
			require "modificadatabase"
			modificadb
		end
		@fine = 1
		Conferma.conferma(nil, "Database esportato correttamente.\n\nRicordarsi di copiare l'esportazione in un supporto da conservare in un luogo sicuro.")
		password = nil
	end
end
