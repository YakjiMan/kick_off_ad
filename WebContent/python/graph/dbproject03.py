from db.DBManager import DBManager
from konlpy.tag import Okt
from gensim.models.word2vec import Word2Vec
import re
from collections import Counter


db = DBManager()
db.DBOpen("192.168.0.21", "kickoff", "root", "ezen")
sql = "select * from analyze_data2"
db.OpenQuery(sql)
data = db.GetValueAll()

cNO = 0;

for item in data :
    #print("cNO : " , cNO)
    cNO += 1
    analdata_no = item[0]
    morph_relation_key = item[1]
    anal_no = item[2]
    sim = item[3]
    #print(item[0],item[1],item[2],item[3])
