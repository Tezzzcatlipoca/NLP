

# Leer el archivo
arch<-read.table("Text.txt",quote="",sep="\n",colClasses = "character")

lineas<-length(arch[[1]])
contenido<-arch[[1]]


# Leer cada línea

words<-"Here goes the sentence"
words2<-"There is a bunch of words here (like these). We plan 'to this'..."
filtered<-str_replace_all(contenido,"[:punct:]","")
separated<-str_extract_all(filtered,"\\S+")
#separated<-substr(separated,2,nchar(filtered)) #Quitar la "c" que aparece al principio

together<-""
largo<-length(separated)
for (i in 1:largo) {
    if (i==1) { 
        together<-separated[[i]]
    } else {
    together<-c(together,separated[[i]])
    }
}

#together <- todas las palabras
#unicas <- mismas palabras, sin repetidas

unicas<-unique(together)
numunicas<-length(unicas)

# Contar cuantas veces aparece cada palabra en el total del texto
for (i in 1:numunicas) {
    stringo<-paste("[^[:alnum:]]",unicas[i],"[^[:alnum]]",sep="")
    apariciones<-sum(str_count(together, pattern = stringo))
    if (i==1) {
        veces<-apariciones
    } else {
      
        veces<-c(veces,apariciones)
    }
}

tabla<-data.frame(unicas=unicas,veces=veces)


