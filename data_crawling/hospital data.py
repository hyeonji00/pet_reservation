from selenium import webdriver
import requests
from bs4 import BeautifulSoup
import time

# 현재 위치 좌표값(x, y) 가져오기
location = "서울특별시 광진구" # 현재 위치
url = f"https://dapi.kakao.com/v2/local/search/address.json?query={location}"
kakao_key = "0a073cf7a6b2b43749bb4f2b8b4b6a90" # REST API key
result = requests.get(url, headers={"Authorization":f"KakaoAK {kakao_key}"})
json_obj = result.json()

x = json_obj['documents'][0]['x']
y = json_obj['documents'][0]['y']
print(x , y)

# 카카오맵 연동
driver = webdriver.Chrome('C:\\Users\82106\TAVE_PET\ChromeDriver\chromedriver.exe')

# 동물 병원 입력
item ="동물 병원" # 검색어
driver.get('https://map.kakao.com/')
searchbox = driver.find_element_by_xpath("//input[@id='search.keyword.query']") # 검색창에 입력하기
searchbox.send_keys(item)

# 검색
searchbutton = driver.find_element_by_xpath("//button[@id='search.keyword.submit']") # 검색버튼 누르기
driver.execute_script("arguments[0].click();", searchbutton)
time.sleep(2)

# data 가져오기
url = 'https://map.kakao.com/'
response = requests.get(url)


if response.status_code == 200:
    html = response.text
    soup = BeautifulSoup(html, 'html.parser')

    link_name_list = driver.find_elements_by_class_name('link_name')
    address_list = driver.find_elements_by_class_name('addr')
    phone_list = driver.find_elements_by_class_name('phone')

    for idx, name in enumerate(link_name_list):
        print("병원", idx +1,": ",name.text)
        if idx==6:
            print("\n")
            break

    for idx, addr in enumerate(address_list):
        print("주소", idx +1,": ",addr.text)
        if idx==6:
            print("\n")
            break
        
    for idx, phone in enumerate(phone_list):
        print("연락처", idx +1,": ",phone.text)
        if idx==6:
            print("\n")
            break

else : 
    print(response.status_code)
