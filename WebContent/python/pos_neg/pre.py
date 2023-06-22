from konlpy.tag import Okt
import json
import os
from pprint import pprint
import nltk
import numpy as np
import pandas as pd
    
okt = Okt()

def read_data(filename):
    with open(filename, 'rt', encoding='UTF-8') as f:
        data = [line.split('\t') for line in f.read().splitlines()]
        # txt 파일의 헤더(id document label)는 제외하기
        data = data[1:]
    return data

train_data = read_data('ratings_train.txt')
test_data  = read_data('ratings_test.txt')

def tokenize(doc):
    # norm은 정규화, stem은 근어로 표시하기를 나타냄
    return ['/'.join(t) for t in okt.pos(doc, norm=True, stem=True)]
   
    
if os.path.isfile('train_docs.json'):
    with open('train_docs.json', 'rt', encoding='UTF-8') as f:
        train_docs = json.load(f)
    with open('test_docs.json', 'rt', encoding='UTF-8') as f:
        test_docs = json.load(f)
else:
    train_docs = [(tokenize(row[1]),row[2]) for row in train_data]
    test_docs = [(tokenize(row[1]),row[2]) for row in test_data]
    # JSON 파일로 저장
    with open('train_docs.json', 'w', encoding="utf-8") as make_file:
        json.dump(train_docs, make_file, ensure_ascii=False, indent="\t")
    with open('test_docs.json', 'w', encoding="utf-8") as make_file:
        json.dump(test_docs, make_file, ensure_ascii=False, indent="\t")


tokens = [t for d in train_docs for t in d[0]]

#불용어 설정 및 제거
stopwords = pd.read_csv("stop_words.txt").values.tolist()
stop_words = set([x[0] for x in stopwords])
add_words = {'하다', '보다','있다','없다','너무','이다','영화',
           '되다','않다','같다','만들다','그냥','보고','정말',
           '가다','들다','진짜','싶다','정도','오다','많다',
           '연기','배우','그리고','부분','나다','편이','분들',
            '작품','아니다','되는','겁니다','감독','합니다','싶을','같네','.'}
stop_words = stop_words.union(add_words)
stop_words = list(stop_words)

stop_text = []
for tt in range(0,len(stop_words)-1):
    stop_text += ['/'.join(t) for t in okt.pos(stop_words[tt], norm=True, stem=True)]

tokens = [word for word in tokens if not word in stop_text] # 불용어 제거
tokens = [word for word in tokens if not "Punctuation" in word]
tokens = [word for word in tokens if not "Number" in word]
tokens = [word for word in tokens if not "KoreanParticle" in word]
tokens = [word for word in tokens if not "Foreign" in word]
# print("스탑:" , stop_text)
print("토큰 : " , tokens)
text = nltk.Text(tokens, name='NMSC')
# 시간이 꽤 걸립니다! 시간을 절약하고 싶으면 most_common의 매개변수를 줄여보세요.
selected_words = [f[0] for f in text.vocab().most_common(5000)]

selwords_docs = selected_words

with open('selwords_docs.txt', 'w', encoding="utf-8") as make_file:
    json.dump(selwords_docs, make_file, ensure_ascii=False, indent=" ")
    
print(selected_words)

def term_frequency(doc):
    return [doc.count(word) for word in selected_words]

train_x = [term_frequency(d) for d, _ in train_docs]
test_x = [term_frequency(d) for d, _ in test_docs]
train_y = [c for _, c in train_docs]
test_y = [c for _, c in test_docs]

x_train = np.asarray(train_x).astype('float32')
x_test = np.asarray(test_x).astype('float32')

y_train = np.asarray(train_y).astype('float32')
y_test = np.asarray(test_y).astype('float32')

from tensorflow.keras import models
from tensorflow.keras import layers
from tensorflow.keras import optimizers
from tensorflow.keras import losses
from tensorflow.keras import metrics

model = models.Sequential()
model.add(layers.Dense(64, activation='relu', input_shape=(5000,)))
model.add(layers.Dense(64, activation='relu'))
model.add(layers.Dense(1, activation='sigmoid'))

model.compile(optimizer=optimizers.RMSprop(lr=0.001),
             loss=losses.binary_crossentropy,
             metrics=[metrics.binary_accuracy])

model.fit(x_train, y_train, epochs=10, batch_size=512)
model.save("save_model.h5")
results = model.evaluate(x_test, y_test)

print(results)

def predict_pos_neg(review):
    token = tokenize(review)
    tf = term_frequency(token)
    data = np.expand_dims(np.asarray(tf).astype('float32'), axis=0)
    score = float(model.predict(data))
    if(score > 0.5):
        print("[{}]는 {:.2f}% 확률로 긍정".format(review, score * 100))
    else:
        print("[{}]는 {:.2f}% 확률로 부정".format(review, (1 - score) * 100))
        
        
predict_pos_neg("올해 최고의 영화! 세 번 넘게 봐도 질리지가 않네요.")
predict_pos_neg("배경 음악이 영화의 분위기랑 너무 안 맞았습니다. 몰입에 방해가 됩니다.")
predict_pos_neg("주연 배우가 신인인데 연기를 진짜 잘 하네요. 몰입감 ㅎㄷㄷ")
predict_pos_neg("믿고 보는 감독이지만 이번에는 아니네요")
predict_pos_neg("주연배우 때문에 봤어요")































