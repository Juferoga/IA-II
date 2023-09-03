:- dynamic animal/2.

% Base de conocimiento inicial
% Mamíferos
animal(mono_titi, [mamifero, selva, cola_larga, simio]).
animal(jaguar, [mamifero, selva, carnivoro, felino]).
animal(venado_coliblanco, [mamifero, sabana, herbivoro, rumiante]).
animal(oso_de_antioquia, [mamifero, bosque, omnivoro, ursido]).

% Aves
animal(condor_de_los_andes, [ave, montaña, volador, carroñero]).
animal(guacamaya_bandera, [ave, selva, volador, psitacido]).
animal(garza_real, [ave, humedal, volador, zancudo]).
animal(canario, [ave, bosque, volador, passeriforme]).

% Reptiles
animal(caiman_del_magdalena, [reptil, agua_dulce, carnivoro, lagarto]).
animal(iguana_verde, [reptil, selva, herbivoro, lagarto]).
animal(boa_constrictor, [reptil, selva, carnivoro, serpiente]).
animal(tortuga_mora, [reptil, sabana, herbivoro, quelonio]).

% Anfibios
animal(rana_dorada, [anfibio, selva, venenoso, anuro]).
animal(sapo_comun, [anfibio, humedal, insectivoro, anuro]).
animal(salamandra_comun, [anfibio, bosque, insectivoro, caudado]).
animal(rana_arboricola, [anfibio, selva, insectivoro, anuro]).

% Peces
animal(trucha_arcoiris, [pez, agua_dulce, omnivoro, salmonido]).
animal(pirarucu, [pez, agua_dulce, carnivoro, osteogloso]).
animal(mojarra, [pez, agua_dulce, omnivoro, cichlido]).
animal(tiburon_martillo, [pez, marino, carnivoro, selacio]).

% Insectos
animal(mariposa_morpho, [insecto, selva, volador, lepidoptero]).
animal(hormiga_cortadora, [insecto, selva, terrestre, formicido]).
animal(abeja_africana, [insecto, campo, volador, apido]).
animal(escarabajo_hercules, [insecto, bosque, terrestre, escarabeido]).

preguntar:-
    write('Escriba la lista de características del animal (terminando con punto). Ejemplo: [mamifero, selva]. '), 
    read(Caracteristicas), nl,
    assert(animal(desconocido, Caracteristicas)),
    inferir.

inferir:-
    animal(Nombre, Caracteristicas),
    animal(desconocido, Desconocido),
    subset(Caracteristicas, Desconocido),
    write('El animal podría ser un '), write(Nombre), nl, undo;
    write('No se pudo determinar el animal con las características dadas.'), nl, undo.

% Para deshacer todas los axiomas
undo:- retract(animal(_,_)), fail.
undo.

% Para agregar nuevos animales a la base de conocimiento
agregar_animal:-
    write('Ingrese el nombre del animal (terminando con punto). '), read(Nombre), nl,
    write('Ingrese la lista de características (terminando con punto). '), read(Caracteristicas), nl,
    assert(animal(Nombre, Caracteristicas)),
    write('Animal agregado exitosamente.'), nl.
