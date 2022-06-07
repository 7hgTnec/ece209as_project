from train import train_model
from data_loader import load
from activity import Activity_Net, neural_predicate
from model import Model
from optimizer import Optimizer
from network import Network
import torch

queries = load('CE_train_data.txt')
test_queries = load('CE_test_data.txt')

with open('CE.pl') as f:
    problog_string = f.read()

network = Activity_Net()
net = Network(network, 'activity_net', neural_predicate)
net.optimizer = torch.optim.Adam(network.parameters(), lr=0.001)
model = Model(problog_string, [net], caching=False)
optimizer = Optimizer(model, 2)

# train_model(model, queries, 1, optimizer, test_iter=1000, test=lambda x: x.accuracy(test_queries, test=True), snapshot_iter=10000)
train_model(model, queries, 1, optimizer, test_iter=10000, test=lambda x: x.accuracy(test_queries, test=True), snapshot_iter=10000)