padre(pedro,josé).
padre(josé,luis).
padre(josé,ignacio).
padre(ignacio,maría).
padre(ignacio,mercedes).

ancestro(X,Y):- padre(X,Y).
ancestro(X,Y):- padre(X,C),ancestro(C,Y).