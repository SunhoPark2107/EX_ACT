library(dplyr)


row_num = 100  #생성할 데이터 셋의 행 개수

create_tmp = function(row_num) {
  
  # create data pool
  name_list = c('소연','환희','서연','서윤','서현','지우','민서','하은','하윤','윤서','지민','채원','지유','지윤','은서',
                '예은','다은','수아','수빈','예원','지원','소율','지아','예린','소윤','유진','시은','서영','가은','민지',
                '채은','민준','서준','예준','도윤','주원','시우','지후','준서','지호','하준','현우','준우','지훈','도현',
                '건우','우진','현준','민재','선우','서진','준혁','승현','유준','승우','지환','승민','민성','시윤')
  gender_list = c('F','M')
  major_list = c('사회학과','행정학과','자치행정학과','정치학과','사회복지학과','문헌정보학과','언론정보학과')
  grade_list = c('1','2','3','4')
  score_list =c(4.5,4.0,3.5,3.0,2.5,2.0,1.5,1.0,0)
  
  
  
  # create columns : 앞서 지정한 row_num 길이의 데이터 생성
  name = sample(name_list,row_num,replace = TRUE)
  gender = sample(gender_list,row_num,replace = TRUE)
  major = sample(major_list,row_num,replace = TRUE)
  grade = sample(grade_list,row_num,replace = TRUE)
  score = sample(score_list,row_num,replace = TRUE)
  
  
  
  
  # create table
  tmp = data.frame(name,gender,major,grade,score)
  
  
  
  
  # create rank column
  tmp = tmp %>% dplyr::mutate(rank = ifelse(score >= 4.0,'A',
                                        ifelse((score < 4.0) & (score >= 3.0),'B',
                                               ifelse((score < 3.0) & (score >= 2.0),'C',
                                                      ifelse((score < 2.0) & (score >= 1.0),'D','E')))))
  
  
  return(tmp)
}


tmp = create_tmp(row_num)










##1) 연습문제 -----

#주어진 데이터 셋에서 전체 평균학점을 구하시오. (1점)





##2) 연습문제 -----

#주어진 데이터 셋에서 전공별 평균학점을 구하시오. (2점)





##3) 연습문제 -----

#주어진 데이터 셋에서 전공별 과탑의 이름과 학점을 구하고, 전공별 '학점' 내림차순으로 정렬하시오. (3점)





##4) 연습문제 -----

#주어진 데이터 셋에서 전공별로 남자와 여자의 평균 학점과 rank의 최빈값을 구하시오. (3점)





##5) 연습문제 -----

#주어진 데이터 셋에 'rank_new' 컬럼을 만들고, 학점(score)의 소숫점 첫번째 자리가 '0.5'인 경우, 
#기존 rank 뒤에 '+'를 붙여 새로운 학점을 부여하시오. (4점)






