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
word = "토트넘"
keword = "콘테"

db = DBManager()
db.DBOpen("192.168.0.21", "kickoff", "root", "ezen")
sql = "select post_no,post_note from post where post_posneg = 'p'"
db.OpenQuery(sql)
total = db.GetTotal()
data = db.GetValueAll()
print("받아온 데이터 개수 : ",total)
print(len(data))
tokenized_data = []
cNO = 0;

for item in data :
    print("cNO : " , cNO)
    cNO += 1
    post_no = item[0]
    post_note = item[1]

    post_note = re.sub(r"[^ㄱ-ㅎㅏ-ㅣ가-힣 ]", "", post_note)
    
    #print("post_note:",post_note)
    #print("=" * 40)
    
    tokenized_sentence = okt.nouns(post_note) # 토큰화
    tokenized_sentence = [x for x in tokenized_sentence if len(x)>1]
    tokenized_sentence = [word for word in tokenized_sentence if not word in stopwords] # 불용어 제거
    
    print("갯수:",len(tokenized_sentence))
    if len(tokenized_sentence) == 0 :
        continue
    print("tokenized_sentence:",(tokenized_sentence))  
    tokenized_data.append(tokenized_sentence)
    
    count = Counter(tokenized_sentence)
    print("count:",count)
    count_list = count.most_common(5)
    
    #빈도수 접근 [0][1] =빈도수
    #빈도수 접근 [0][0] =명사
    '''
    for x in count_list:
        print("빈도수:",x)
        print('단어간 유사도')
        print(count_list[0][0] ,":" , model_okt.wv.most_similar(count_list, topn= 5))
        print("=" * 30)
    '''
    '''    
    #벡터값 호출
    print('벡터 값 호출')
    print( ,'벡터값:', model_okt.wv[word])
    print("=" * 30)
    #단어간 유사도확인
    print('단어간 유사도 확인')
    print('유사도:',word,' ',keword,' ',model_okt.wv.similarity(w1=word,w2=keword))
    print("=" * 30)
    '''
    
    if len(count_list) < 5 :
        continue
    try:
        sql = "insert into analyze_data1(morph_origin_key,anal_count,post_no)"
        sql += "values('"+count_list[0][0]+"',"+str(count_list[0][1])+","+str(post_no)+"),"
        sql += "('"+count_list[1][0]+"',"+str(count_list[1][1])+","+str(post_no)+"),"
        sql += "('"+count_list[2][0]+"',"+str(count_list[2][1])+","+str(post_no)+"),"
        sql += "('"+count_list[3][0]+"',"+str(count_list[3][1])+","+str(post_no)+"),"
        sql += "('"+count_list[4][0]+"',"+str(count_list[4][1])+","+str(post_no)+")"
        db.RunSQL(sql)
        print(sql)
    except Exception as e:
        print("오류 내용 3 : " , e)
        break;
db.CloseQuery()
db.DBClose()
    
        
    
    
    
    
