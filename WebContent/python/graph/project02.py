import DBManager as DB
from gensim.models.word2vec import Word2Vec
#시각화를 위한 t-sne -pca  
model_okt = Word2Vec.load('ko.bin')

#벡터값 호출
#print('벡터 값 호출')
#print('한효주 벡터값:', model_okt.wv['치킨'])

#단어간 유사도확인
#print('단어간 유사도 확인')
#print('유사도:','축구','치킨', model_okt.wv.similarity(w1='축구',w2='치킨'))

#유사도 top 10
print('단어간 유사도')

s1 = model_okt.wv.most_similar("갈증", topn= 1000)
print(s1)
db = DB.DBManager()
db.DBOpen("192.168.0.21", "kickoff", "root", "ezen")
try:
    anal_sentence = model_okt.wv.most_similar(s1[0][0], topn= 50)
    #print(item[1] ,":" , anal_sentence)
    #print(anal_sentence[0][0],anal_sentence[0][1])
    total = len(anal_sentence)
    print(len(anal_sentence))
    #print("total:",total)
    s2 = ""
    for v in range(0,1000):
        s2 = s1[v][0]+ "," +s2
    print(s2) 
      
    sql =  "insert into ad_info(ad_name,ad_keyword)"
    sql += "values('포카리스웨트','"+s2+"')"
    db.RunSQL(sql)
    print(sql) 
except:
    print("오류")
        
db.CloseQuery()
db.DBClose()

    