#!/usr/bin/env python
# coding: utf-8

import selenium 
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from bs4 import BeautifulSoup
import pandas as pd
import time
import re
import math
from urllib.parse import urlparse
from urllib import parse


path ="C:/Chrome/chromedriver_win32/chromedriver"
serv = Service(path)
myBrowser = webdriver.Chrome(service = serv)


def input_keyword(myBrowser,keyword):
    myBrowser.get('https://www.melon.com/dj/djfinder/djfinder_inform.htm?djSearchType=T&djSearchKeyword={}#params%5BdjSearchType%5D=T&params%5BdjSearchKeyword%5D=%23{}&params%5BorderBy%5D=POP&params%5BpagingFlag%5D=Y&params%5BtagSearchType%5D=S&po=pageObj&startIndex='.format(keyword,keyword))
    time.sleep(2)
    url = myBrowser.current_url
    return theme_list(myBrowser, url, keyword)


def theme_list(myBrowser, url, input_text):    
    theme_sum = get_theme_sum(myBrowser) + 1  
    song_list = []
    for i in range(1,theme_sum):
        num = 1
        myBrowser.get(url + '{}'.format(num))
        song_list = song_list + theme_detail(myBrowser)        
        num = num + 20
    
    return make_csv(song_list, input_text)


def get_theme_sum(myBrowser):
    soup = BeautifulSoup(myBrowser.page_source, 'html.parser')
    theme_sum = soup.find('div', class_='search_result')
    theme_sum = theme_sum.find('span', class_='num').get_text()
    theme_sum = int(theme_sum)
    theme_sum = math.ceil(theme_sum / 20)
    return theme_sum


def theme_detail(myBrowser):
    song_list=[]
    for r in range(1,21):
        try:
            sample = myBrowser.find_element(By.CSS_SELECTOR, '#djPlylstList > div > ul > li:nth-child({}) > div.thumb > a'.format(r))
        except:
            break

        try:
            myBrowser.execute_script("arguments[0].click();", sample)
            sample.send_keys(Keys.ENTER)
        except:
            pass
        
        song_list = song_list + get_song_list(myBrowser)
        myBrowser.back()
    return song_list


def get_song_list(myBrowser):
    time.sleep(2)      
    soup = BeautifulSoup(myBrowser.page_source, 'html.parser')
    song_titles = []
    for t in soup.find_all('div', class_='ellipsis rank01'):
        song_titles.append(t.get_text(strip=True))

    song_artists = []
    table = soup.find('table')
    for artists in table.find_all('span', class_='checkEllipsis'):
        song_artists.append(artists.get_text(strip=True))

    song_albums = []
    for album in soup.find_all('div', class_='ellipsis rank03'):
        song_albums.append(album.get_text(strip=True))

    song_themes = []    
    tags = soup.find('div', class_='tag_list type03')
    for tag in tags.find_all('a', class_='tag_item'):
        song_themes.append(tag.get_text(strip=True))
    
    songs_info = []
    for x in range(len(song_titles)):
        songs_info.append((song_titles[x], song_albums[x], song_artists[x], song_themes))
    
    print(songs_info)
    return songs_info



def make_csv(songs_list, input_text):
    col = ['곡','앨범','아티스트', '테마']
    
    df = pd.DataFrame(songs_list,columns=col)
    df.to_csv('{}.csv'.format(input_text))
    return  df  

input_keyword(myBrowser,'노트북')

