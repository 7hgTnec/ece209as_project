import torch.nn as nn
from torch.autograd import Variable
import numpy as np

class Activity_Net(nn.Module):
    def __init__(self, n_class=4, drop_out=0.5):
      super().__init__()
      self.n_class = n_class
      self.conv = nn.Sequential(
          nn.Conv1d(in_channels=3, out_channels=8, kernel_size=3, padding='same'),
          nn.LeakyReLU(),
          nn.MaxPool1d(kernel_size=3, stride=3),
          nn.BatchNorm1d(num_features=8),
          nn.Dropout(drop_out),

          # nn.Conv1d(in_channels=8, out_channels=16, kernel_size=3, padding='same'),
          # nn.LeakyReLU(),
          # nn.MaxPool1d(kernel_size=3, stride=3),
          # nn.BatchNorm1d(num_features=16),
          # nn.Dropout(drop_out)
      )

      self.lstm = nn.LSTM(input_size=20, hidden_size=8, bidirectional=True, batch_first=True)
      self.fc = nn.Sequential(
          nn.LeakyReLU(),
          nn.Dropout(drop_out),
          nn.Flatten(),
          nn.Linear(in_features=128, out_features=self.n_class),
          nn.Softmax(dim=1)
      )
        

    def forward(self, x):
      x = self.conv(x)
      # print(x.shape)
      x, _ = self.lstm(x)
      # print(x.shape)
      x = self.fc(x)
      # print(x.shape)
      return x

def neural_predicate(network, i):
    dataset = str(i.functor)
    i = int(i.args[0])
    if dataset == 'train':
        d, l = CE_train_data[i]
    elif dataset == 'test':
        d, l = CE_test_data[i]
    d = Variable(d.unsqueeze(0))
    
    output = network.net(d)
    return output.squeeze(0)

CE_train_data = np.load('CE_data/all_data.npy')
CE_test_data = np.load('CE_data/all_data.npy')