nn(activity_net,[X],Y,[0,1,2,3]) :: activity(X,Y).

# Event 1: 0/xx?/1
initial_1(a0).
final_1(a2).

# tranform of state 0
arc_1(a0,A,a1) :- activity(A,Y), Y is 0.

arc_1(a0,A,a0) :- activity(A,Y), Y is 1.
arc_1(a0,A,a0) :- activity(A,Y), Y is 2.
arc_1(a0,A,a0) :- activity(A,Y), Y is 3.

#transform of state 1
arc_1(a1,A,a2) :- activity(A,Y), Y is 1.

arc_1(a1,A,a1) :- activity(A,Y), Y is 0.
arc_1(a1,A,a1) :- activity(A,Y), Y is 2.
arc_1(a1,A,a1) :- activity(A,Y), Y is 3.

# transform of state 2
arc_1(a2,A,a0) :- activity(A,Y), Y is 0.
arc_1(a2,A,a0) :- activity(A,Y), Y is 1.
arc_1(a2,A,a0) :- activity(A,Y), Y is 2.
arc_1(a2,A,a0) :- activity(A,Y), Y is 3.


event_1(Seq) :- 
    initial_1(Node), 
    recognize_1(Node,Seq).

recognize_1(Node,[]) :- 
    final_1(Node).
recognize_1(FromNode,String) :- 
    arc_1(FromNode,Label,ToNode), 
    traverse(Label,String,NewString), 
    recognize_1(ToNode,NewString).

traverse(First,[First|Rest],Rest).


# Event 2: 2/xx?/3
initial_2(b0).
final_2(b2).

#tranform of state 0
arc_2(b0,A,b1) :- activity(A,Y), Y is 2.

arc_2(b0,A,b0) :- activity(A,Y), Y is 0.
arc_2(b0,A,b0) :- activity(A,Y), Y is 1.
arc_2(b0,A,b0) :- activity(A,Y), Y is 3.

#tranform of state 1
arc_2(b1,A,b2) :- activity(A,Y), Y is 3.

arc_2(b1,A,b1) :- activity(A,Y), Y is 0.
arc_2(b1,A,b1) :- activity(A,Y), Y is 1.
arc_2(b1,A,b1) :- activity(A,Y), Y is 2.

#tranform of state 2
arc_2(b2,A,b0) :- activity(A,Y), Y is 0.
arc_2(b2,A,b0) :- activity(A,Y), Y is 1.
arc_2(b2,A,b0) :- activity(A,Y), Y is 2.
arc_2(b2,A,b0) :- activity(A,Y), Y is 3.



event_2(Seq) :- 
    initial_2(Node), 
    recognize_2(Node,Seq).

recognize_2(Node,[]) :- 
    final_2(Node).
recognize_2(FromNode,String) :- 
    arc_2(FromNode,Label,ToNode), 
    traverse(Label,String,NewString), 
    recognize_2(ToNode,NewString).


# Event 3: 3/xx?/0
initial_3(c0).
final_3(c2).

#tranform of state 0
arc_3(c0,A,c1) :- activity(A,Y), Y is 3.

arc_3(c0,A,c0) :- activity(A,Y), Y is 0.
arc_3(c0,A,c0) :- activity(A,Y), Y is 1.
arc_3(c0,A,c0) :- activity(A,Y), Y is 2.


#tranform of state 1
arc_3(c1,A,c2) :- activity(A,Y), Y is 0.

arc_3(c1,A,c1) :- activity(A,Y), Y is 1.
arc_3(c1,A,c1) :- activity(A,Y), Y is 2.
arc_3(c1,A,c1) :- activity(A,Y), Y is 3.

#tranform of state 2
arc_3(c2,A,c0) :- activity(A,Y), Y is 0.
arc_3(c2,A,c0) :- activity(A,Y), Y is 1.
arc_3(c2,A,c0) :- activity(A,Y), Y is 2.
arc_3(c2,A,c0) :- activity(A,Y), Y is 3.



event_3(Seq) :- 
    initial_3(Node), 
    recognize_3(Node,Seq).

recognize_3(Node,[]) :- 
    final_3(Node).
recognize_3(FromNode,String) :- 
    arc_3(FromNode,Label,ToNode), 
    traverse(Label,String,NewString), 
    recognize_3(ToNode,NewString).

# Event 4: 1/xx?/2
initial_4(d0).
final_4(d2).

#tranform of state 0
arc_4(d0,A,d1) :- activity(A,Y), Y is 1.

arc_4(d0,A,d0) :- activity(A,Y), Y is 0.
arc_4(d0,A,d0) :- activity(A,Y), Y is 2.
arc_4(d0,A,d0) :- activity(A,Y), Y is 3.

#tranform of state 1
arc_4(d1,A,d2) :- activity(A,Y), Y is 2.

arc_4(d1,A,d1) :- activity(A,Y), Y is 0.
arc_4(d1,A,d1) :- activity(A,Y), Y is 1.
arc_4(d1,A,d1) :- activity(A,Y), Y is 3.

#tranform of state 2
arc_4(d2,A,d0) :- activity(A,Y), Y is 0.
arc_4(d2,A,d0) :- activity(A,Y), Y is 1.
arc_4(d2,A,d0) :- activity(A,Y), Y is 2.
arc_4(d2,A,d0) :- activity(A,Y), Y is 3.



event_4(Seq) :- 
    initial_4(Node), 
    recognize_4(Node,Seq).

recognize_4(Node,[]) :- 
    final_4(Node).
recognize_4(FromNode,String) :- 
    arc_4(FromNode,Label,ToNode), 
    traverse(Label,String,NewString), 
    recognize_4(ToNode,NewString).
