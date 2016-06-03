


words<-"Here goes the sentence"
words2<-"There is a bunch of words here (like these). We plan 'to this'..."
separated<-str_extract_all(words2,"\\S+")
str_replace_all(separated,"[:punct:]","")




