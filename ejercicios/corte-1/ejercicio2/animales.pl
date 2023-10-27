:- dynamic verificar/1, hipotesis/2.

% Pide al usuario ingresar características de un animal y verifica si se ajustan a una hipótesis.
identificar_animal :- 
    retractall(verificar(_)), % Limpiar las características previas.
    write('Ingresa las características del animal (escribe "fin" para terminar):\n'),
    identificar.

% Lee las características ingresadas por el usuario.
identificar :-
    read(Caracteristica),
    (Caracteristica == 'fin' -> determinar_animal; 
    assert(verificar(Caracteristica)),
    identificar).

% Determina a qué animal corresponde según las características ingresadas.
determinar_animal :-
    (hipotesis(Animal) -> 
    write('El animal es un '), write(Animal), nl;
    write('No se pudo identificar el animal.')),
    retractall(verificar(_)).

% Hipótesis

%mamiferos
hipotesis(mono_titi) :- 
    verificar(mamifero),
    verificar(selva),
    verificar(cola_larga),
    verificar(simio).

hipotesis(jaguar) :- 
    verificar(mamifero),
    verificar(selva),
    verificar(carnivoro),
    verificar(felino).

hipotesis(venado_coliblanco) :- 
    verificar(mamifero),
    verificar(sabana),
    verificar(herbivoro),
    verificar(rumiante).

hipotesis(oso_de_antioquia) :- 
    verificar(mamifero),
    verificar(bosque),
    verificar(omnivoro),
    verificar(ursido).

%aves
hipotesis(condor_de_los_andes) :- 
    verificar(ave),
    verificar(montaña),
    verificar(volador),
    verificar(carroñero).

hipotesis(guacamaya_bandera) :- 
    verificar(ave),
    verificar(selva),
    verificar(volador),
    verificar(psitacido).

hipotesis(garza_real) :- 
    verificar(ave),
    verificar(humedal),
    verificar(volador),
    verificar(zancudo).

hipotesis(canario) :- 
    verificar(ave),
    verificar(bosque),
    verificar(volador),
    verificar(passeriforme).



hipotesis(desconocido). % Si no se puede identificar ningún animal.

% Función para verificar características del animal ingresado por el usuario
verificar_caracteristicas :-
    write('Ingresa el nombre del animal: '),
    read(Animal),
    findall(Caracteristica, caracteristicas_anim3al(Animal, Caracteristica), ListaCaracteristicas),
    preguntar_caracteristicas(ListaCaracteristicas, Respuestas),
    (todas_correctas(Respuestas) -> 
        write('¡Felicidades! Las características son correctas.\n');
        write('Las características no corresponden al animal.\n')).

caracteristicas_animal(Animal, Caracteristica) :-
    clause(hipotesis(Animal), Body),
    body_to_list(Body, List),
    member(verificar(Caracteristica), List).

body_to_list(true, []).
body_to_list((A, B), [A|Rest]) :- body_to_list(B, Rest).
body_to_list(A, [A]).

preguntar_caracteristicas([], []).
preguntar_caracteristicas([Caracteristica|Resto], [Respuesta|RestoRespuestas]) :-
    format('¿El animal ~w? (si/no) ', [Caracteristica]),
    read(Respuesta),
    preguntar_caracteristicas(Resto, RestoRespuestas).

todas_correctas([]).
todas_correctas([si|Resto]) :- todas_correctas(Resto).

% Agregar un nuevo animal y sus características.
agregar_animal :-
    write('Ingresa el nombre del nuevo animal: '),
    read(NuevoAnimal),
    write('Ingresa las características del nuevo animal (escribe "fin" para terminar):\n'),
    agregar_caracteristicas(NuevoAnimal, Caracteristicas),
    construir_hipotesis(NuevoAnimal, Caracteristicas).

agregar_caracteristicas(Animal, Caracteristicas) :-
    read(Caracteristica),
    (Caracteristica == 'fin' ->
        Caracteristicas = [];
        agregar_caracteristicas(Animal, RestoCaracteristicas),
        Caracteristicas = [Caracteristica|RestoCaracteristicas]).

construir_hipotesis(Animal, []) :-
    assertz(hipotesis(Animal)).
construir_hipotesis(Animal, [Caracteristica|Resto]) :-
    construir_hipotesis(Animal, Resto),
    assertz((hipotesis(Animal) :- verificar(Caracteristica))).

% Programa principal
inicio :-
    write('Selecciona una opción:\n'),
    write('1. Identificar animal por características.\n'),
    write('2. Verificar características de un animal.\n'),
    write('3. Verificar características de un animal.\n'),
    read(Opcion),
    (Opcion == 1 -> identificar_animal; 
     Opcion == 2 -> verificar_caracteristicas;
     Opcion == 3 -> agregar_animal;
     write('Opción no válida.\n')), % Manejar opciones inválidas.
    inicio. % Vuelve al menú después de completar una opción.

% Ejecuta el programa
:- inicio.