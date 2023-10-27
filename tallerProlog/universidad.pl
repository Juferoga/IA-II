%Universidades%
carreras(distrital, sistemas).
carreras(distrital, electronica).
carreras(nacional, sistemas).
carreras(nacional, electronica).
carreras(andes, sistemas).
carreras(andes, medicina).
carreras(javeriana,sistemas).
carreras(javeriana,medicina).
%Profesores%
asignacion(ana, calculo, sistemas, nacional).
asignacion(ana, ecuaciones, electronica, distrital).
asignacion(luis, especiales, sistemas, nacional).
asignacion(luis, fisica, sistemas, andes).
asignacion(pedro, calculo, sistemas, javeriana).
asignacion(pedro, especiales, sistemas, distrital).
asignacion(jose, calculo, electronica, distrital).
asignacion(jose, calculo, sistemas, distrital).
asignacion(juan, ecuaciones, electronica, distrital).
asignacion(juan, ecuaciones, sistemas, andes).
asignacion(juan, especiales, meidicina, andes).
asignacion(rosa, fisica, electronica, nacional).
asignacion(rosa, fisica, medicina, javeriana).
asignacion(rosa, calculo, medicina, andes).
asignacion(jesus, especiales, sistemas, javeriana).
asignacion(jesus, especiales, medicina, javeriana).
% Estudiantes%
estudia(flor, calculo, sistemas, nacional, ana).
estudia(flor, matematicasespeciales, sistemas, nacional, luis).
estudia(jesus, ecuaciones, electronica, distrital, ana).
estudia(jesus, calculo, electronica, distrital, jose).
estudia(andres, fisica, sistemas, andes, luis).
estudia(andres, ecuaciones, sistemas, andes, juan).
estudia(paco, matematicasespeciales, sistemas, distrital, pedro).
estudia(paco, calculo, sistemas, distrital, jose).
estudia(angela, calculo, sistemas, javeriana, pedro).
estudia(angela, matematicasespeciales, sistemas, javeriana, jesus).
estudia(imera, fisica, medicina, javeriana, rosa).
estudia(imera, matematicasespeciales, medicina, javeriana, jesus).
estudia(esther, matematicasespeciales, medicina, andes, juan).
estudia(esther, calculo, medicina, andes, rosa).
estudia(mario, ecuaciones, electronica, nacional, juan).
estudia(mario, fisica, electronica, nacional, rosa).
%Soluciones%
% 1. Universidades que ofrecen una carrera específica
universidad_que_ofrece(Carrera, X):- carreras(X, Carrera).
% 2. Profesores que dictan en varias carreras de la misma universidad
profesor_varias_carreras(Universidad,X):- asignacion(X,_Y,Z,Universidad), asignacion(X,_J,W,Universidad),Z\=W.
% 3. Profesores que dictan en diferentes universidades
profesor_varias_universidades(X):-asignacion(X,_Y,_Z,W),asignacion(X,_L,_M,O), W\=O.  
% 4. Universidades donde dicta un profesor específico
universidades_profesor(Profesor,X):- asignacion(Profesor,_Y,_Z,X).
% 5. Asignaturas que dicta un profesor
asignaturas_profesor(Profesor,X):- asignacion(Profesor,X,_Z,_Y).
% 6. Profesores que dictan una asignatura específica en cualquier universidadxa
profesores_asignatura(Asignatura,X):-asignacion(X,Asignatura,_Y,_Z).
% 7. Profesores que dictan en una universidad específica
profesores_universidad(Universidad,X):-asignacion(X,_Y,_Z,Universidad).
% 8. Estudiantes que pertenecen a una universidad específica
estudiantes_universidad(Universidad, Estudiante) :-estudia(Estudiante, _, _, Universidad, _).
% 9. Estudiantes que estudian una carrera específica en cualquier universidad
estudiantes_carrera(Carrera, Estudiante) :-estudia(Estudiante, _, Carrera, _, _).
% 10. Estudiantes que tienen una asignatura específica inscrita
estudiantes_asignatura(Asignatura, Carrera, Universidad, Estudiante) :-estudia(Estudiante, Asignatura, Carrera, Universidad, _).
% 11. Estudiantes de un profesor específico
estudiantes_profesor(Profesor, Estudiante) :-estudia(Estudiante, _, _, _, Profesor).