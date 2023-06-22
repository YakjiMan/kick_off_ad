"""
형태소분석기 설치 방법
conda install -c conda-forge jpype1
pip install konlpy
"""
import requests
import pandas as pd
import matplotlib.pyplot as plt

from matplotlib import rc
from konlpy.tag import Okt
from bs4 import BeautifulSoup
from nltk import word_tokenize
from urllib.parse import quote
from wordcloud import WordCloud
from collections import Counter

mURL = "https://n.news.naver.com/mnews/article/015/0004836149?sid=101"
mURL = "https://n.news.naver.com/mnews/article/003/0011824056?sid=101"
agent_head = {
        "user-agent" : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36",
        "accept" : "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
    }
response = requests.get(mURL,headers=agent_head)
soup = BeautifulSoup(response.text, "html.parser")

#script 태크를 모두 삭제한다.
[s.extract() for s in soup('script')]

#본문을 가져온다
content = soup.select("#dic_area")
textAll = ""
for item in content:
    text = item.getText()
    textAll += text

#형태소 분석을 시작한다. ========================================
Okt = Okt()

#형태소 분석 (명사)
nouns = Okt.nouns(textAll)

#한글자는 제거
for i,v in enumerate(nouns):
    if len(v) < 2:
        nouns.pop(i)

#명사 빈도 계산
count = Counter(nouns)
nouns = count.most_common(50)

#판다스에서 튜플을 변환
words = []
count = []
for item in nouns :
    words.append(item[0])
    count.append(item[1])
nouns = [words,count]
df = pd.DataFrame(nouns)
df = df.transpose()
df.columns  = [ "단어", "빈도수"]

#빈도수를 숫자로 변환
df["빈도수"] = df["빈도수"].astype("int64")

#단어로 정렬
df = df.sort_values("단어")

#한글 설정
rc('font', family='Malgun Gothic')

#워드 클라우드 표시용 딕셔너리로 변환
#path = "X:\\TEST\\JSP_PY_JDK8\\WebContent\\"
path = "D:\\GH\\JAVA\\teamproject\\JSP_PY_JDK8\\WebContent\\"
wordname  = "worddata.txt"

# 파일에 워드 데이타를 저장한다
filename = path + wordname
f = open(filename,"w",encoding="utf-8")
f.write("text,frequency\n")

wordlist = {}
for i in range(0,df["단어"].count()):
    wordlist[df["단어"][i]] = df["빈도수"][i]
    if i < 20 :
        line = df["단어"][i] + "," + str(df["빈도수"][i] * 10)
        f.write(line + "\n")
f.close()

#워드 클라우드 표시 ========================================
wordcloud = WordCloud(font_path = path + "py\\HANYGO230.ttf",
                      relative_scaling = 0.5,
                      background_color='white',
                      );
wordcloud.generate_from_frequencies(wordlist)

plt.figure(figsize=(20,10))
imgname  = "plot.jpg"
filename = path + "plot\\" + imgname
wordcloud.to_file(filename)
print(imgname)

# plt.savefig(filename, dpi=300)
# plt.imshow(wordcloud)
# plt.axis("off")
# plt.show()
