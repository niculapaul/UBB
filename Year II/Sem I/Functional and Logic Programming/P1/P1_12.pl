%a. Write a predicate to substitute in a list a value with all the elements of another list.
%b. Remove the n-th element of a list.
%
% Model matematic:
% a) substituteElement(l1,...,ln,v,k1,...,km) =
%    - [], if n = 0
%    - concat(l2,...,ln,k1,...,km), if l1 = v
%    - l1 U substitute(l2,...,ln,,v,k1,...,kn) otherwise
%
%    concat(l1,...,ln,k1,...km)=
%    - [], if m=0, n=0
%    - [l1,...,ln], if m=0
%    - [k1,...,km], if n=0
%    - l1 U concat(k1,...,km) otherwise
%
% b) removeElement(l1,...,ln,i)=
%    - [], if n=0
%    - [l2,...,ln], if i=1
%    - l1 U removeElement(l2,...,ln) otherwise


% a) Flow model (i,i,o)
concat(A,[],A).
concat([],A,A).
concat([],[],[]).
concat([A|B],C,R):-concat(B,C,R1), R = [A|R1].
% Edge cases:
% - The first list is empty: the result is the second list
% - The second list is empty: the result is the first list
% - Both lists are empty: the result is the empty list

% Flow model (i,i,i,o)
substituteElement([],_,_,[]).
substituteElement([H|T],E,B,R):-H=:=E->concat(B,T,R1),substituteElement(R1,E,B,R); substituteElement(T,E,B,R1), R=[H|R1].

% Edge cases:
% - The list is empty: we do nothing (other option: add the elements of
% the other list)
% - We cannot find the element E: we do nothing (other option: add
% them add the end or something, but that would be concatenation and
% not substitution)
% - There are duplicates: we replace them all


% b) Flow model (i,i,o)
removeElement([],_,[]).
removeElement([_|T],1,T).
removeElement([H|T],K,R):-K1 is K-1, removeElement(T,K1,R1), R = [H|R1].

% Edge cases:
% - The element does not exist: nothing happens

