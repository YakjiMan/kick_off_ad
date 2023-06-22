import pandas as pd
import matplotlib.pyplot as plt
import urllib.request
from gensim.models.word2vec import Word2Vec
from konlpy.tag import Okt
from tqdm import tqdm
from konlpy.tag import Mecab
from gensim.models import KeyedVectors  

'''
urllib.request.urlretrieve("https://raw.githubusercontent.com/e9t/nsmc/master/ratings.txt", filename="ratings.txt")
'''
#파일들
train_data = pd.read_table('ratings.txt')
print(train_data[:10]) # 상위 5개 출력
print("=" * 50)

print(len(train_data)) # 리뷰 개수 
print("=" * 50)

print(train_data.isnull().values.any()) # 결측값 유무
print("=" * 50)

train_data = train_data.dropna(how = 'any') # Null 값이 존재하는 행 제거
print(train_data.isnull().values.any()) # Null 값이 존재하는지 확인
print("=" * 50)

print(len(train_data)) # 리뷰 개수 출력
print("=" * 50)
# 정규 표현식을 통한 한글 외 문자 제거
train_data['document'] = train_data['document'].str.replace("[^ㄱ-ㅎㅏ-ㅣ가-힣 ]", "")
print(train_data[:10]) # 리뷰 개수 
print("=" * 50)

# 불용어 정의
stopwords = ['의','가','이','은','을','들','는','좀','잘','걍','과','도','를','으로','자','것','때','수','듯','에','와','한','하다','다','리','로','그']

# 형태소 분석기 OKT를 사용한 토큰화 작업 (다소 시간 소요)

okt = Okt()

tokenized_data = []
for sentence in tqdm(train_data['document'][0:1]):
#    tokenized_sentence = okt.morphs(sentence, stem=True) # 토큰화
    tokenized_sentence = okt.nouns(sentence) # 토큰화
    stopwords_removed_sentence = [word for word in tokenized_sentence if not word in stopwords] # 불용어 제거
    tokenized_data.append(stopwords_removed_sentence)

print(tokenized_data)
'''
print('리뷰의 최대 길이 :',max(len(review) for review in tokenized_data))
print('리뷰의 평균 길이 :',sum(map(len, tokenized_data))/len(tokenized_data))

print("=" * 50)

model = Word2Vec(sentences= tokenized_data, vector_size= 150, window = 5, min_count = 3, workers = 8, sg = 1)
model.wv.save_word2vec_format('naver_w2v')
# 학습모델 저장
model.save('word2vec_oktreview.model')
# 완성된 임베딩 매트릭스의 크기 확인
print(model.wv.vectors.shape)

'''
