import csv
import pandas as pd
import os
import ast



# csvlist확인
location = 'C:/Users/kosmo/Downloads/테마별csv/'
csv_list=[]

for file_name in os.listdir(location):
    csv_list.append(location+file_name)
    
csv_list[9]




file = open(csv_list[9], 'r', encoding='UTF8')
read_csv = csv.reader(file)
file.close

new_file = []
next(read_csv)

def get_file(read_csv):
    for row in read_csv:
        tag_list = ast.literal_eval(row[4])
        tag_dict = {string : 1 for string in tag_list}
        new_file.append(row[:4]+[tag_dict])

    return new_file

files = get_file(read_csv)
len(files)

new_file = []
for song in files:
    r_idx = reduplicated_idx(song, new_file)
    if r_idx != -1:
        tag_append(new_file, song, r_idx)
    else:
        new_file.append(song)
len(new_file)


def reduplicated_idx(song, new_file):
    for idx, exist_song in enumerate(new_file):
        if song[1:4] == exist_song[1:4]:
            return idx
    return -1


def tag_append(new_file, song, r_idx):
    exist_tags = new_file[r_idx][4]
    append_tags = song[4]
    for tag in append_tags:
        if tag in exist_tags:
            exist_tags[tag] = exist_tags[tag] + 1
        else:
            exist_tags[tag] = 1



#잘 나오는지 한번 보세요
dataframe = pd.DataFrame(new_file)
dataframe




