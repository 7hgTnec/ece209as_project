nn(activity_net,[X],Y,[0,1,2,3,4,5,6,7,8,9]) :: activity(X,Y).

initial_1(a0).
final_1(a2).

arc_1(a0,A,a1) :- activity(A,Y), Y is 0.

arc_1(a0,A,a0) :- activity(A,Y), Y is 1.
arc_1(a0,A,a0) :- activity(A,Y), Y is 2.
arc_1(a0,A,a0) :- activity(A,Y), Y is 3.

arc_1(a1,A,a2) :- activity(A,Y), Y is 1.

arc_1(a1,A,a1) :- activity(A,Y), Y is 0.
arc_1(a1,A,a1) :- activity(A,Y), Y is 2.
arc_1(a1,A,a1) :- activity(A,Y), Y is 3.

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
    traverse(Label,String,NewString),
    arc_1(FromNode,Label,ToNode), 
    recognize_1(ToNode,NewString).

traverse(First,[First|Rest],Rest).


initial_2(b0).
final_2(b2).

arc_2(b0,A,b1) :- activity(A,Y), Y is 2.

arc_2(b0,A,b0) :- activity(A,Y), Y is 0.
arc_2(b0,A,b0) :- activity(A,Y), Y is 1.
arc_2(b0,A,b0) :- activity(A,Y), Y is 3.


arc_2(b1,A,b2) :- activity(A,Y), Y is 3.

arc_2(b1,A,b1) :- activity(A,Y), Y is 0.
arc_2(b1,A,b1) :- activity(A,Y), Y is 1.
arc_2(b1,A,b1) :- activity(A,Y), Y is 2.


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
    traverse(Label,String,NewString),
    arc_2(FromNode,Label,ToNode), 
    recognize_2(ToNode,NewString).



initial_3(c0).
final_3(c2).


arc_3(c0,A,c1) :- activity(A,Y), Y is 3.

arc_3(c0,A,c0) :- activity(A,Y), Y is 0.
arc_3(c0,A,c0) :- activity(A,Y), Y is 1.
arc_3(c0,A,c0) :- activity(A,Y), Y is 2.


arc_3(c1,A,c2) :- activity(A,Y), Y is 0.

arc_3(c1,A,c1) :- activity(A,Y), Y is 1.
arc_3(c1,A,c1) :- activity(A,Y), Y is 2.
arc_3(c1,A,c1) :- activity(A,Y), Y is 3.

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
    traverse(Label,String,NewString),
    arc_3(FromNode,Label,ToNode),
    recognize_3(ToNode,NewString).

initial_4(d0).
final_4(d2).


arc_4(d0,A,d1) :- activity(A,Y), Y is 1.

arc_4(d0,A,d0) :- activity(A,Y), Y is 0.
arc_4(d0,A,d0) :- activity(A,Y), Y is 2.
arc_4(d0,A,d0) :- activity(A,Y), Y is 3.


arc_4(d1,A,d2) :- activity(A,Y), Y is 2.

arc_4(d1,A,d1) :- activity(A,Y), Y is 0.
arc_4(d1,A,d1) :- activity(A,Y), Y is 1.
arc_4(d1,A,d1) :- activity(A,Y), Y is 3.

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
    traverse(Label,String,NewString),
    arc_4(FromNode,Label,ToNode),
    recognize_4(ToNode,NewString).

isEvent(S) :- event_1(S).
isEvent(S) :- event_2(S).
isEvent(S) :- event_3(S).
isEvent(S) :- event_4(S).

event(S, ID) :- event_1(S), ID is 1.
event(S, ID) :- event_2(S), ID is 2.
event(S, ID) :- event_3(S), ID is 3.
event(S, ID) :- event_4(S), ID is 4.

event(S, ID) :- \+ isEvent(S), ID is 0.