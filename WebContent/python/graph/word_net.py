    import warnings
warnings.filterwarnings("ignore")

from selenium import webdriver
from bs4 import BeautifulSoup
import re

# 윈도우용 크롬 웹드라이버 실행 경로 (Windows)
window_path = "chromedriver.exe"

# 크롤링할 사이트 주소를 입력합니다.
source_url = "https://news.naver.com/main/main.naver?mode=LSD&mid=shm&sid1=100"

# 사이트의 html 구조에 기반하여 크롤링을 수행합니다.
def get_list() :
    driver = webdriver.Chrome(window_path)  # for Windows
    driver.get(source_url)
    req = driver.page_source
    soup = BeautifulSoup(req, "html.parser")
    cluster_text = soup.find_all(name="div", attrs={"class":"cluster_text"})

    # a태그의 href 속성을 리스트로 추출하여, 크롤링 할 페이지 리스트를 생성합니다.
    page_urls = []
    for index in range(0, len(cluster_text)):
        cluster = cluster_text[index]
        news_url = cluster.find(name="a", attrs={"class":"cluster_text_headline nclicks(cls_pol.clsart)"})
        if news_url is not None:
            page_urls.append(news_url.get("href"))
    # 중복 url을 제거합니다.
    page_urls = list(set(page_urls))
    print(page_urls)
    # 크롤링에 사용한 브라우저를 종료합니다.
    driver.close()
    return page_urls

# 기사 본문을 크롤링합니다
def get_article(page_urls) :
    driver = webdriver.Chrome(window_path)  # for Windows
    result = []
    for page in page_urls:
        driver.get(page)
        req = driver.page_source
        soup = BeautifulSoup(req, 'html.parser')
        title_area = soup.find(name="div", attrs={"class":"media_end_head_title"})
        title = title_area.find_all('h2')[0]
        print(title)
        content_paragraphs = soup.find(name="div", attrs={"class":"newsct_article"})
        print(content_paragraphs)
        content_corpus = content_paragraphs.text
        result.append(content_corpus)
    # 크롤링에 사용한 브라우저를 종료합니다.
    driver.close()
    return result


page_urls = get_list()
print(len(page_urls))
contents = get_article(page_urls[:3])

###특수문자 제거하기###
def re_compile(str) :
    import re
    compile = re.compile("[^ ㄱ-ㅣ가-힣]+")
    return compile.sub("", str)

def re_compile_list(list) :
    result = []
    for item in list :
        result.append(re_compile(item))
    return result

# 한글만 뽑아내기
contents_ko = re_compile_list(contents)

from konlpy.tag import Okt
okt = Okt()

# 2글자 이상의 명사만 추출
def get_nouns_list(str) :
    result = []
    tmp = okt.nouns(str)
    for item in tmp :
        if len(item) > 1 :
            result.append(item)
    return result

# 명사만 추출하는데, 비어있는 리스트 항목은 건너뜀
list_words = [ get_nouns_list(item) for item in contents_ko if len(item) > 0]

###텍스트에서 많이 나온 단어###
import pandas as pd
top_words = pd.Series(list_words).value_counts().head(10)

print("="*50)
print("top_words")
print(top_words)


count = {}
for list in list_words :
    for index, a in enumerate(list) :
        for b in list[index+1:] :
            if a == b : continue
            if a>b:
                count[b, a] = count.get((b, a),0) +1
            else :
                count[a, b] = count.get((a, b),0) +1

df = pd.DataFrame.from_dict(count, orient='index')
print("="*50)
print("데이터프레임으로 변환 \n")

list = []
for i in range(len(df)) :
    list.append([df.index[i][0],df.index[i][1],df[0][i]])
df2 = pd.DataFrame(list, columns=['word_a', 'word_b', 'freq']).sort_values(by=['freq'], ascending=False)

print(df2[:30])
df3 = df2[['word_a', 'word_b']][:50]
wordnet_data = []

for a, b in zip(df3['word_a'], df3['word_b']) :
    wordnet_data.append([a,b])

print("="*50)
print(wordnet_data)
