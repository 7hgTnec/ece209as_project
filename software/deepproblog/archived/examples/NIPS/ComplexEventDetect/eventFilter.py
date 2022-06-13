import random

origin_train_data_file = '/home/nothing/Code/ece209as_project/software/deepproblog/archived/examples/NIPS/ComplexEventDetect/CE_train_data.txt'
origin_test_data_file = '/home/nothing/Code/ece209as_project/software/deepproblog/archived/examples/NIPS/ComplexEventDetect/CE_test_data.txt'

filtered_train_data_file = '/home/nothing/Code/ece209as_project/software/deepproblog/archived/examples/NIPS/ComplexEventDetect/CE_train_data_filtered.txt'
filtered_test_data_file = '/home/nothing/Code/ece209as_project/software/deepproblog/archived/examples/NIPS/ComplexEventDetect/CE_test_data_filtered.txt'

train_file = open(origin_train_data_file, "r")
test_file = open(origin_test_data_file, "r")
train_filetered = open(filtered_train_data_file, "w+")
test_filetered = open(filtered_test_data_file, "w+")

train_0 = 0
test_0 = 0

lines = train_file.readlines()
for l in lines:
    if l[-4] == '0':
        train_0 += 1
print((train_0/len(lines)))
p = ((1 - (train_0/len(lines)))/4)/(train_0/len(lines))
print(p)

for l in lines:  
    if not (l[-4] == '0' and random.random() and random.random() >= p):
        train_filetered.write(l)
        
train_file.close()
train_filetered.close()

lines = test_file.readlines()

for l in lines:
    if l[-4] == '0':
        test_0 += 1

p = ((1 - (test_0/len(lines)))/4)/(test_0/len(lines))
print(p)

for l in lines:
    if not (l[-4] == '0' and random.random() and random.random() >= p):
        test_filetered.write(l)
test_file.close()
test_filetered.close()
