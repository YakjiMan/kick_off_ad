import pymysql

class DBManager :
    def __init__(self):
        self.con = None
        
    def DBOpen(self,host,dbname,id,pw) :
        try :
            self.con = pymysql.connect(
                host=host,
                port=3306, 
                user=id, 
                passwd=pw,
                db=dbname, charset ="euckr")
            if self.con != None :
                self.cursor = self.con.cursor()
                return True
            return False
        except :
            return False
    
    def DBClose(self) :
        self.con.close()
        
    
    def RunSQL(self,sql) :
        try :
            self.cursor.execute(sql)
            self.con.commit()
            return True
        except :
            return False
    
    def OpenQuery(self,sql):
        try :
            self.cursor.execute(sql)
            self.data = self.cursor.fetchall()
            self.num_fields = len(self.cursor.description)
            return True
        except :
            return False       
        
    def CloseQuery(self) :
        self.cursor.close()
        
    def GetTotal(self):
        return len(self.data)
    
    def GetValue(self,index,column):
        count = -1
        for name in self.cursor.description:
            count = count + 1
            #print(name[0])
            if name[0] == column :            
                return self.data[index][count]
        return ""
"""
db = DBManager()
if db.DBOpen("127.0.0.1", "board", "root", "ezen") == False :
    print("Error")
else:    
    print("ok")
    
    for i in range(1,51):
        title = "%02d 번째 제목입니다." % i
        sql  = "insert into imsi (title) "
        sql += "values ('" + title + "')"
        #sql = "delete from imsi "
        db.RunSQL(sql)
    
    db.OpenQuery("select * from imsi")
    print(db.GetTotal())
    for row in range(0,5) :
        print(db.GetValue(row,"title"))
    db.CloseQuery()
    
"""
"""
db = dbm()
db.DBOpen("192.168.0.21", "kickoff", "root", "ezen")
sql = "select post_no,post_note from post "
db.OpenQuery(sql)

total = db.GetTotal()

for i in range(0,total) :
    post_no = db.GetValue(i,"post_no")
    print(post_no)
    post_note = db.GetValue(i,"post_note")
    print(post_note)
    print("=" * 30)
    
db.CloseQuery()

db.DBClose()
"""



    