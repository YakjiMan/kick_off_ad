import warnings
warnings.filterwarnings("ignore")
from selenium import webdriver
from bs4 import BeautifulSoup
from gensim.models.word2vec import Word2Vec
from konlpy.tag import Okt
from tqdm import tqdm
import re
import datetime
from datetime import timedelta


# 윈도우용 크롬 웹드라이버 실행 경로 (Windows)
window_path = "chromedriver.exe"

answer_urls = []
# 사이트의 html 구조에 기반하여 크롤링을 수행합니다.

today = datetime.datetime.today() + timedelta(days=1)
for i in range(10) :
    today = today - timedelta(days=1)
    todays = today.strftime('%Y%m%d')
    print(todays)
    
    for i in range(1,10):
        # 크롤링할 사이트 주소를 입력합니다.
        source_url1 = "https://sports.news.naver.com/wfootball/news/index?isphoto=N&date="
        source_url2 = "&page="
        Surl = source_url1+todays+source_url2+str(i)
        print("Surl:",Surl)
        def get_list() :
            
            driver = webdriver.Chrome(window_path)  # for Windows
            driver.get(Surl)
            req = driver.page_source
            soup = BeautifulSoup(req, "html.parser")
            cluster_text = soup.find_all(name="div", attrs={"class":"text"})
            # a태그의 href 속성을 리스트로 추출하여, 크롤링 할 페이지 리스트를 생성합니다.
            page_urls = []
            for index in range(0, len(cluster_text)):
                cluster = cluster_text[index]
                news_url = cluster.find(name="a", attrs={"class":"title"})
                if news_url is not None:
                    #print("문자열 판단 ",news_url.get("href").find("/photocenter/"))
                    if news_url.get("href").find("/photocenter/") == -1 :
                        page_urls.append("https://sports.news.naver.com"+news_url.get("href"))
            # 중복 url을 제거합니다.
            page_urls = list(set(page_urls))
            
            # 크롤링에 사용한 브라우저를 종료합니다.
            driver.close()
            return page_urls
        page_urls = get_list()
        answer_urls = answer_urls + page_urls
        print("answer_urls:",answer_urls)
        print("answer_urls 갯수:",len(answer_urls))
    

# 기사 본문을 크롤링합니다

def get_article(page_urls) :
    driver = webdriver.Chrome(window_path)  # for Windows
    result = []
    for page in page_urls:
        driver.get(page)
        req = driver.page_source
        soup = BeautifulSoup(req, 'html.parser')
        title_area = soup.find(name="div", attrs={"class":"news_headline"})
        try:
            title = title_area.find_all('h4')[0]
        except AttributeError:
            continue
        try:    
            content_paragraphs = soup.find(name="div", attrs={"id":"newsEndContents"})
        except AttributeError:
            continue
        content_corpus = content_paragraphs.text
        result.append(content_corpus)
        #print("content_corpus:",content_corpus)
    # 크롤링에 사용한 브라우저를 종료합니다.
    driver.close()
    return result
contents = get_article(answer_urls)
#print("contents:",contents)



#파일들
train_data = contents
    
# 정규 표현식을 통한 한글 외 문자 제거
train_data[i] = re.sub(r"[^ㄱ-ㅎㅏ-ㅣ가-힣 ]", "", train_data[i])
#print("train_data:",train_data)
# 불용어 정의
stopwords = ['리뷰','다그','구독','의','가','이','은','을','들','는','좀','잘','걍','과','도','를',
             '으로','자','것','때','수','듯','에','와','한','하다','다','리','로','그',
             '재','및','최','중','마','등','데','구보','라며','조금','이번']
    
# 형태소 분석기 OKT를 사용한 토큰화 작업 (다소 시간 소요)

okt = Okt()

tokenized_data = []
for sentence in tqdm(train_data):
#    tokenized_sentence = okt.morphs(sentence, stem=True) # 토큰화
    tokenized_sentence = okt.nouns(sentence) # 토큰화
    remove_one_word = [x for x in tokenized_sentence if len(x)>1]
    stopwords_removed_sentence = [word for word in remove_one_word if not word in stopwords] # 불용어 제거
    tokenized_data.append(stopwords_removed_sentence)
    
print("갯수:",len(tokenized_data))
print("tokenized_data:",(tokenized_data))

model = Word2Vec(sentences= tokenized_data, vector_size= 300, window = 5, min_count = 2, workers = 8, sg = 1)

model.wv.save_word2vec_format('test101_w2v')
# 학습모델 저장
model.save('word2vec_test101.model')

# 완성된 임베딩 매트릭스의 크기 확인
print(model.wv.vectors.shape)
