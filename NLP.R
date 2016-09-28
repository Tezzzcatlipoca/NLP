
library(stringr)
# Leer el archivo

#arch<-read.table("en_US.news.txt",quote="",sep="\n",colClasses = "character",encoding = "UTF-8")
twit<-read.table("en_US.twitter.txt",colClasses = "character",sep="\n",quote="",encoding = "ANSI")
blogs<-read.table("en_US.blogs.txt",colClasses = "character",sep="\n",quote="",encoding = "ANSI")
news<-read.table("en_US.news.txt",colClasses = "character",sep="\n",quote="",encoding = "ANSI")
#con <- file("en_US.twitter.txt", "r", encoding = "UTF-8") 
#arch<-readLines(con, 1000)

# Extract text from lists
text_twit<-twit[[1]]
text_blog<-blogs[[1]]
text_news<-news[[1]]

# Select text samples
set.seed(555)
obs_twit<-sample(seq_len(length(text_twit)),size=1000)
obs_blog<-sample(seq_len(length(text_blog)),size=1000)
obs_news<-sample(seq_len(length(text_news)),size=1000)
sample_twit<-text_twit[obs_twit]
sample_blog<-text_blog[obs_blog]
sample_news<-text_news[obs_news]

arch<-c(sample_twit,sample_blog,sample_news)

if (length(arch)==1) {
    lineas<-length(arch[[1]])
    contenido<-arch[[1]]
} else {
    contenido<-arch
}

# Leer cada línea
filtered<-str_replace_all(contenido,"[:punct:]","")
filtered<-str_replace_all(filtered,"[:punct:]","") # Sometimes it is needed to run twice
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

#together<-iconv(together,"ASCII","UTF-8",sub="")
together<-tolower(together)
unicas<-unique(together)
numunicas<-length(unicas)

# Contar cuantas veces aparece cada palabra en el total del texto
for (i in 1:numunicas) {
    stringo<-paste("^",unicas[i],"$",sep="")
    apariciones<-sum(str_count(together, pattern = stringo))
    if (i==1) {
        veces<-apariciones
    } else {
      
        veces<-c(veces,apariciones)
    }
}

tabla<-data.frame(unicas=unicas,veces=veces)
orden<-order(tabla$veces,decreasing = TRUE)
ordenada<-tabla[orden,]

uno<-ordenada$veces
dos<-ordenada$veces
w<-0
for(i in 2:length(dos)){w<-c(w,w[i-1]+dos[i])}

# Creating the n-grams
# Creating pairs and triplets
cuenta<-length(together)-4
for (i in 1:cuenta) {
    if (i==1) {
        pares<-paste(together[i],together[i+1])
        trios<-paste(together[i],together[i+1],together[i+2])
        cuartetos<-paste(together[i],together[i+1],together[i+2],together[i+3])
} else {
        bito2<-paste(together[i],together[i+1])
        pares<-c(pares,bito2)
        bito3<-paste(together[i],together[i+1],together[i+2])
        trios<-c(trios,bito3)
        bito4<-paste(together[i],together[i+1],together[i+2],together[i+3])
        cuartetos<-c(cuartetos,bito4)
    }
  
}

pares<-unique(pares)
trios<-unique(trios)
cuartetos<-unique(cuartetos)

juntos<-paste(together,collapse = ' ')

# Counting total number of apparitions
# 2-grams
numunicas<-length(pares)
for (i in 1:numunicas) {
  stringo<-pares[i] #Pares
  try({
    aparicionespares<-sum(str_count(juntos, pattern = stringo)) #Pares
  })
  if (i==1) {
    veces<-aparicionespares
  } else {
    veces<-c(veces,aparicionespares)
  }
}
# 3-grams
numunicas<-length(trios)
for (i in 1:numunicas) {
  string2<-trios[i] #Tríos
  try({
  aparicionestrios<-sum(str_count(juntos, pattern = string2)) #Tríos
  })
  if (i==1) {
    vecest<-aparicionestrios
  } else {
    vecest<-c(vecest,aparicionestrios)
  }
}
# 4-grams
numunicas<-length(cuartetos)
for (i in 1:numunicas) {
     string3<-cuartetos[i] #Cuartetos
     try({
     aparicionescuartetos<-sum(str_count(juntos, pattern = string3)) #Cuartetos
     })
     if (i==1) {
          vecesc<-aparicionescuartetos
     } else {
          vecesc<-c(vecesc,aparicionescuartetos)
     }
}

tabla_pares<-data.frame(pares=pares,veces=veces)
tabla_trios<-data.frame(trios=trios,veces=vecest)
tabla_cuart<-data.frame(cuart=cuartetos,veces=vecesc)

ordenpares<-order(tabla_pares$veces,decreasing = TRUE)
ordentrios<-order(tabla_trios$veces,decreasing = TRUE)
ordencuart<-order(tabla_cuart$veces,decreasing = TRUE)

tabla_pares<-tabla_pares[ordenpares,]
tabla_trios<-tabla_trios[ordentrios,]
tabla_cuart<-tabla_cuart[ordencuart,]

# Guardados los archivos hasta aquí, sin mochar

# Una o más apariciones (¿En realidad nos ahorra tiempo/recursos?)
#tabla_pares<-tabla_pares[tabla_pares$veces>1,]
tabla_trios<-tabla_trios[tabla_trios$veces>1,]
tabla_cuart<-tabla_cuart[tabla_cuart$veces>1,]

tabla_pares$pares<-as.character(tabla_pares$pares)
tabla_trios$trios<-as.character(tabla_trios$trios)
tabla_cuart$cuart<-as.character(tabla_cuart$cuart)

paresj<-data.frame(str_extract_all(tabla_pares$pares,"\\S+",simplify = TRUE))
triosj<-data.frame(str_extract_all(tabla_trios$trios,"\\S+",simplify = TRUE))
cuartj<-data.frame(str_extract_all(tabla_cuart$cuart,"\\S+",simplify = TRUE))

# Test the posible outcome for 2 given words
pal1<-'what'
pal2<-'if'
pal3<-'we'
first<-cuartj[cuartj$X1==pal1 & cuartj$X2==pal2 & cuartj$X3==pal3,]
found<-triosj[triosj$X1==pal2 & triosj$X2==pal3,]
second<-paresj[paresj$X1==pal3,]
if (nrow(first)>0) {
    as.character(first[1,4])
} else if (nrow(found)>0) {
    as.character(found[1,3])
} else if (nrow(second)>0) {
    as.character(second[1,2])
}

# Now repeat the first part of the process: get a new random extraction from the files
# and choose a series of three consecutive words. See how many times we can guess
# correctly.

testlines<-twit[[1]]
observations<-sample(seq_len(length(testlines)),size=200)
samp<-testlines[observations]

filtered<-str_replace_all(samp,"[:punct:]","")
separated<-str_extract_all(filtered,"\\S+",simplify = TRUE)
separated<-iconv(separated,"ASCII","UTF-8",sub="")
separated<-tolower(separated)

prueba<-data.frame(separated[,1:5])

searchthem<-function(pal1,pal2,pal3) {
     four<-cuartj[cuartj$X1==pal1 & cuartj$X2==pal2 & cuartj$X3==pal3,]
     three<-triosj[triosj$X1==pal2 & triosj$X2==pal3,]
     two<-paresj[paresj$X1==pal3,]
     if (nrow(four)>0) {
          ffound<-four[1,4]
     } else if (nrow(three)>0) {
          ffound<-three[1,3]
     } else if (nrow(two)>0) {
          ffound<-two[1,2]
     } else {
          ffound<-ordenada[1,1]
     }
    as.character(ffound)
}

prueba$found<-0
for (i in 1:nrow(prueba)) { 
    pal1<-as.character(prueba$X1[i])
    pal2<-as.character(prueba$X2[i])
    pal3<-as.character(prueba$X3[i])
    pal4<-as.character(prueba$X4[i])
    out<-searchgram(pal1,pal2,pal3,pal4)
    prueba$found1[i]<-out[1]
    prueba$found2[i]<-out[2]
    prueba$found3[i]<-out[3]
    #prueba$where[i]<-as.integer(out$where[1])
}


sum(is.na(prueba$found))
prueba$right<-(prueba$X5==prueba$found1 | prueba$X5==prueba$found2 | prueba$X5==prueba$found3)
table(prueba$right)

# Conclusion: The 2-grams solve most cases. Mostly are wrong.
