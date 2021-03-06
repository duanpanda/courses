%%% Exercise #1: Structures in Prolog
%%% Author: Rui Duan (0561866)
%%% Date: September 30, 2014

%%% 1(a)
extractout(X, [X|R], R).
extractout(X, [H|R], [H|S]) :- extractout(X, R, S).

%%% To insert 3 into [1,2], do the following query:
%%%    extractout(3, L, [1,2]).

%%% 1(b)
permutation([X|Y], Z) :- permutation(Y, W), extractout(X, Z, W).
permutation([], []).

%%% 1(c)
sub(X, Y, [H|T], [H|R]) :- H \= X, sub(X, Y, T, R).
sub(X, Y, [X|T], [Y|R]) :- sub(X, Y, T, R).
sub(X, Y, [], []).

%%% 2(a)
% test data:
%   t(t(t(nil,1,nil), 2, t(nil,3,nil)), 4, t(t(nil,5,nil), 6, t(nil,7,nil)))
% almost the same as Dr. Mohammed's version
less(X, t(L, K, R)) :-
	X < K,			% replaced 'less(X, K)' with 'X < K', because
				% X and K are atoms, they cannot be t(L,K,R).
	less(X, L),
	less(X, R), !.
less(t(L, K, R), X) :-
	K < X,			% replaced 'less(K, X)' with 'K < X'
	less(L, X),
	less(R, X), !.
less(nil, X) :- !.
less(X, nil) :- !.
% less(X, Y) :- X < Y.         % deleted this to avoid cases like '3 < nil'
orderedT(t(L, K, R)) :-
	less(L, K),
	less(K, R).

%% Dr. Sabah Mohammed's version
orderedT( t(L, K, R) ) :-
	ordered_left(L, K),
	ordered_right(K, R).
ordered_left(nil, N).		% we can add ':- !.' here
ordered_left(t(L, K, R), N) :-
	K < N,
	ordered_left(L, K),
	ordered_right(K, R).
ordered_right(N, nil).		% we can add ':- !.' here
ordered_right(N, t(L, K, R)) :-
	N < K,
	ordered_left(L, K),
	ordered_right(K, R).

%%% 2(b)
in(X, t(_, K, _)) :- X == K.
in(X, t(L, K, _)) :-
	X < K,
	in(X, L).
in(X, t(_, K, R)) :-
	X > K,
	in(X, R).
tree_ins(X, t(L, K, R), t(L, K, R)) :-
	in(X, t(L, K, R)),!.
tree_ins(X, nil, t(nil, X, nil)).
tree_ins(X, t(L, K, R), t(NewL, K, R)) :-
	X < K,
	!,
	tree_ins(X, L, NewL).
tree_ins(X, t(L, K, R), t(L, K, NewR)) :-
	X > K,
	!,
	tree_ins(X, R, NewR).

%% Tested for X = 0 to 14, insert X to the tree
%%   t(t(t(nil,1,nil), 3, t(nil,5,nil)), 7, t(t(nil,9,nil), 11, t(nil,13,nil)))
%% Query:
%%   test([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]).
%% Pass
test([]).
test([H|T]) :-
	Tree = t(t(t(nil,1,nil), 3, t(nil,5,nil)), 7, t(t(nil,9,nil), 11, t(nil,13,nil))),
	tree_ins(H, Tree, X),
	write(X),nl,
	test(T).

%%% 3
%%% --------------------------------
%%% USAGE: colour_countries(X).
%%% --------------------------------
% Allowed Colors
color(red).
color(blue).
color(green).
color(yellow).

% Geographical data for South America
country(antilles). country(argentina).
country(bolivia). country(brazil).
country(columbia). country(chile).
country(ecuador). country(french_guiana).
country(guyana). country(paraguay).
country(peru). country(surinam).
country(uruguay). country(venezuela).
beside(antilles,venezuela). beside(argentina,bolivia).
beside(argentina,brazil). beside(argentina,chile).
beside(argentina,paraguay). beside(argentina,uruguay).
beside(bolivia,brazil). beside(bolivia,chile).
beside(bolivia,paraguay). beside(bolivia,peru).
beside(brazil,columbia). beside(brazil,french_guiana).
beside(brazil,guyana). beside(brazil,paraguay).
beside(brazil,peru). beside(brazil,surinam).
beside(brazil,uruguay). beside(brazil,venezuela).
beside(chile,peru). beside(columbia,ecuador).
beside(columbia,peru). beside(columbia,venezuela).
beside(ecuador,peru). beside(french_guiana,surinam).
beside(guyana,surinam). beside(guyana,venezuela).

colour_countries(Colours):-
        setof(Country/_, X^ngb(Country,X), Colours),
        colours(Colours),
	write(Colours),nl.	% print

colours([]).
colours([Country/Colour|Rest]):-
        colours(Rest),
        member(Colour, [yellow,blue,red,green]),
        \+ (member(Country1/Colour, Rest), neighbour(Country, Country1)).

neighbour(Country, Country1):-
        ngb(Country, Neighbours),
        member(Country1, Neighbours).

ngb(antilles, [venezuela]).
ngb(argentina, [bolivia,brazil,chile,paraguay,uruguay]).
ngb(bolivia, [brazil,chile,paraguay,peru,argentina]).
ngb(brazil, [columbia,french_guiana,guyana,paraguay,peru,surinam,uruguay,venezuela,argentina,bolivia]).
ngb(columbia, [ecuador,peru,venezuela,brazil]).
ngb(chile, [peru,argentina,bolivia]).
ngb(ecuador, [peru,columbia]).
ngb(french_guiana, [surinam,brazil]).
ngb(guyana, [surinam,venezuela,brazil]).
ngb(paraguay, [argentina,bolivia,brazil]).
ngb(peru, [bolivia,brazil,chile,columbia,ecuador]).
ngb(surinam, [brazil,french_guiana,guyana]).
ngb(uruguay, [argentina,brazil]).
ngb(venezuela, [antilles,brazil,columbia,guyana]).
