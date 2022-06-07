import torchvision
import random
import numpy as np

trainset = np.load('CE_data/all_data.npy')
testset = np.load('CE_data/all_data.npy')
# print(trainset[0])

datasets = {'train': trainset, 'test': testset}


# def next_example(dataset, i):
#     x, y = next(i), next(i)
#     (_, c1), (_, c2) = dataset[x], dataset[y]
#     return x, y, c1 + c2


# def gather_examples(dataset_name, filename):
#     dataset = datasets[dataset_name]
#     examples = list()
#     i = list(range(len(dataset)))
#     random.shuffle(i)
#     i = iter(i)
#     while True:
#         try:
#             examples.append(next_example(dataset, i))
#         except StopIteration:
#             break

#     with open(filename, 'w') as f:
#         for example in examples:
#             args = tuple('{}({})'.format(dataset_name, e) for e in example[:-1])
#             f.write('addition({},{},{}).\n'.format(*args, example[-1]))


# gather_examples('train', 'train_data.txt')
# gather_examples('test', 'test_data.txt')

def gen_event():
    length = 5
    event_id_lst = []
    label_lst = []
    data_id_lst = []
    act1 = [0, 2, 3, 1]
    act2 = [1, 3, 0, 2]
    # generate event index
    for j in range(4):
        for i in range(2000):
            event_idx = []
            label = [0 for i in range(5)]
            for i in range(5):
                idx = random.randint(4, 8)
                event_idx.append(idx)
            idx1 = random.randint(0, 3)
            idx2 = random.randint(idx1 + 1, 4)
            event_idx[idx1] = act1[j]
            event_idx[idx2] = act2[j]
            label[idx2] = j + 1
            event_id_lst.append(event_idx)
            label_lst.append(label)
    # generate label
    for i in range(2000):
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

    start = [0, 6376, 12572, 14275, 16461, 17506, 18395, 18855, 19143]
    end = [6375, 12571, 14274, 16460, 17505, 18394, 18854, 19142, 19409]
    for event in event_id_lst:
        id = []
        for act in event:
            data_id = random.randint(start[act], end[act])
            id.append(data_id)
        data_id_lst.append(id)

    return data_id_lst, label_lst

def gen_txt(dataset_name, data_id_lst, label_lst, f):
    for idx in range(len(data_id_lst)):
        id_str = ""
        id = data_id_lst[idx]
        label = label_lst[idx]
        for i in range(5):
            id_str += "{}({}),".format(dataset_name, id[i])
            #print("CE([{}],{})".format(id_str[:-1], label[i]))
            f.write("event([{}],{}).\n".format(id_str[:-1], label[i]))

def gather_examples(dataset_name, filename):
    f = open(filename, 'w')
    data_id_lst, label_lst = gen_event()
    gen_txt(dataset_name, data_id_lst, label_lst, f)
    f.close()
    #print(len(data_id_lst))
    #(len(label_lst))
gather_examples('train', 'CE_train_data.txt')
gather_examples('test', 'CE_test_data.txt')