# 공공데이터포털 대전광역시 생활폐기물 처리 정보 가져오기

library(jsonlite)
library(RCurl)
library(dplyr)

# getOption 사용하면 뒤 코드 안돌아가는 경우 생김.
# getOption("encoding")
# options(encoding = "UTF8")



service_url <- 'http://www.dcco.kr/api/openData/code.json'
api_key <- readLines('C:/Users/CPB06GameN/Desktop/abc/0528key2.txt')
stdate <- '2017-09-01'
endate <- '2017-09-01'



url <- sprintf('%s?serviceKey=%s&type=C&stdate=%s&endate=%s',
               service_url, api_key, stdate, endate)

Sys.setlocale("LC_CTYPE", "korean")
fromJSON(url, encoding = "UTF-8")

tmp = readLines(url, n=-1, warn = "F", encoding="UTF-8") %>% iconv(.,"EUC-KR","UTF-8")
n = grep('codeGroup',tmp)
data_corpus = tmp[n] %>% gsub('"',"",.)
strsplit(data_corpus,split='\\},\\{')

######################################################################

response <- fromJSON(url)
# response <- fromJSON(getURL(url, warn = FALSE)

readlines <- readLines(url, warn = FALSE)
readlines

par1 <- fromJSON(readlines, Encoding = 'utf-8')
par1

data1 <- readLines(url, warn = FALSE, encoding="UTF-8") %>% fromJSON()
data1

########################################################################
Sys.setlocale("LC_CTYPE", "korean")
response <- fromJSON(url, encoding = "UTF-8")
response <- fromJSON(url, encoding = "EUC_KR")
Sys.setlocale("LC_CTYPE", "korean")
fromJSON(url, encoding = "UTF-8")
