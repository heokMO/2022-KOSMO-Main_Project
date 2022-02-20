import selenium 
from selenium import webdriver
from selenium.webdriver.edge.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from bs4 import BeautifulSoup
import time
import csv
import pandas as pd

path ="C:/kosmo100/python/util/chromedriver_win32/chromedriver"
serv = Service(path)
myBrowser = webdriver.Chrome(service = serv)
num = 1

songs_info = []
song_titles = []
song_albums = []
song_artists = []
songs_imgsrc = []
for i in range(1,2000):
    myBrowser.get('https://www.melon.com/genre/song_list.htm?gnrCode=GN0600#params%5BgnrCode%5D=GN0600&params%5BdtlGnrCode%5D=&params%5BorderBy%5D=NEW&params%5BsteadyYn%5D=N&po=pageObj&startIndex={}'.format(num))
    soup = BeautifulSoup(myBrowser.page_source, 'html.parser')
    table = soup.find('table')
    for t in soup.find_all('div', class_='ellipsis rank01'):
        song_titles.append(t.get_text(strip=True))
    
    for artists in table.find_all('span', class_='checkEllipsis'):
        song_artists.append(artists.get_text(strip=True))

    for album in soup.find_all('div', class_='ellipsis rank03'):
        song_albums.append(album.get_text(strip=True))

    for mg in soup.find_all('a', class_='image_typeAll'):
        songs_imgsrc.append(mg.find('img')['src'])
    num = num + 50
    time.sleep(1)
    
for i in range(len(song_titles)):
    songs_info.append((song_titles[i], song_albums[i], song_artists[i], songs_imgsrc[i],'락_메탈'))










