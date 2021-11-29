%***********RELATIONSHIP************
father(terach,abraham).
father(terach,nachor).
father(terach,haran).
father(abraham,isaac).
father(haran,lot).
father(haran,milcah).
father(haran,yiscah).

male(terach).
male(abraham).
male(nachor).
male(haran).
male(isaac).
male(lot).

mother(sarah,isaac).

female(sarah).
female(milcah).
female(yiscah).

grandfather(X,Y) :- father(X,Z),father(Z,Y).

%BASE CLAUSE
ancestor(X,Y):-father(X,Y).

%RECURSIVE CLAUSE
ancestor(X,Y):-father(X,Z),ancestor(Z,Y).

%***********ARITHMETIC************

topla(0,Y,Y).
topla(X,Y,R) :-(X > 0),(X1 is X-1),(Y1 is Y+1), topla(X1,Y1,R).

cikar(X,0,X).
cikar(X,Y,R) :-(Y>0),(X1 is X-1), (Y1 is Y-1), cikar(X1,Y1,R).

carp(_,0,0).
carp(X,Y,R) :-(Y > 0),(Y1 is Y-1),carp(X,Y1,R1),topla(X,R1,R).

bolme(X,Y,0) :- (not(Y = 0)), (X<Y).
bolme(X,Y,R) :- (not(Y = 0)),(X >= Y), cikar(X,Y,X1), bolme(X1,Y,R1) ,(R is R1+1).


%Base Clause
ussel(0,_,0).
ussel(_,0,1).

ussel(X,Y,R) :- (not(X) is 0),(Y>0), (Y1 is Y-1),ussel(X,Y1,R1), carp(X,R1,R).

%***********LISTS**************

%BASE CLAUSE
list([],[]).

%RECURSIVE CLAUSE
list([X|Y],R):-list(Y,R1),append(R1,[X],R).

%BASE CLAUSE
len(0,[]).

%RECURSIVE CLAUSE
len(R,[_|Y]) :- len(R1,Y) , (R is R1+1).

%BASE CLAUSE
membership([X|_],L):- append([X],[],L).

%RECURSIVE CLAUSE
membership([_|Xs],L) :- membership(Xs,L).

%BASE CLAUSE
member1(X, [X|_]).
%RECURSIVE CLAUSE
member1(X,[_|Ys]) :- member1(X,Ys).

%BASE CLAUSE
prefix([],_).

%RECURSIVE CLAUSE
prefix([X|Xs],[X|Ys]) :- prefix(Xs , Ys).

%BASE CLAUSE
suffix(R,R).

%RECURSIVE CLAUSE
suffix(Xs,[_|Ys]) :- suffix(Xs,Ys).

sublists(Y, X) :- prefix(Z,X), suffix(Y,Z).

%BASE CLAUSE
reversed([],[]).
%RECURSIVE CLAUSE
reversed(Result,[First|Rest]) :- reversed(Result1,Rest),append(Result1,[First],Result).

%BASE CLAUSE
lasts(Last,[Last]).

%RECURSIVE CLAUSE
lasts(Result,[_|Rest]):- lasts(Result,Rest).

%BASE CLAUSE
%deletes(list, X, list has no X).

deletes([],_,[]).
deletes([X|Xs],X,Ys):-deletes(Xs,X,Ys).

%RECURSIVE CLAUSE

deletes([X|Xs],Z,[X|Ys]):-(not(Z=X)),deletes(Xs,Z,Ys).

%BASE CLAUSE
%select(list,X,list has no first X).

selects([X|Xs],X,Xs).

%RECURSIVE CLAUSE
selects([X|Xs],X,[X|Ys]):-selects(Xs,X,Ys).

%insert(list,X,inserted X list).

insert(Ys,X,Zs):-selects(Zs,X,Ys).

%replace(list, X, replacing one element with X).

replace([Y|Ys],X,Zs):-selects([Y|Ys],Y,Zs1),insert(Zs1,X,Zs).
