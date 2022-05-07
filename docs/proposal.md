# Project Proposal

## 1. Motivation & Objective

In the medical process, health care workers need to strictly comply with the relevant norms. However, during long working hours, people can be negligent and careless due to fatigue, which often leads to medical accidents. Even worse, the wide spread of the COVID virus has made medical resources even more limited. Therefore, it becomes more important to make healthcare workers avoid mistakes during their heavy workload. To address this problem, we want to implement a behavior recognition system through the combination of AI and edge devices, and thus to help health care workers determine whether their behavior is in violation or not.

## 2. State of the Art & Its Limitations

We try to use sensors to collect sequences of acceleration information to represent medical care workers' activities. There is a very mature model, which is convolutional LSTM, used to recognize sequence data. However, due to the memory size limitation and the performance limitation of the processor, there is an upper limit on the length of the data sequence that can be recognized by convolutional LSTM. If we want to track a long-term event pattern, it will be nearly impossible to monitor such a long series of activities.

## 3. Novelty & Rationale

In our project, we decided to inject human knowledge into convolutional LSTM models, so that we do not need to process a series of activities all at once. To that end, we can use convolutional LSTM just to process a window size of signal series to distinguish a single activity, and then apply human knowledge to it by decision tree or othersymbolic methods. As a result, that will make the convolutional LSTM model small and simple enough to deploy on edge devices.

## 4. Potential Impact

The most immediate impact is this method will reduce the hardware requirements required by the convolutional LSTM model to process much longer data sequences. And in terms of applications, our project can be easily deployed on edge devices without additional devices purchase. As a result, with this low-cost system, we ensure the safe and legal behaviours of the health care provider's. Going a step further, by analyzing all health care workers behaviors and organizing them systematically, we may improve medical care capability by enhancing efficiency without additional recruitment.

## 5. Challenges

+ Raw data is noisy and incomplete. It was also not labeled.
+ Complex events dataset should be constructed reasonably.
+ Achieve high accuracy on simple event detection.
+ Inject human knowledge to enable complex event detection.
+ Determine suitable window size.


## 6. Requirements for Success

+ Sufficient well-processed data for training and testing.
+ Robust model for simple event detection.
+ Robust reasoning module for complex event detection.

## 7. Metrics of Success

+ 90%+ accuracy for complex event detection.
+ Long range of window size to prove that the model is robust to long-term reasoning.


## 8. Execution Plan

There are mainly three keys tasks for the project.

- Data Pre-processing (Yuxuan Fan, Weitao Sun, Liying Han)
   
   We use the real-time dataset collected in hospital, which suffers from noise and imcompleteness. In this part we will filter out noisy data with NaN values or unreasonable features to construct customized complex events. In this part the API of our dataset should be provided to the next task. 

- Complex Event Detection (Liying Han, Yuxuan Fan, Weitao Sun)
  
  In this part, we need to design a neuro-symbolic method to detect nursing complex events. The first step is to train an convolutional LSTM classifier to detect simple activities given a fixed window size of the signal series of complex events. The next step is to combine symbolic methods to detect complex event patterns. We will use human knowledge as some pre-defined rules to help the detection process.

- Deploy Model on Edge Devices (Weitao Sun, Yuxuan Fan, Liying Han)
  
  We will deploy the model on Arduino Nano 33 BLE. However, since edge devices usually have restrictions on memory and computation ability, we need to further optimize our model to achieve good performance while meeting those constraints. We also need to deal with real-time sensing problems.


## 9. Related Work

### 9.a. Papers

Papers on nursing dataset:
- Integrating Activity Recognition and Nursing Care Records: The System, Deployment, and a Verification Study
  
Papers on complex event detection: 
- A Hybrid Neuro-Symbolic Approach for Complex Event Processing
- Neuroplex: Learning to Detect Complex Events in Sensor Networks through Knowledge Injection


### 9.b. Datasets

- Third Nurse Care Activity Recognition Challenge.

### 9.c. Software

- Python
- Numpy
- PyTorch
- Google Colab

## 10. References

1.  Inoue, S., Lago, P., Hossain, T., Mairittha, T., & Mairittha, N. (2019). Integrating activity recognition and nursing care records: The system, deployment, and a verification study. Proceedings of the ACM on Interactive, Mobile, Wearable and Ubiquitous Technologies, 3(3), 1-24.
2.  Vilamala, M. R., Taylor, H., Xing, T., Garcia, L., Srivastava, M., Kaplan, L., ... & Cerutti, F. (2020). A hybrid neuro-symbolic approach for complex event processing. arXiv preprint arXiv:2009.03420.
3.  Xing, T., Garcia, L., Vilamala, M. R., Cerutti, F., Kaplan, L., Preece, A., & Srivastava, M. (2020, November). Neuroplex: learning to detect complex events in sensor networks through knowledge injection. In Proceedings of the 18th Conference on Embedded Networked Sensor Systems (pp. 489-502).
4.  Third Nurse Care Activity Recognition Challenge. https://abc-research.github.io/nurse2021/data/
5.  Python. https://www.python.org
6.  Numpy. https://numpy.org/
7.  PyTorch. https://pytorch.org/
8.  Google Colab. https://colab.research.google.com/
