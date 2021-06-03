library(jsonlite)
library(RCurl)
library(XML)

service_url <- 'http://www.dcco.kr/api/openData/code.xml'
api_key <- readLines('C:/Users/CPB06GameN/Desktop/abc/0528key2.txt')
stdate <- '2017-09-01'
endate <- '2017-09-01'

url <- sprintf('%s?serviceKey=%s&type=C&stdate=%s&endate=%s',
               service_url, api_key, stdate, endate)



# url_1 <- 'https://www.dcco.kr/api/openData/code.xml?serviceKey=kG1%2FE4Fel3CpR2FRSZQTHVuTb255O85oysrdd1RF2Sijp%2Bdbj0QTmkYYoRRPdOPjTGOqVKcT0JpFaGJ0KWsYdg%3D%3D&type=C&stdate=2017-01-01&endate=2017-01-01'
# response <- fromJson(url, Encoding('EUC-KR'))

doc <- xmlTreeParse(url,useInternal=TRUE)

rootNode <- xmlRoot(doc)


