:- dynamic animal/5.
% Base de conocimiento inicial
% % Mamíferos
%animal(nombre, tipo, lugar,car1, car2)
animal(mono_titi, mamifero, selva, cola_larga, simio).
animal(jaguar, mamifero, selva, carnivoro, felino).
animal(venado_coliblanco, mamifero, sabana, herbivoro, rumiante).
animal(oso_de_antioquia, mamifero, bosque, omnivoro, ursido).
% Aves
animal(condor_de_los_andes, ave, montaña, volador, carroñero).
animal(guacamaya_bandera, ave, selva, volador, psitacido).
animal(garza_real, ave, humedal, volador, zancudo).
animal(canario, ave, bosque, volador, passeriforme).
% Reptiles
animal(caiman_del_magdalena, reptil, agua_dulce, carnivoro, lagarto).
animal(iguana_verde, reptil, selva, herbivoro, lagarto).
animal(boa_constrictor, reptil, selva, carnivoro, serpiente).
animal(tortuga_mora, reptil, sabana, herbivoro, quelonio).
% Anfibios
animal(rana_dorada, anfibio, selva, venenoso, anuro).
animal(sapo_comun, anfibio, humedal, insectivoro, anuro).
animal(salamandra_comun, anfibio, bosque, insectivoro, caudado).
animal(rana_arboricola, anfibio, selva, insectivoro, anuro).
% Peces
animal(trucha_arcoiris, pez, agua_dulce, omnivoro, salmonido).
animal(pirarucu, pez, agua_dulce, carnivoro, osteogloso).
animal(mojarra, pez, agua_dulce, omnivoro, cichlido).
animal(tiburon_martillo, pez, marino, carnivoro, selacio).
% Insectos
animal(mariposa_morpho, insecto, selva, volador, lepidoptero).
animal(hormiga_cortadora, insecto, selva, terrestre, formicido).
animal(abeja_africana, insecto, campo, volador, apido).
animal(escarabajo_hercules, insecto, bosque, terrestre, escarabeido).
% Preguntar características e inferir animal
preguntar:-
    write('Escriba el tipo de animal terminando con punto. Ejemplo: mamifero. '),     read(Tipo), nl,
    write('Escriba el habitad terminando con punto. Ejemplo: selva. '),     read(Habitad), nl,
    write('Escriba una caracteritica del animal terminando con punto. Ejemplo: volador. '),     read(Car1), nl,
    write('Escriba una segunda caracteritica del animal terminando con punto. Ejemplo: escarabeido. '),     read(Car2), nl,
    inferir(Tipo, Habitad, Car1, Car2).
inferir(Tipo, Habitad, Car1, Car2):-    
    animal(Nombre, Tipo, Habitad, Car1, Car2),
    write('El animal podría ser un '), write(Nombre), nl, !;    write('No se pudo determinar el animal con las características dadas.'), nl.
% Hipótesis
hipotesis:-    
    write('Proporciona una hipótesis del animal que piensas (nombre del animal terminado con punto). '),
    read(AnimalHipotesis),    
    pregunta_caracteristicas(AnimalHipotesis).
pregunta_caracteristicas(AnimalHipotesis):-
    animal(AnimalHipotesis, Tipo, Habitad, Car1, Car2),    format('¿Es un ~w? (si/no). ', [Tipo]), read(R1), nl,
    R1 == si -> (        format('¿Habita en la ~w? (si/no). ', [Habitad]), read(R2), nl,
        R2 == si -> (            format('¿Tiene característica de ser ~w? (si/no). ', [Car1]), read(R3), nl,
            R3 == si -> (                format('¿Tiene característica de ser ~w? (si/no). ', [Car2]), read(R4), nl,
                R4 == si -> (                    write('Tu hipótesis es correcta.'), nl
                ) ; write('Tu hipótesis es incorrecta.')            ) ; write('Tu hipótesis es incorrecta.')
        ) ; write('Tu hipótesis es incorrecta.')    ) ; write('Tu hipótesis es incorrecta.').
% Agregar animal
agregar_animal:-    
    write('Ingrese el nombre del animal (terminando con punto). '), read(Nombre), nl,
    write('Ingrese el tipo de animal (terminando con punto). '), read(Tipo), nl,    write('Ingrese el habitad del animal (terminando con punto). '), read(Habitad), nl,
    write('Ingrese una caracteritica del animal (terminando con punto). '), read(Car1), nl,    write('Ingrese una segunda caracteritica del animal (terminando con punto). '), read(Car2), nl,
    assert(animal(Nombre, Tipo, Habitad, Car1, Car2)),    write('Animal agregado exitosamente.'), nl.
% Limpieza de la base de conocimiento
limpiar:-    
	retract(animal(_, _, _, _, _)), fail.
limpiar.
