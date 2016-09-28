Texty - Text prediction app
========================================================
autosize: true
transition: rotate

![alt text](http://15809-presscdn-0-93.pagely.netdna-cdn.com/wp-content/uploads/2016/02/MTIyMzI4ODIyMDQ4NzE5NDYy.png "RStudio")

Roberto Franco,  
July 2016


What is Texty?
========================================================
css: normal.css



~~Texty will guess the next word for you, to make typing simpler.~~

~~In order to do this, the app takes a text sample from 3 different sources (~~_blogs, news pages and twitter_~~), and studies the appearance and frequencies of groups of 2, 3, 4 and 5 words -called ngrams-.~~

|**Source**  |**Wordcount**|**Sample**  |
|----------|:--------:|:-------|
|Blogs     |45143796  |1000    |
|News      |32764064  |1000    |
|Twitter   |10232593  |1000    |


How does it work?
========================================================
- <small> ~~These word combinations are studied: groups of two(w2), three(w3), four(w4) and five(w5) words. Also, a list of single words is created.~~
- ~~The app will take the last words from the user's text input in order to find coincidences in the ngram tables and will assign a score to each finding. The score is the sum of two components: the first is a percentage (~~_number of appearances/total number of ngram registries_~~); the second component depends on the number of words that make up such ngram. The app then chooses the 3 findings with the highest scores and proposes them to the user.~~ 

|**Ngram**|**Score**|
|---------|---------|
|w1w2w3w4 |% + 5    |
|w2w3w4   |% + 4    |
|w3w4     |% + 3    |
|w4       |% + 2    |
|w1w3w4   |% + 1    |
</small>
Where can I use it?
========================================================

~~The ngram dictionary weighs only 21 MB so it is portable and fast to use in tablets, mobile phones and even in grandma's old computer.~~

~~The process of identifying the word combinations and their frequencies is done by Texty before you type, and a very lightweight dictionary is created for rapid use on the go.~~




```r
object.size(grams5)+object.size(grams4)+
object.size(grams3)+object.size(grams2)+
     object.size(grams1)
```

```
20986040 bytes
```


How to use it?
========================================================



~~You can try Texty on the Shiny application, right here~~ <http://tezcatlipoca.shinyapps.io/Texty/>.

~~You will only need to type on the text box and wait a fraction of a second for the word proposals to appear on the right side of the window. As simple as that.~~

**Texty always has the last word!**



