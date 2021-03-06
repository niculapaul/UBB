% a. Sort a list with removing the double values. E.g.: [4 2 6 2 3 4]
% --> [2 3 4 6]
%
% b. For a heterogeneous list, formed from integer numbers and list of
% numbers, write a predicate to sort every sublist with removing the
% doubles.

% a.
% Model matematic:
% bubble_sort(l1,l2,l3,...ln):
%    - [], if the list is empty
%    - l1,l2,...,ln, if bubble(l1,l2,...ln) = l1,l2,...,ln
%    - bubble_sort(bubble(l1,...,ln)), otherwise
% flow model(i,o)

bubble_sort([],[]).
bubble_sort(L, S) :-
	bubble(L, L) -> S = L ;
	bubble(L, P), bubble_sort(P, S).

% Model matematic:
% bubble(l1,..,ln):
%    - [], if the list is empty
%    - [l1], if the list has only one element
%    - l1 U bubble(l2,...,ln), if l2 > l1
%    - l2 U bubble(l1,l3,...,ln), if l1 > l2
% flow model(i,o)

bubble([], []).
bubble([X], [X]).
bubble([X,Y|T], [Y|R]) :-
	Y < X, bubble([X|T], R).
bubble([X,Y|T], [X|R]) :-
	X =< Y, bubble([Y|T], R).

% Model matematic:
% Functia sterge aparitiile suplimentare ale unui element dintr-o lista
% sortata
% remove_doubles(l1,...,ln):
% - [] if the list is empty
% - remove_doubles(l2,...,ln), if l1=l2
% - l1 U remove_doubles(l2,...,ln), if l1!=l2
% flow model(i,o)

remove_doubles([], []).
remove_doubles([H], [H]).
remove_doubles([H, H|T], R):-
	remove_doubles([H|T], R), !.
remove_doubles([H1, H2|T], [H1|R]):-
	remove_doubles([H2|T], R).

% flow model(i,o)
sorted_set(L, R):-
	bubble_sort(L, SORTED),
	remove_doubles(SORTED, R).

% b.
% Model matematic:
% main(l1,l2,...ln):
%    - [] if the list is empty
%    - l1 U main(l2,...,ln), if l1 - atom
%    - sorted_set(l1) U main(l2,...,ln) if l1 - list
% flow_model(i,o)
main([], []).
main([H|T], [H|R]):-
	not(is_list(H)),
	main(T, R).
main([H|T], [SET|R]):-
	is_list(H),
	sorted_set(H, SET),
	main(T, R).

%main([1,4,3,[5,4,4,2,2,1,7],3,[2,4,4,3]],R), print(R).
