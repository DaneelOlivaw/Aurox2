def importadatabase(selezione, password)
	nomecopia = Time.now.strftime('aurox10_%Y%m%d%H%M')
	if @sistema == "linux"
		`mysqldump -u aurox -p"#{password}" aurox10 > #{@dir}/esportadb/#{nomecopia}`
		`mysqladmin -u aurox -p"#{password}" create "#{nomecopia}"`
		`mysql "#{nomecopia}" < #{@dir}/esportadb/#{nomecopia} -u aurox -p"#{password}" 2>&1`
		File.delete("#{@dir}/esportadb/#{nomecopia}")
	else
		dir = @dir.tr('\/',  '\\')
		selez = selezione.filename.tr('\/',  '\\')
		`mysqldump -u aurox -p"#{password}" aurox10 > "#{dir}\\esportadb\\#{nomecopia}"`
		`mysqladmin -u aurox -p"#{password}" create "#{nomecopia}"`
		`mysql "#{nomecopia}" < #{dir}\\esportadb\\#{nomecopia} -u aurox -p"#{password}" 2>&1`
		File.delete("#{dir}\\esportadb\\#{nomecopia}")
	end
	comando = `mysql aurox10 < "#{selezione}" -u aurox -p"#{password}" 2>&1`
	if $? != 0
		Errore.avviso(nil, "Password sbagliata.")
		password = ""
		selezione = ""
		selezionadb(nil, "importadb")
	else
		Parameters.update("1", {:ultimobackup => "#{@giorno.strftime("%Y-%m-%d")}"})
		Conferma.conferma(nil, "Database importato correttamente")
		password = nil
		selezione = nil
	end
end
