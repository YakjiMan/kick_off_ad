from db.DBManager import DBManager
from konlpy.tag import Okt
from gensim.models.word2vec import Word2Vec
import re
from collections import Counter

filename = "test101"
okt = Okt()
stopwords = ['리뷰','다그','구독','의','가','이','은','을','들','는','좀','잘','걍','과','도','를',
             '으로','자','것','때','수','듯','에','와','한','하다','다','리','로','그',
             '재','및','최','중','마','등','데','구보','라며','조금','이번']


model_okt = Word2Vec.load('word2vec_'+filename+'.model')

db = DBManager()
db.DBOpen("192.168.0.21", "kickoff", "root", "ezen")
sql = "select * from analyze_data1"
db.OpenQuery(sql)
data = db.GetValueAll()
#print(data)
#print(len(data))
cNO = 0;

for item in data :
    #print("cNO : " , cNO)
    cNO += 1
    anal_no = item[0]
    morph_origin_key = item[1]
    post_no = item[2]
    anal_count = item[3]
    #print(item[0],item[1],item[2],item[3])

    try:
        anal_sentence = model_okt.wv.most_similar(item[1], topn= 50)
        #print(item[1] ,":" , anal_sentence)
        #print(anal_sentence[0][0],anal_sentence[0][1])
        total = len(anal_sentence)
        #print("total:",total)
        for v in range(total): 
            sql =  "insert into analyze_data2(anal_no,morph_relation_key ,sim)"
            sql += "values('"+str(anal_no)+"','"+anal_sentence[v][0]+"','"+str(anal_sentence[v][1])+"')"
            db.RunSQL(sql)
            print(sql)       
    except:
        print(item[1],"오류")
db.CloseQuery()
db.DBClose()
    
   

        
    
    