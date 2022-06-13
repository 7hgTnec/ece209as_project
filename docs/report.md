# Table of Contents
* Abstract
* [Introduction](#1-introduction)
* [Related Work](#2-related-work)
* [Technical Approach](#3-technical-approach)
* [Evaluation and Results](#4-evaluation-and-results)
* [Discussion and Conclusions](#5-discussion-and-conclusions)
* [References](#6-references)

# Abstract

Provide a brief overview of the project objhectives, approach, and results.

# 1. Introduction

In the medical process, health care workers need to strictly comply with the relevant norms. However, during long working hours, people can be negligent and careless due to fatigue, which often leads to medical accidents. Even worse, the wide spread of the COVID virus has made medical resources even more limited. Therefore, it becomes more important to make healthcare workers avoid mistakes during their heavy workload. To address this problem, we want to implement a behavior recognition system through the combination of AI and edge devices, and thus to help health care workers determine whether their behavior is in violation or not.

The existing complex event processing approaches that can use subsymbolic data can be divided into three types. The first is using pre-trained neural networks to extract the symbolic information. In this way, High-bandwidth data is transformed into symbolic information, easy to define rules on it. However, creating training dataset takes much effort. Sometimes we only have training labels for when the complex events are happening, and not for the simple events. The second is to view the whole complex event processing problem as a classification problem, which is a purely statistical approach. This approach removes the manual definitions of complex events, and instead managing to train the neural network to identify those definitions when it learns to classify the subsymbolic data. We can just use a LSTM or a C3D to implement this approach. However, training such neural network need very large amounts of data. The third is neuro-symbolic approach. This is done by dividing the problem into two levels: low-level perception and high-level reasoning. The high-level reasoning is responsible for detecting the complex events based on manually defined rules, while the low-level perception is responsible for parsing the subsymbolic data into a set of classes that can be used when defining the rules. However, High level reasoning requires a significant amount of work, and it is not flexible.

To account the issues mentioned above, we used DeepProbLog, which is a probabilistic logic programming language that incorporates deep learning by means of neural predicates, to inject logic rules to achieve complex event detection. Our approach can also be applied to signal sequence of flexible length by using Finite State Machine to detect patterns. In this way, our approach can detect simultaneous complex events using real-time signals with infinite length.

There were mainly two challenges we were facing. The first challenge is constructing training set. The raw data was noisy and incomplete, and it was also not labeled. In addition, we need to construct training dataset reasonably. The second challenge is successfully using DeepProbLog to build a Finite State Machine.

Our project is built using python and based on several package, such as numpy, pytorch. We also use DeepProbLog, which is also using python. We set the accuracy as the metrices of success.

# 2. Related Work
- STLnet  
  A model to predict future sequences with constraints/rules satisfied. Use a symbolic teacher network to guide the student neural network learning.
  - Pros: the teacher network can ensure 100% satisfaction rate of rules
  - Cons: solves only regression problems, computationally heavy

- Neuroplex  
  An end-to-end model to detect complex events. Use knowledge distillation to convert the pattern detection logic module to a neural network.
  - Pros: end-to-end classification of various complex events
  - Cons: counting not considered

# 3. Technical Approach
- Data Preprocessing & Dataset Construction
  
  Our dataset is from The Third Nurse Care Activity Recognition Challenge. It made up of accelerometer data collected by nurses and caregivers with smartphone. There are in total 27 activities such as excretion, oral care and organization of medications. However, data and label were from two separate files so we have to first match the data with labels. To do so, we convert datetime to timestamps and filter out meaningless data. To speed up the matching process, we implemented binary search using python. After that, we assume the sample frequency is around 1Hz so we set the segment size as 60. We also did normalization to compare the performance. The amount of data from different labels is shown below. We chose activity 2,4,12,14 as target activities and activity 9,10,13,16,19 as other activities. 
  
  Then we defined complex events as a set of single activity. We defined five patterns of complex events as shown below. For example, event 1 is activity 2 follower by activity 4, and other activities randomly happened before, between or after them. Once the pattern is detected, the label will show which pattern this event is.

  o	Event0: xxxxx (x is from[9,10,13,16,19])

  o	Event1: 2/xx?/4

  o	Event2: 12/xx?/14

  o	Event3: 14/xx?/2

  o	Event4: 4/xx?/12

  The last step was generated training dataset for DeepProbLog. We gathered all the data in an numpy array and used index to access it. As shown below, the number inside the parenthesis is the index of the data, and the number in the end of  the line is the label. 
  


- Complex Event Detection
  
  blabla
  
  - DeepProbLog Pipeline
    
    scs
    
    ![DPL](https://raw.githubusercontent.com/7hgTnec/ece209as_project/main/docs/media/DPL-pipeline.png)

  - Finite State Machine  
    
    cscs

# 4. Evaluation and Results

# 5. Discussion and Conclusions

# 6. References
