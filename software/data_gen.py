import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import time
import random
import json
import torch
from torch.nn.utils.rnn import pack_sequence
from torch.utils.data import DataLoader,Dataset
from sklearn import preprocessing
import sklearn.utils as utils

def gen_data_dict(f, norm_en):
    load_dict = json.load(f)
    # Parameters
    SEGMENT_SIZE = 60
    MIN_SEG_SIZE = 40
    SLIDING_SIZE = 60
    target_label = [i for i in range(1, 29)]

    x_train = []
    y_train = []
    data_dict = {i: [] for i in range(1, 29)}
    time_period = set()
    activity_len = {}
    for item in load_dict:
        x, y, start, finish = item['acc'], item['label'], item['start'], item['finish']
        # counter = dict(Counter(y_train))
        if y in target_label and (start, finish) not in time_period and len(x) >= MIN_SEG_SIZE:
            # Check duplicates
            time_period.add((start, finish))
            if (MIN_SEG_SIZE <= len(x) and len(x) <= SEGMENT_SIZE):
                dup_len = SEGMENT_SIZE - len(x)
                x_i = x
                for i in range(dup_len):
                    x_i.append(x[-1])
                if (norm_en):
                    x_i = preprocessing.normalize(x_i)
                data_dict[y].append(x_i)
                # extend to segment size
            else:
                num = int((len(x) - SEGMENT_SIZE) / SLIDING_SIZE) + 1
                for i in range(num):
                    x_i = x[i * SLIDING_SIZE:i * SLIDING_SIZE + SEGMENT_SIZE]
                    if (norm_en):
                        x_i = preprocessing.normalize(x_i)
                    data_dict[y].append(x_i)

    # print(len(x_train))
    for i in range(1, 29):
        print(str(i) + ' : ' + str(len(data_dict[i])))
    return data_dict

def choose_activity(data_dict):
    target_label = []
    others_label = []
    for i in range(1, 29):
        if (len(data_dict[i]) > 1200):
            target_label.append(i)
        if (len(data_dict[i]) > 200 and len(data_dict[i]) < 1200):
            others_label.append(i)
    print(target_label)
    print(others_label)
    chosen_label = target_label + others_label

    all_data = []
    start_idx = []
    end_idx = []
    start = 0
    for i in chosen_label:
        for data in data_dict[i]:
            all_data.append(data)
        end = len(all_data) - 1
        start_idx.append(start)
        end_idx.append(end)
        #print(str(i) + "\t[" + str(start) + ":" + str(end) + "]")
        start = end + 1
    all_data = np.array(all_data)
    #print(all_data.shape)
    np.save('all_data.npy', all_data)
    return start_idx, end_idx

def gen_event(start_idx, end_idx, num):
    length = 5
    event_id_lst = []
    label_lst = []
    data_id_lst = []
    act1 = [0, 2, 3, 1]
    act2 = [1, 3, 0, 2]
    # generate event 1-4 index
    for j in range(4):
        for i in range(num):
            event_idx = []
            label = [0 for i in range(5)]       #label = [0,0,0,0,0]
            for i in range(5):
                idx = random.randint(4, 8)
                event_idx.append(idx)           #event_idx = [x,x,x,x,x]
            idx1 = random.randint(0, 3)
            idx2 = random.randint(idx1 + 1, 4)
            event_idx[idx1] = act1[j]
            event_idx[idx2] = act2[j]           #event_idx = [x,o,x,x,o]
            label[idx2] = j + 1
            event_id_lst.append(event_idx)
            label_lst.append(label)

    # generate event 0 index
    for i in range(num):
        event_idx = []
        label = [0 for i in range(5)]
        for i in range(5):
            idx = random.randint(4, 8)
            event_idx.append(idx)
        idx = random.randint(0, 4)
        event_idx[idx] = random.randint(0, 3)
        event_id_lst.append(event_idx)
        label_lst.append(label)

    # generate data id
    for event in event_id_lst:
        id = []
        for act in event:
            data_id = random.randint(start_idx[act], end_idx[act])
            id.append(data_id)
        data_id_lst.append(id)
    #print(len(data_id_lst))
    #print(len(label_lst))
    return data_id_lst, label_lst

def gen_txt(data_id_lst, label_lst, f):
    data_id_lst, label_lst = utils.shuffle(data_id_lst, label_lst)
    for idx in range(len(data_id_lst)):
        id_str = ""
        id = data_id_lst[idx]
        label = label_lst[idx]
        for i in range(5):
            id_str += "train({}),".format(id[i])
            #print("CE([{}],{})".format(id_str[:-1], label[i]))
            f.write("CE([{}],{}).\n".format(id_str[:-1], label[i]))

def gather_examples():
    f_train = open("./train_data.txt", 'w+')
    f_test= open("./test_data.txt", 'w+')
    f_r = open('./data.json', 'r')
    data_dict = gen_data_dict(f_r, norm_en=True)
    start_idx, end_idx = choose_activity(data_dict)
    train_data_id_lst, train_label_lst = gen_event(start_idx, end_idx, 2000) #2000 per label, 10000 in total
    gen_txt(train_data_id_lst, train_label_lst, f_train)
    test_data_id_lst, test_label_lst = gen_event(start_idx, end_idx, 400)
    gen_txt(test_data_id_lst, test_label_lst, f_test)
    f_train.close()
    f_test.close()
    #print(len(data_id_lst))
    #(len(label_lst))


#print(start_idx)
#print(end_idx)
#gather_examples()
f_r = open('./data.json', 'r')
data_dict = gen_data_dict(f_r, norm_en=True)
start_idx, end_idx = choose_activity(data_dict)