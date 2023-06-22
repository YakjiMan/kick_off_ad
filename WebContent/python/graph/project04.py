from gensim.models.word2vec import Word2Vec
#시각화를 위한 t-sne -pca  
# from sklearn.manifold import TSNE
# from sklearn.decomposition import PCA
# selenium의 webdriver를 사용하기 위한 import
from selenium import webdriver
# selenium으로 무엇인가 입력하기 위한 import
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
import os, sys
import pyperclip
import pyautogui

def getKeyfromWeb(key):
    word = key
    filename = "test101"
    model_okt = Word2Vec.load('D:\\SHS\\second project\\kick_off_view\\WebContent\\python\\graph\\word2vec_'+filename+'.model')
    
    terminnal_command = "python -m gensim.scripts.word2vec2tensor --input "+filename+"_w2v --output "+filename+"_w2v"
    os.system(terminnal_command)
    
    driver = webdriver.Chrome("D:\\SHS\\second project\\kick_off_view\\WebContent\\python\\graph\\chromedriver_win32")
    driver.get("https://projector.tensorflow.org/")
    driver.maximize_window()
    time.sleep(5)
    driver.find_element(By.XPATH,'//*[@id="upload"]').click()
    time.sleep(1)
    driver.find_element(By.XPATH,'//*[@id="upload-tensors"]').click()
    time.sleep(1)
    link1 = "D:\\SHS\\second project\\kick_off_view\\WebContent\\python\\graph\\"+filename+"_w2v_tensor.tsv"
    link2 = "D:\\SHS\\second project\\kick_off_view\\WebContent\\python\\graph\\"+filename+"_w2v_metadata.tsv"
    pyperclip.copy(link1)
    pyautogui.sleep(1)
    pyautogui.hotkey("ctrl","v")
    pyautogui.sleep(1)
    pyautogui.press("enter")
    driver.find_element(By.XPATH,'//*[@id="upload-metadata"]').click()
    time.sleep(1)
    pyperclip.copy(link2)
    pyautogui.sleep(1)
    pyautogui.hotkey("ctrl","v")
    pyautogui.sleep(2)
    pyautogui.press("enter")
    pyautogui.sleep(4)
    pyautogui.click(150,150)
    pyautogui.sleep(1)
    driver.find_element(By.XPATH,'//*[@id="input-14"]').click()
    pyautogui.sleep(1)
    pyperclip.copy(word)
    pyautogui.hotkey("ctrl","v")
    pyautogui.sleep(999)
#   print("이적")
    
'''
b.CloseQuery()
db.DBClose()
'''


'''
#벡터값 호출
print('벡터 값 호출')
print('리버풀 벡터값:', model_okt.wv['프리미어리그'])

#단어간 유사도확인
print('단어간 유사도 확인')
print('유사도:','콘테','토트넘', model_okt.wv.similarity(w1='토트넘',w2='콘테'))

#유사도 top 10
print('단어간 유사도')
print(word ,":" , model_okt.wv.most_similar(word, topn= 300))
'''
    # word2vec 시각화
    #https://projector.tensorflow.org/
    
    #터미널에 입력 하여 파일 두종류생성
    
def main(key):
    getKeyfromWeb(key)

if __name__ == '__main__':
    if len(sys.argv) > 2 :
        main(sys.argv[2])
    else :
        print("키워드가 없습니다")
