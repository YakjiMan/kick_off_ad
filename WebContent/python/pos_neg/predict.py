from konlpy.tag import Okt
import json
import os
import numpy as np
import DBManager as db
import tensorflow
import matplotlib.pyplot as plt
from tensorflow.keras import models
    
okt = Okt()

def tokenize(doc):
    # norm은 정규화, stem은 근어로 표시하기를 나타냄
    return ['/'.join(t) for t in okt.pos(doc, norm=True, stem=True)]

def term_frequency(doc):
    return [doc.count(word) for word in selected_words]


def predict_pos_neg(review):
    token = tokenize(review)
    tf = term_frequency(token)
    data = np.expand_dims(np.asarray(tf).astype('float32'), axis=0)
    score = float(model.predict(data))
    if(score > 0.5):
        # print("[{}]는 {:.2f}% 확률로 긍정".format(review, score * 100))
        return 1, score * 100
    else:
        # print("[{}]는 {:.2f}% 확률로 부정".format(review, (1 - score) * 100))
        return (-1) , (1 - score) * 100
        
if os.path.isfile('train_docs.json'):
    with open('train_docs.json', 'rt', encoding='UTF-8') as f:
        train_docs = json.load(f)
    with open('test_docs.json', 'rt', encoding='UTF-8') as f:
        test_docs = json.load(f)
    with open('selwords_docs.txt', 'rt', encoding='UTF-8') as f:
        selected_words = json.load(f)

with open("selwords_docs.txt", encoding="UTF-8") as f:
    selected_words = json.load(f)


db = db.DBManager()
db.DBOpen("192.168.0.21", "kickoff", "root", "ezen")
sql = "select post_no,post_note from post"
db.OpenQuery(sql)
total = db.GetTotal()
db.CloseQuery()
#데이터 베이스에서 내용 가져오기
# print("-"*20)
# print("total\n",total)
db.DBOpen("192.168.0.21", "kickoff", "root", "ezen")
##=====================================================
for t in range(0,total):
    
    sql = "select post_no,post_note from post"
    db.OpenQuery(sql)
    post_note = db.GetValue(t,"post_note")
    
    #/p 태그를 기점으로 나누기
    note = post_note.split("</p>")
    # print("len:note \n",len(note[1]))
    # print("note : \n",note)
    
    #문장이 아니라고 판단되는 짧은글 쳐내기
    data_list = []
    for n in range(0,len(note)-1):
        if (len(note[n]) > 10):
            data_list.append(note[n])
            
    note = data_list
    # print("-"*20)
    # print(len(note))
    # print(note[:3])
    post_no = db.GetValue(t,"post_no")
    # print("-"*20)
    # print("post_no :  ",post_no)
    
    
    # 모델 불러오기
    # model = models.Sequential()
    model = tensorflow.keras.models.load_model('save_model.h5')
    # model.summary()
    
    #DB에서 글 가져온후 합산 스코어 구하기
    summ     = 0
    sentence = []
    posneg   = []
    result   = ""
    for a in range(0,len(note)-1):
        score , percent = predict_pos_neg(note[a])
        sentence.append(note[a])
        posneg.append(score * percent)
        if score == 1:
            print("[{}]는 {:.2f}% 확률로 긍정".format(note[a], percent))
        else:
            print("[{}]는 {:.2f}% 확률로 부정".format(note[a], percent))
        summ += score
        print("긍부정 : ",predict_pos_neg(note[a]))
        
    # print(posneg)
    # print(sentence)
    print("score : ",summ)
    if(len(note) != 0):
        print(int(float("{:.2}".format(summ  / len(note) ))*100))
        percent = str(int(float("{:.2}".format(summ / len(note)))*100))
    else:
        print(0)
        percent = str(0)
        
    
    if(int(percent) > -50):
        result = "p"
    else:
        result = "n"
    
    #데이터 시각화
    x = np.arange(len(posneg))
    y = []
    for i in range(0,len(posneg)):
        y.append(i)
    
    plt.title("pos_neg percent for sentence")
    plt.xlabel('"n"th sentence')
    plt.ylabel('pos_neg percent')
    plt.bar(x, posneg)
    plt.xticks(x, y)
    # plt.show()
    figname = str(post_no) + "_figure"
    plt.savefig('./pos_neg_fig/' + figname, facecolor='#eeeeee', dpi=200)
    plt.show()
    
    sql = "update post set post_figname='" + figname + ".png',"
    sql += " post_posneg='" + result + "',"
    sql += " post_percent=" + percent
    sql += " where post_no = " + str(post_no)
    db.RunSQL(sql)
    print(sql)
    
##======================================================================

db.DBClose()





