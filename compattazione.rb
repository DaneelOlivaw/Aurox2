def compattazione(mcompatta, capi, anno, lista)
	#puts anno
	nomefile = Time.now.strftime("STORICO_CAPI_ANNO_#{anno}_#{@stallaoper.stalle.cod317}_#{@stallaoper.ragsoc.ragsoc.gsub(/[ ]/, "")}_#{@stallaoper.detentori.detentore.gsub(/[ ]/, "")}_#{@stallaoper.prop.prop.gsub(/[ ]/, "")}_#{@stallaoper.atp}_%m%d_%H%M.csv")
#	if @sistema == "linux"
	filecomp = File.new("#{@dir}/storico/#{nomefile}", "w+")
	filecomp.puts("STALLA\tRAGIONE SOCIALE\tDETENTORE\tPROPRIETARIO\tN° REGISTRO\tMARCA\tSPECIE\tRAZZA\tDATA NASCITA\tSTALLA NASCITA\tSESSO\tNAZ. ORIGINE\tNAZ. NASCITA O PRIMA IMPORTAZ.\tDATA APPLICAZIONE MARCA\tISCR. LIBRO GENEAL.\tEMBRYO TRANSFER\tMARCA PRECEDENTE\tMADRE\tPADRE\tDONATRICE\tCOD.LIBRO GENEAL.\tMOTIVO INGRESSO\tDATA INGRESSO\tNAZ. PROVENIENZA\tCERT. SAN. INGRESSO\tDATA CERT. SAN. INGRESSO\tCOD. RIFERIMENTO LOCALE\tCOD. 3127 ALLEV. PROVENIENZA\tRAG. SOC. ALLEV. PROVENIENZA\tID. FISC. ALLEV. PROVENIENZA\tMOD. 4 INGRESSO\tDATA MOD.4 INGRESSO\tMOTIVO USCITA\tDATA USCITA\tDITTA RACCOGLITRICE\tTRASPORTATORE\tMARCA SOSTITUTIVA\tNAZ. DESTINAZIONE\tCOD. 317 ALLEV. DESTINAZIONE\tRAG. SOC. ALLEV. DESTIONAZIONE\tID. FISC. ALLEV. DESTINAZIONE\tBOLLO CEE MACELLO\tRAG. SOC. MACELLO\tID. FISC. MACELLO\tREGIONE MACELLO\tMOD. 4 USCITA\tDATA MOD. 4 USCITA\tCERT. SAN. USCITA\tDATA CERT. SAN. USCITA")
	capi.each do |c|
		filecomp.puts("#{c.relaz.stalle.cod317}\t#{c.relaz.ragsoc.ragsoc}\t#{c.relaz.detentori.detentore}\t#{c.relaz.prop.prop}\t\"#{c.progreg}\"\t#{c.marca}\t#{c.specie}\t#{c.razza}\t#{c.data_nas}\t#{c.stalla_nas}\t#{c.sesso}\t#{c.nazorig}\t#{c.naznasprimimp}\t#{c.data_applm}\t#{c.ilg}\t#{c.embryo}\t#{c.marca_prec}\t#{c.marca_madre}\t#{c.marca_padre}\t#{c.donatrice}\t#{c.clg}\t#{c.codingresso}\t#{c.data_ingr}\t#{c.nazprov}\t#{c.certsaningr}\t#{c.data_certsaningr}\t#{c.rifloc}\t#{c.allevingr_cod317}\t#{c.allevingr_ragsoc}\t'#{c.allevingr_idfisc}\t#{c.mod4ingr}\t#{c.data_mod4ingr}\t#{c.coduscita}\t#{c.data_uscita}\t#{c.ditta_racc}\t#{c.trasp}\t#{c.marcasost}\t#{c.nazdest}\t#{c.allevusc_cod317}\t#{c.allevusc_ragsoc}\t'#{c.allevusc_idfisc}\t#{c.macello_bollo}\t#{c.macello_ragsoc}\t'#{c.macello_idfisc}\t#{c.macello_regione}\t#{c.mod4usc}\t#{c.data_mod4usc}\t'#{c.certsanusc}\t#{c.data_certsanusc}")
		#Archives.delete(c.id)
	end
	filecomp.close
	Conferma.conferma(mcompatta, "Operazione eseguita correttamente.")
	arranni = []
	capi = Archives.find(:all, :conditions => ["relaz_id= ?", "#{@stallaoper.id}"])
	capi.each do |c|
		arranni << c.data_uscita.strftime("%Y")
	end
	arranni.uniq!
	if lista != nil
		lista.clear
		arranni.each do |a|
			iter = lista.append
			iter[0] = a
		end
	end
end
