1/4::activity(X,0); 1/4::activity(X,1);1/4::activity(X,2);1/4::activity(X,3) :-activity(X).

activity(e0).
activity(e1).
activity(e2).
activity(e3).

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

query(event_1([e1,e2])).
query(event_1([e0,e1,e2,e3])).



initial_1(a0).
final_1(a2).

arc_1(a0,0,a1).
arc_1(a0,1,a0).
arc_1(a0,2,a0).
arc_1(a0,3,a0).
arc_1(a1,1,a2).
arc_1(a1,0,a1).
arc_1(a1,2,a1).
arc_1(a1,3,a1).
arc_1(a2,0,a0).
arc_1(a2,1,a0).
arc_1(a2,2,a0).
arc_1(a2,3,a0).


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

query(event_1([0,1])).
query(event_1([2,0,3,1])).