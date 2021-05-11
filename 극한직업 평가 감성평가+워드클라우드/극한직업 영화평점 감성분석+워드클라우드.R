# install.packages("XML","stringr")
library(XML)
library(stringr)

# all_reviews <- NULL
# url_base <- "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=167651&type=after&onlyActualPointYn=N&order=newest&page="

library(stringr)

all_reviews <- NULL
url_base <- "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=167651&type=after&onlyActualPointYn=N&order=newest&page="
for (i in 1:400) { 
    newr <- NULL
    url <- paste(url_base, i, sep='')
    txt <- readLines(url, encoding="UTF-8")
    
    reviews <- txt[which(str_detect(txt, "id=\"_filtered_ment"))+4] #class=score_reple를 찾으면 네이버에서 댓글스포방지를 추가해서 태그가 하나가 더 생겼습니다 그래서 차라리 위에처럼하고 4줄뒤에부터 불러오면 댓글을 가져올 수 있습니다
    reviews <- gsub("<.+?>|\t","", reviews)
    
    newr <- cbind(reviews)
    all_reviews <- rbind(all_reviews, newr)
}

write.table(all_reviews, "movie_review_Ext_J.txt")


write.table(all_reviews, "C:\\Temp\\movie_review_Ext_J.txt")


library(plyr)
library(stringr)

getwd()
setwd("C:/sentimental+crolling")


txt<-readLines("movie_review_Ext_J.txt")

positive <- readLines("positive.txt", encoding = "UTF-8")
positive=positive[-1]

negative <- readLines("negative.txt", encoding = "UTF-8")
negative=negative[-1]


sentimental = function(sentences, positive, negative){
    
scores = laply(sentences, function(sentence, positive, negative) {
        
        sentence = gsub('[[:punct:]]', '', sentence) # 문장부호 제거
        sentence = gsub('[[:cntrl:]]', '', sentence) # 특수문자 제거
        sentence = gsub('\\d+', '', sentence)        # 숫자 제거
        
        word.list = str_split(sentence, '\\s+')      # 공백 기준으로 단어 생성 -> \\s+ : 공백 정규식, +(1개 이상)
        words = unlist(word.list)                    # unlist() : list를 vector 객체로 구조변경
        
        pos.matches = match(words, positive)           # words의 단어를 positive에서 matching
        neg.matches = match(words, negative)
        
        pos.matches = !is.na(pos.matches)            # NA 제거, 위치(숫자)만 추출
        neg.matches = !is.na(neg.matches)
        
        score = sum(pos.matches) - sum(neg.matches)  # 긍정 - 부정   
        return(score)
    }, positive, negative)
    
    scores.df = data.frame(score=scores, text=sentences)
    return(scores.df)
}

result=sentimental(txt, positive, negative)

result$color[result$score >=1] = "blue"
result$color[result$score ==0] = "green"
result$color[result$score < 0] = "red"

result$remark[result$score >=1] = "긍정"

result$remark[result$score ==0] = "중립"

result$remark[result$score < 0] = "부정"

sentiment_result= table(result$remark)



pie(sentiment_result, main="감성분석 결과",
    
    col=c("blue","red","green"), radius=0.8)

sentiment_result

library(RCurl)
library(XML)
library(SnowballC)
library(tm)
library(wordcloud2)


typeof(txt)


library(tm)
library(SnowballC)

doc <- Corpus(VectorSource(txt))
inspect(doc)

doc <- tm_map(doc, removeNumbers)                 # 숫자 제거
doc <- tm_map(doc, removeWords, stopwords('english'))  # 불용어 제거
doc <- tm_map(doc, removePunctuation)             # 구두점 제거
doc <- tm_map(doc, stripWhitespace)                # 앞뒤 공백 제거

hdoc <- gsub('[^ㄱ-ㅎ|ㅏ-ㅣ|가-힣 ]', '', doc)

corpus <- Corpus(VectorSource(hdoc))   # hdoc활용해서 말뭉치 만들기.
inspect(corpus)
dtm <- DocumentTermMatrix(corpus)
inspect(dtm)      

m <- as.matrix(dtm)   # DTM list를 Matrix로 변환.
m
typeof(m)
v <- sort(colSums(m), decreasing = T)    # 단어 빈도수가 높은 애들부터 위로 올라오게 나열됨.
v[1:5]

df <- data.frame(word = names(v), freq = v)   # word, 빈도의 2열로 구성된 데이터 프레임으로 만든 것.
df
head(df)



d100 <- df[1:100, ]

wordcloud2(d100, shape = '')
wordcloud2(d100, minRotation = pi/6, maxRotation = pi/3, rotateRatio = 1.0)    # "영화" 키워드 빼야하는디...





