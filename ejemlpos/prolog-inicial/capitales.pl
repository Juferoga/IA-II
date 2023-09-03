% Hechos y reglas
:- nl,nl,write('Digite \'preguntar.\' para iniciar:  ?- preguntar. '), nl,nl,nl.


:- dynamic capital_of/2.

capital_of(suiza, berna).
capital_of(chile, santiago).
capital_of(eeuu, washington).
capital_of(estados_unidos, washington).
capital_of(italia, roma).
capital_of(francia, paris).
capital_of(austria, viena).
capital_of(alemania, berlin).
capital_of(españa, madrid).
capital_of(peru, lima).
capital_of(mexico, cuidad_de_mexico).

preguntar:-
 write('Digite el nombre del pais (con min�scula y terminando con punto) '),  read(Pais), nl,
 write('Digite el nombre de la capital (con min�scula y terminando con punto)'),  read(Capital), nl,
 assert(capital_of(Pais,Capital)),repetir.

repetir:- write('desea incluir otro pais y su capital? (si/no) '), read(Respuesta),nl, ((Respuesta==si)->preguntar;fail).
 
undo :- capital_of(_ ,_),fail.
undo.
