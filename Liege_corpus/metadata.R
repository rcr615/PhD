metadata <- read.csv("/Users/rachelrubin/Documents/Liege_corpus/results-survey388894.csv", stringsAsFactors = F, na.strings = c("NA",""))
students <- read.csv2("/Users/rachelrubin/Documents/Liege_corpus/Liege_corpus_master_0621.csv", stringsAsFactors = F, na.strings = c("NA",""))

metadata$student.name <- paste0(metadata$firstname..Voornaam," ",metadata$lastname..Achternaam)
metadata <- metadata[-c(2),]
students$X.1 <- as.character(students$X.1)
students$X.1[students$X.1=="Meika Mazy"] <- "Meïka Mazy"
students$X.1[students$X.1=="Fiona Signorino"] <- "Fiona Signorino Gelo"
students$X.1[students$X.1=="Emma Gregoire"] <- "Emma Grégoire"
students$X.1[students$X.1=="Helen Hoffman"] <- "Helen Hoffmann"
students$X.1[students$X.1=="Romane De Terwangne"] <- "Romane de Terwangne"
students$X.1[students$X.1=="Laura Defeche"] <- "Laura Defèche"
students$X.1[students$X.1=="Perrine Melen"] <- "Perrine Melen-Lamalle"
students$X.1[students$X.1=="Arlene Van den Boorn"] <- "Arlène van den Boorn"
students$X.1[students$X.1=="Melanie Massoz"] <- "Mélanie Massoz"
students$X.1[students$X.1=="Chloe Kim"] <- "Chloé Kim"
students$X.1[students$X.1=="Salome Crustin"] <- "Salomé Crustin"
students[students$X.1 %in% metadata$student.name,c(25:103)] <- metadata[match(students$X.1,metadata$student.name)[!is.na(match(students$X.1,metadata$student.name))],c(1:79)]

students$total.texts <- apply(students,1,function(x){
  length(x[4:24][!is.na(x[4:24])])
})

students$LANEPG1..Leeftijd.[students$LANEPG1..Leeftijd.==1999 & !is.na(students$LANEPG1..Leeftijd.)] <- 19

students$LANEPG3..Wat.is.het.hoogst.behaalde.onderwijsniveau.van.je.moeder.[!is.na(students$LANEPG3.other...Wat.is.het.hoogst.behaalde.onderwijsniveau.van.je.moeder...Anders.)] <- students$LANEPG3.other...Wat.is.het.hoogst.behaalde.onderwijsniveau.van.je.moeder...Anders.[!is.na(students$LANEPG3.other...Wat.is.het.hoogst.behaalde.onderwijsniveau.van.je.moeder...Anders.)]

students$LANEPG4..Wat.is.het.hoogst.behaalde.onderwijsniveau.van.je.vader.[!is.na(students$LANEPG4.other...Wat.is.het.hoogst.behaalde.onderwijsniveau.van.je.vader...Anders.)] <- students$LANEPG4.other...Wat.is.het.hoogst.behaalde.onderwijsniveau.van.je.vader...Anders.[!is.na(students$LANEPG4.other...Wat.is.het.hoogst.behaalde.onderwijsniveau.van.je.vader...Anders.)]

students$LANEPG6..Gebruik.dit.tekstvak.om.nog.één.of.meer.landen.te.vermelden.als.je.een.substantieel.deel.van.je.leven.in.meer.dan.een.land.hebt.gewoond.[students$LANEPG6..Gebruik.dit.tekstvak.om.nog.één.of.meer.landen.te.vermelden.als.je.een.substantieel.deel.van.je.leven.in.meer.dan.een.land.hebt.gewoond.=="/"] <- NA

students$LANEPG7..Wat.is.jouw.huidige.woonplaats.[students$LANEPG7..Wat.is.jouw.huidige.woonplaats.=="Barvaux s/O " & !is.na(students$LANEPG7..Wat.is.jouw.huidige.woonplaats.)] <- "Barvaux"

students$LANEPG7..Wat.is.jouw.huidige.woonplaats.[students$LANEPG7..Wat.is.jouw.huidige.woonplaats. %in% c("Belgie", "België ") & !is.na(students$LANEPG7..Wat.is.jouw.huidige.woonplaats.)] <- "België"

students$LANEPG7..Wat.is.jouw.huidige.woonplaats.[students$LANEPG7..Wat.is.jouw.huidige.woonplaats.=="België (Villers-le-Bouillet)" & !is.na(students$LANEPG7..Wat.is.jouw.huidige.woonplaats.)] <- "Villers-le-Bouillet"

students$LANEPG7..Wat.is.jouw.huidige.woonplaats.[students$LANEPG7..Wat.is.jouw.huidige.woonplaats. %in% c("België, Saint Vith", "St. Vith - Duitstalige Gemeenschap België") & !is.na(students$LANEPG7..Wat.is.jouw.huidige.woonplaats.)] <- "St. Vith"

students$LANEPG7..Wat.is.jouw.huidige.woonplaats.[students$LANEPG7..Wat.is.jouw.huidige.woonplaats.=="Bij mijn ouders thuis" & !is.na(students$LANEPG7..Wat.is.jouw.huidige.woonplaats.)] <- NA

students$LANEPG7..Wat.is.jouw.huidige.woonplaats.[students$LANEPG7..Wat.is.jouw.huidige.woonplaats.=="DISON (Liège) " & !is.na(students$LANEPG7..Wat.is.jouw.huidige.woonplaats.)] <- "Dison"

students$LANEPG7..Wat.is.jouw.huidige.woonplaats.[students$LANEPG7..Wat.is.jouw.huidige.woonplaats.=="Embourg, Liège, België" & !is.na(students$LANEPG7..Wat.is.jouw.huidige.woonplaats.)] <- "Embourg"

students$LANEPG7..Wat.is.jouw.huidige.woonplaats.[students$LANEPG7..Wat.is.jouw.huidige.woonplaats.=="Forrières " & !is.na(students$LANEPG7..Wat.is.jouw.huidige.woonplaats.)] <- "Forrières"

students$LANEPG7..Wat.is.jouw.huidige.woonplaats.[students$LANEPG7..Wat.is.jouw.huidige.woonplaats.=="Hannut" & !is.na(students$LANEPG7..Wat.is.jouw.huidige.woonplaats.)] <- "Hannuit"

students$LANEPG7..Wat.is.jouw.huidige.woonplaats.[students$LANEPG7..Wat.is.jouw.huidige.woonplaats. %in% c("Liege ", "Liège") & !is.na(students$LANEPG7..Wat.is.jouw.huidige.woonplaats.)] <- "Luik"

students$LANEPG7..Wat.is.jouw.huidige.woonplaats.[students$LANEPG7..Wat.is.jouw.huidige.woonplaats.=="Virton, 6760, België" & !is.na(students$LANEPG7..Wat.is.jouw.huidige.woonplaats.)] <- "Virton"

students$LANEPG10..Gebruik.dit.tekstvak.om.nog.één.of.meer.moedertalen.te.vermelden.[!is.na(students$LANEPG10..Gebruik.dit.tekstvak.om.nog.één.of.meer.moedertalen.te.vermelden.) & students$LANEPG10..Gebruik.dit.tekstvak.om.nog.één.of.meer.moedertalen.te.vermelden.=="/"] <- NA

students$LANEPG10..Gebruik.dit.tekstvak.om.nog.één.of.meer.moedertalen.te.vermelden.[!is.na(students$LANEPG10..Gebruik.dit.tekstvak.om.nog.één.of.meer.moedertalen.te.vermelden.) & students$LANEPG10..Gebruik.dit.tekstvak.om.nog.één.of.meer.moedertalen.te.vermelden.=="Arabisch en Berberse "] <- "Arabisch en Berbers"

students$LANEPG10..Gebruik.dit.tekstvak.om.nog.één.of.meer.moedertalen.te.vermelden.[!is.na(students$LANEPG10..Gebruik.dit.tekstvak.om.nog.één.of.meer.moedertalen.te.vermelden.) & students$LANEPG10..Gebruik.dit.tekstvak.om.nog.één.of.meer.moedertalen.te.vermelden.=="Frans "] <- "Frans"

students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.[!is.na(students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.) & students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.=="/"] <- NA

students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.[!is.na(students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.) & students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.=="Frans en Berberse"] <- "Frans en Berbers"

students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.[!is.na(students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.) & students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.=="Frans en engels "] <- "Frans en Engels"

students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.[!is.na(students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.) & students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.=="Italiaans, Spaans"] <- "Italiaans en Spaans"

students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.[!is.na(students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.) & students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.=="soms Frans"] <- "Frans"

students$LANEPG13.SQ002...Percentage.van.gebruik.van.thuistalen...Percentage.van.gebruik.van.tweede.thuistaal..[is.na(students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.) & !is.na(students$LANEPG13.SQ002...Percentage.van.gebruik.van.thuistalen...Percentage.van.gebruik.van.tweede.thuistaal..)] <- NA

students$LANEPG13.SQ003...Percentage.van.gebruik.van.thuistalen...Percentage.van.gebruik.van.derde.thuistaal..[is.na(students$LANEPG12..Gebruik.dit.tekstvak.om.nog.één.of.meer.thuistalen.te.vermelden.) & !is.na(students$LANEPG13.SQ003...Percentage.van.gebruik.van.thuistalen...Percentage.van.gebruik.van.derde.thuistaal..)] <- NA

students$LANEPG14..Met.welke.vreemde.talen.ben.jij.bekend.[students$LANEPG14..Met.welke.vreemde.talen.ben.jij.bekend.=="Geen vreemde talen" & !is.na(students$LANEPG14..Met.welke.vreemde.talen.ben.jij.bekend.)] <- "Geen"

students$LANEPG15..Ben.jij.met.meerdere.vreemde.talen.bekend.[students$LANEPG15..Ben.jij.met.meerdere.vreemde.talen.bekend.=="N/A" & !is.na(students$LANEPG15..Ben.jij.met.meerdere.vreemde.talen.bekend.)] <- NA

students$LANEPG17..Ben.jij.bekend.met.meer.vreemde.talen.[students$LANEPG17..Ben.jij.bekend.met.meer.vreemde.talen.=="N/A" & !is.na(students$LANEPG17..Ben.jij.bekend.met.meer.vreemde.talen.)] <- NA

students$LANEO3..Welke.andere.taal..naast.het.Nederlands..heb.jij.gekozen.om.te.studeren.voor.je.studieprogramma.[students$LANEO3..Welke.andere.taal..naast.het.Nederlands..heb.jij.gekozen.om.te.studeren.voor.je.studieprogramma.=="Anders" & !is.na(students$LANEO3..Welke.andere.taal..naast.het.Nederlands..heb.jij.gekozen.om.te.studeren.voor.je.studieprogramma.)] <- "Engels en Duits"

students$LANEO6..Heb.jij.een.tweetalig.onderwijs.programma.of.een.taalimmersie.programma.gevolgd.op.de.basisschool.of.middelbare.school.[students$LANEO6..Heb.jij.een.tweetalig.onderwijs.programma.of.een.taalimmersie.programma.gevolgd.op.de.basisschool.of.middelbare.school.=="N/A" & !is.na(students$LANEO6..Heb.jij.een.tweetalig.onderwijs.programma.of.een.taalimmersie.programma.gevolgd.op.de.basisschool.of.middelbare.school.)] <- NA

students$LANECN1..Op.welke.leeftijd.ben.jij.voor.het.eerst.begonnen.Nederlands.te.leren.[students$LANECN1..Op.welke.leeftijd.ben.jij.voor.het.eerst.begonnen.Nederlands.te.leren.==2013 & !is.na(students$LANECN1..Op.welke.leeftijd.ben.jij.voor.het.eerst.begonnen.Nederlands.te.leren.)] <- 14

students$LANECN2.other...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Anders.[students$LANECN2.SQ001...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.te.kunnen.studeren.aan.een.Nederlandstalige.instelling.=="Ja" & !is.na(students$LANECN2.SQ001...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.te.kunnen.studeren.aan.een.Nederlandstalige.instelling.)] <- "Om te kunnen studeren aan een Nederlandstalige instelling"

students$LANECN2.other...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Anders.[students$LANECN2.SQ002...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.leraar.lerares.Nederlands.te.worden.=="Ja" & !is.na(students$LANECN2.SQ002...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.leraar.lerares.Nederlands.te.worden.)] <- gsub("NA / (.*)", "\\1", paste0(students$LANECN2.other...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Anders.[students$LANECN2.SQ002...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.leraar.lerares.Nederlands.te.worden.=="Ja" & !is.na(students$LANECN2.SQ002...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.leraar.lerares.Nederlands.te.worden.)], " / ", "Om leraar/lerares Nederlands te worden"))

students$LANECN2.other...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Anders.[students$LANECN2.SQ003...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Het.is.nodig.voor.mijn.toekomstige.werk.=="Ja" & !is.na(students$LANECN2.SQ003...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Het.is.nodig.voor.mijn.toekomstige.werk.)] <- gsub("NA / (.*)", "\\1", paste0(students$LANECN2.other...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Anders.[students$LANECN2.SQ003...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Het.is.nodig.voor.mijn.toekomstige.werk.=="Ja" & !is.na(students$LANECN2.SQ003...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Het.is.nodig.voor.mijn.toekomstige.werk.)], " / ", "Het is nodig voor mijn werk"))

students$LANECN2.other...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Anders.[students$LANECN2.SQ004...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.gemakkelijker.te.kunnen.wonen.in.een.Nederlandstalig.land.of.gebied.=="Ja" & !is.na(students$LANECN2.SQ004...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.gemakkelijker.te.kunnen.wonen.in.een.Nederlandstalig.land.of.gebied.)] <- gsub("NA / (.*)", "\\1", paste0(students$LANECN2.other...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Anders.[students$LANECN2.SQ004...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.gemakkelijker.te.kunnen.wonen.in.een.Nederlandstalig.land.of.gebied.=="Ja" & !is.na(students$LANECN2.SQ004...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.gemakkelijker.te.kunnen.wonen.in.een.Nederlandstalig.land.of.gebied.)], " / ", "Om gemakkelijker te kunnen wonen in een Nederlandstalig land of gebied"))

students$LANECN2.other...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Anders.[students$LANECN2.SQ005...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.een.nieuwe.taal.te.leren.=="Ja" & !is.na(students$LANECN2.SQ005...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.een.nieuwe.taal.te.leren.)] <- gsub("NA / (.*)", "\\1", paste0(students$LANECN2.other...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Anders.[students$LANECN2.SQ005...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.een.nieuwe.taal.te.leren.=="Ja" & !is.na(students$LANECN2.SQ005...Waarom.heb.jij.besloten.Nederlands.te.studeren.aan.de.universieit...Om.een.nieuwe.taal.te.leren.)], " / ", "Om een nieuwe taal te leren"))

students$LANECN3..Heb.jij.tijd.in.een.Nederlandstalig.land.of.gebied.besteed..[students$LANECN3..Heb.jij.tijd.in.een.Nederlandstalig.land.of.gebied.besteed..=="N/A" & !is.na(students$LANECN3..Heb.jij.tijd.in.een.Nederlandstalig.land.of.gebied.besteed..)] <- NA

students$LANECN7..Heb.je.ooit.een.Nederlands.taalexamen.gemaakt.waardoor.je.een.taalniveau.bent.toegewezen.[students$LANECN7..Heb.je.ooit.een.Nederlands.taalexamen.gemaakt.waardoor.je.een.taalniveau.bent.toegewezen.=="N/A" & !is.na(students$LANECN7..Heb.je.ooit.een.Nederlands.taalexamen.gemaakt.waardoor.je.een.taalniveau.bent.toegewezen.)] <- NA

students$LANECN8..Welk.taalexamen.heb.jij.gemaakt.[students$LANECN8..Welk.taalexamen.heb.jij.gemaakt.=="Anders" & !is.na(students$LANECN8..Welk.taalexamen.heb.jij.gemaakt.)] <- students$LANECN8.other...Welk.taalexamen.heb.jij.gemaakt...Anders.[students$LANECN8..Welk.taalexamen.heb.jij.gemaakt.=="Anders" & !is.na(students$LANECN8..Welk.taalexamen.heb.jij.gemaakt.)]

students$LANECN8..Welk.taalexamen.heb.jij.gemaakt.[students$LANECN8..Welk.taalexamen.heb.jij.gemaakt.=="Wallangues " & !is.na(students$LANECN8..Welk.taalexamen.heb.jij.gemaakt.)] <- "Wallangues" 

students$LANECN9..Tot.welk.taalniveau.ben.jij.toegewezen.[students$LANECN9..Tot.welk.taalniveau.ben.jij.toegewezen.=="Anders" & !is.na(students$LANECN9..Tot.welk.taalniveau.ben.jij.toegewezen.)] <- students$LANECN9.other...Tot.welk.taalniveau.ben.jij.toegewezen...Anders.[students$LANECN9..Tot.welk.taalniveau.ben.jij.toegewezen.=="Anders" & !is.na(students$LANECN9..Tot.welk.taalniveau.ben.jij.toegewezen.)]


students <- students[,-c(26,27,28,29,33,35,37,42,45,51,52,54,55,57,62,65,67,69,77,78,79,80,81,85,91,93,101,102,103)]

colnames(students) <- c(c("ID","name","email"),colnames(students)[4:24],c("survey_ID","age","sex","mother_edu","father_edu","primary_country_res","secondary_country_res","res","time_Belgium","L1","L1_additional","home_lang","home_lang_additional","percentage_usage_home_lang_1","percentage_usage_home_lang_2","percentage_usage_home_lang_3","L2","L3","L4","years_experience_L2","years_experience_L3","years_experience_L4","study_level","study_program","additional_study_lang","lang_primary_school","lang_secondary","TTO/immersie","TTO/immersie_1","TTO/immersie_primary/secondary","years_NL_primary","years_NL_secondary","years_NL_uni","age_begin_NL","reason_study_NL","time_spent_NL_region","NL_region","years_NL_region","self_report_proficiency","description_proficiency","NL_prof_exam","NL_prof_exam_1","assigned_prof_level","televisie_NL_zonder_ondertiteling","televisie_NL_met_ondertiteling","NL_websites","NL_teksten","NL_dagelijks_leven","NL_radio","NL_kennissen","total_texts"))

save(students,file="students_liege.Rdata")
