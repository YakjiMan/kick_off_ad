import nltk
from konlpy.tag import Okt
import requests
from bs4 import BeautifulSoup
from collections import Counter
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import rc
from wordcloud import WordCloud
from sklearn.linear_model import LinearRegression
import csv
import dbm

db = dbm()
db.DBOpen("192.168.0.21", "kickoff", "root", "ezen")
sql = "select post_no,post_note from post "
db.RunQuery(sql)

total = db.GetTotal()

for i in range(0,total) :
    post_no = db.GetValue(i,"post_no")
    print(post_no)
db.DBClose()

"""
#형태소 분석을 시작한다.
Okt   = Okt()

for i in range(0,99):
    mURL = "http://localhost:8085/kick_off/news_view.jsp?no=" + str(i)
    response = requests.get(mURL)
    
    print(mURL)
    
    soup    = BeautifulSoup(response.text,"html.parser")
    
    #script 태그를 모두 삭제한다.
    [s.extract() for s in soup("script")]
    content = soup.select("body > div.main > div > div:nth-child(8)")
    textAll = ""
    for item in content:
        text     = item.getText()
        textAll += text
    
    #형태소 분석 (모든 품사)
    # words = Okt.morphs(textAll)
    # print(words)
    
    #형태소 분석 (명사)
    nouns = Okt.nouns(textAll)
    
    #불용어 제거
    #한글자는 제거
    for x,v in enumerate(nouns):
        if len(v) < 2:
            nouns.pop(x)
    
    #명사 빈도 계산
    count = Counter(nouns)
    
    nouns = count.most_common(3000)
    
    #판다스에서 투플 변환
    words = ["post_no : " + str(i)]
    count = ["빈도수"]
    print("번호 : " + str(i))
    for item in nouns:
        words.append(item[0])
        count.append(item[1])
        
    print("words" , words)
    print("count" , count)
    
    with open("D:\\SHS\\python\\Project\\test2.csv"
              ,"a",newline = "",encoding = "utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(words)
        writer.writerow(count)
        writer.writerow("")
    



    # ####################################################################
    # ####################################################################
    # if(len(words) > 2):
    #     nouns = [words,count]
    #     df = pd.DataFrame(nouns)
    #     df = df.transpose()
    #     df.columns = ["단어","빈도수"]
        
    #     #빈도수를 숫자로 변환
    #     df["빈도수"] = df["빈도수"].astype("int64")
    #     print(df)
        
    #     #단어로 정렬
    #     df = df.sort_values("단어")
    #     print(df)
        
    #     #단어별 시각화 ===============================
    #     #한글 설정
    #     rc("font",family = "Malgun Gothic")
    #     plt.figure(figsize = (20,10))
    #     plt.plot(df["단어"],df["빈도수"],label = "빈도수")
    #     plt.legend()
    #     plt.title("단어별 빈도")
    #     plt.xticks(rotation = 45)
    #     plt.grid(True)
    #     plt.show()
        
    #     #워드 클라우드 표시용 딕셔너리로 변환
    #     wordlist = {}
    #     for i in range(0,df["단어"].count()):
    #         #print(df["단어"][i])
    #         #print(df["빈도수"][i])
    #         wordlist[df["단어"][i]] = df["빈도수"][i]
            
    #     #print(wordlist)
        
    #     #워드 클라우드 표시 ==========================
    #     wordcloud = WordCloud(font_path = "D:\\SHS\\python\\korea\\HANYGO230.ttf",
    #                           relative_scaling = 0.5,
    #                           background_color = "white")
        
    #     wordcloud.generate_from_frequencies(wordlist)
    #     plt.figure(figsize = (20,10))
    #     plt.imshow(wordcloud)
    #     plt.axis("off")
    #     plt.show()
"""    