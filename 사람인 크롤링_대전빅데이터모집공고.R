# 사람인에서 대전지역 빅데이터 분야 모집공고 전체 불러오기.

library(rvest)
library(stringr)
library(dplyr)

url_all <- "https://www.saramin.co.kr/zf_user/search?search_area=main&search_done=y&search_optional_item=n&searchType=search&loc_mcd=105000&cat_cd=416&cat_key=41702"

html <- read_html(url_all)

# 가져올 대상 => 공고 title, 기업 corp, 마감일 date, 구 dist, 경력 ca
# 일단 맨 첫번째 페이지 맨 첫번째 기업부터 시작.
# 1.title 가져오기
item <- html %>% 
    html_node("div#container") %>% 
    html_node(".content") %>% html_node(".item_recruit")


title <- item %>% 
    html_node("div.area_job") %>% 
    html_node(".job_tit") %>% html_node("span") %>% html_text()

title

# 2. 기업 corp 가져오기.
corp <- item %>% 
    html_node("div.area_corp") %>% 
    html_node(".corp_name") %>% html_text()
corp

# 3. 마감일 date 가져오기
date <- item %>% 
    html_node("div.area_job") %>% 
    html_node(".job_date") %>% html_text()
date

# 4. 지역위치(자치구 단위) dist 가져오기
dist <- item %>% 
    html_node("div.area_job") %>% 
    html_node(".job_condition") %>% html_nodes("a") %>% html_text()
dist <- dist[2]
dist

# 

























