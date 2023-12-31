breed [personas persona]
globals [
  contador-correr
  contador-shock
  contador-paralizado
  contador-buscar-amigos
  contador-calmado
  contador-control
  contador-H
  contador-M
  contador
  hora
]

personas-own [
  genero
  comportamiento
  carrera
]

to setup
  clear-all
  setup-entorno

  ; Reiniciar contadores
  set contador 0
  set contador-correr 0
  set contador-shock 0
  set contador-paralizado 0
  set contador-buscar-amigos 0
  set contador-calmado 0
  set contador-control 0
  set contador-H 0
  set contador-M 0

  repeat 40 [
    ifelse random-float 1.0 < prob-salon [
      ; Crear tortuga en un salón
      crear-tortuga-en patches with [pcolor = 57 or pcolor = 57]
    ] [
      ; Crear tortuga en el pasillo
      crear-tortuga-en patches with [pcolor = 6]
    ]
  ]
  etiquetar-personas
  reset-ticks
end

to crear-tortuga-en [parches-posibles]
  let new-patch one-of parches-posibles
  if new-patch != nobody [
    ; Verifica si hay menos de 40 personas en el salón
    let num-turtles count turtles-on new-patch
    if num-turtles < 40 [
      ask new-patch [
        sprout-personas 1 [
          set shape "person"
          set genero ifelse-value (random-float 1.0 < 0.5) ["H"] ["M"]
          set comportamiento escoger-comportamiento genero
          ; Asignamos la carrera aquí
          set carrera escoger-carrera plabel
          set color color-segun-comportamiento comportamiento
        ]
      ]
    ]
  ]
end

to-report escoger-carrera [salon]
  let carreras ["sis" "ind" "cat" "ele" "mec"]
  let carrera-predominante ""

  if salon = "Aula 206" [ set carrera-predominante "sis" ]
  if salon = "Aula 205" [ set carrera-predominante "ind" ]
  if salon = "Aula 204" [ set carrera-predominante "cat" ]
  if salon = "Aula 201" [ set carrera-predominante "ele" ]
  if salon = "Aula 202" [ set carrera-predominante "mec" ]
  if salon = "Aula 203" [ set carrera-predominante "sis" ]

  ; 70% de probabilidad de que sea la carrera predominante
  ifelse random-float 1.0 < 0.7 and carrera-predominante != "" [
    report carrera-predominante
  ][
    let carreras-alternativas ifelse-value (member? carrera-predominante carreras) [
      remove-item (position carrera-predominante carreras) carreras
    ] [
      carreras
    ]
    report one-of carreras-alternativas
  ]
end


to setup-entorno
;; Establecer el fondo
  ask patches [ set pcolor white ]

  ;; Crear el pasillo principal
  ask patches with [ pxcor > -30 and pxcor < 32 and pycor > -5 and pycor < 5 ] [ set pcolor 6 ]

  ;; Crear escalera salida
  ask patches with [ pxcor > -25 and pxcor < -15 and pycor > 4 and pycor < 15 ] [ set pcolor 8 ]
  ask patches with [ pxcor = -18 and pycor = 10 ][ set plabel "Escalera salida" ]

  ;; Crear escalera
  ask patches with [ pxcor > -25 and pxcor < -15 and pycor > -15 and pycor < -4 ] [ set pcolor 17 ]
  ask patches with [ pxcor = -18 and pycor = -10 ][ set plabel "Escalera subida" ]

  ;; Crear ascensor
  ask patches with [ pxcor > -15 and pxcor < -5 and pycor > 5 and pycor < 15 ] [ set pcolor 27 ]
  ask patches with [ pxcor = -10 and pycor = 10 ][ set plabel "Ascensor" ]

  ;; Crear salones a la derecha del pasillo
  ask patches with [ pxcor > -5 and pxcor < 8 and pycor > 5 and pycor < 15 ] [ set pcolor 57 ]
  ask patches with [ pxcor = 2 and pycor = 10 ][ set plabel "Aula 206" ]

  ask patches with [ pxcor > 8 and pxcor < 20 and pycor > 5 and pycor < 15 ] [ set pcolor 57 ]
  ask patches with [ pxcor = 16 and pycor = 10 ][ set plabel "Aula 205" ]

  ask patches with [ pxcor > 20 and pxcor < 32 and pycor > 5 and pycor < 15 ] [ set pcolor 57 ]
  ask patches with [ pxcor = 26 and pycor = 10 ][ set plabel "Aula 204" ]

  ;; Crear salones a la izquierda del pasillo
  ask patches with [ pxcor > -15 and pxcor < -2 and pycor > -15 and pycor < -5 ] [ set pcolor 57 ]
  ask patches with [ pxcor = -10 and pycor = -10 ][ set plabel "Aula 201" ]

  ask patches with [ pxcor > -2 and pxcor < 10 and pycor > -15 and pycor < -5 ] [ set pcolor 57 ]
  ask patches with [ pxcor = 5 and pycor = -10 ][ set plabel "Aula 202" ]

  ask patches with [ pxcor > 10 and pxcor < 22 and pycor > -15 and pycor < -5 ] [ set pcolor 57 ]
  ask patches with [ pxcor = 16 and pycor = -10 ][ set plabel "Aula 203" ]

  ;; Crear baños
  ask patches with [ pxcor > 22 and pxcor < 32 and pycor > -15 and pycor < -5 ] [ set pcolor 133 ]
  ask patches with [ pxcor = 26 and pycor = -10 ][ set plabel "Baños" ]

  ;; Crear puertas
  ;; Puerta Ascensor
  ask patches with [ (pxcor = -14 or pxcor = -13 or pxcor = -12) and pycor = 5 ][ set pcolor 2 ]
  ;; Puerta 204
  ask patches with [ (pxcor = -4 or pxcor = -3 or pxcor = -2) and pycor = 5 ][ set pcolor 2 ]
  ;; Puerta 205
  ask patches with [ (pxcor = 9 or pxcor = 10 or pxcor = 11) and pycor = 5 ][ set pcolor 2 ]
  ;; Puerta 206
  ask patches with [ (pxcor = 21 or pxcor = 22 or pxcor = 23) and pycor = 5 ][ set pcolor 2 ]
  ;; Puerta 201
  ask patches with [ (pxcor = -14 or pxcor = -13 or pxcor = -12) and pycor = -5 ][ set pcolor 2 ]
  ;; Puerta 202
  ask patches with [ (pxcor = -1 or pxcor = 0 or pxcor = 1) and pycor = -5 ][ set pcolor 2 ]
  ;; Puerta 203
  ask patches with [ (pxcor = 11 or pxcor = 12 or pxcor = 13) and pycor = -5 ][ set pcolor 2 ]
  ;; Puerta Baños
  ask patches with [ (pxcor = 23 or pxcor = 24 or pxcor = 25) and pycor = -5 ][ set pcolor 2 ]

  reset-ticks
end

to go
ask turtles [
  if [pcolor] of patch-here != 8 [ ; Verifica si la "persona" no está en una salida
    mover-o-evacuar "mover"
    interaccion-shock
    interaccion-buscar-amigos
    agrupar-estudiantes
    comportamiento-ascensor
    mover-o-evacuar "evacuar"
  ]

;; La morición ;;
; Si el color del parche en el que se encuentra es igual a 8
if [pcolor] of patch-here = 8 [
  ; Incrementa el contador de comportamiento
  if comportamiento = "correr" [
    set contador-correr contador-correr + 1
  ]
  if comportamiento = "shock" [
    set contador-shock contador-shock + 1
  ]
  if comportamiento = "paralizado" [
    set contador-paralizado contador-paralizado + 1
  ]
  if comportamiento = "buscar-amigos" [
    set contador-buscar-amigos contador-buscar-amigos + 1
  ]
  if comportamiento = "calmado" [
    set contador-calmado contador-calmado + 1
  ]
  if comportamiento = "control" [
    set contador-control contador-control + 1
  ]
]

; Incrementa el contador de género
  if genero = "H" [
    set contador-H contador-H + 1
]
  if genero = "M" [
   set contador-M contador-M + 1
]
  set contador contador + 1
  ;; Actualizamos las graficas :D
  update-plots
  ; Elimina la tortuga
  die
]
tick
end

to mover-o-evacuar [tipo]
  ask personas [
    ; Priorizar los parches negros, luego los de color 3 y finalmente los de color 8
    let destino-cercano nobody

    ; Si está en el color 8, no necesita cambiar de destino.
    if [pcolor] of patch-here = 8 [
      set destino-cercano patch-here
    ]

    ; Si está en el color 6, el objetivo es el color 8.
    if [pcolor] of patch-here = 6 [
      set destino-cercano min-one-of patches with [pcolor = 8] [distance myself]
    ]

    ; Si está en el color 2, el objetivo es el color 3.
    if [pcolor] of patch-here = 2 [
      set destino-cercano min-one-of patches with [pcolor = 6] [distance myself]
    ]

    ; Si está en cualquier otro color, el objetivo es el 2.
    if destino-cercano = nobody [
      set destino-cercano min-one-of patches with [pcolor = 2] [distance myself]
    ]

    if destino-cercano != nobody [ ; Si hay un destino válido
      face destino-cercano ; Orientar hacia el destino

      ; Verificación adicional para el movimiento
      let puede-moverse true

      ; Moverse para corre
      if comportamiento = "correr" [
        if not puede-moverse? 2 [
          girar-hasta-encontrar-ruta 2
        ]
        forward 2
      ]
      if comportamiento = "shock" and tipo = "mover" [
        set color yellow ; Representa el grito
        right 20 ; Gira sobre sí misma
      ]
      if comportamiento = "buscar-amigos" and tipo = "mover" [
        let amigo-cercano min-one-of other personas [distance myself]
        if amigo-cercano != nobody and puede-moverse? 1 [ ; Asegúrate de que el amigo cercano exista
          face amigo-cercano
          forward 1
        ]
      ]
      if comportamiento = "buscar-amigos" and tipo = "evacuar" [
        if puede-moverse? 1 [
          ifelse random-float 1 < 0.7 [ ; 70% de probabilidad de moverse hacia la salida
            forward 1
          ] [
            right random 45 ; Desvío aleatorio
            forward 1
          ]
        ]
      ]
      if comportamiento = "calmado" and puede-moverse? 0.5 [
        forward 0.5
      ]
      if comportamiento = "control" [
        ; Buscar una persona cercana en shock
        let persona-shock-cercana one-of personas in-radius 5 with [comportamiento = "shock"]
        if persona-shock-cercana != nobody [
          ; Cambiar el comportamiento de esa persona a "calmado"
          ask persona-shock-cercana [
            set comportamiento "calmado"
            set color color-segun-comportamiento comportamiento
          ]
          face persona-shock-cercana ; Se dirige hacia la persona en shock
        ]
        forward 1 ; Se mueve a una velocidad moderada
     ]
    ]
  ]
end

to girar-hasta-encontrar-ruta [steps]
  let intentos 0
  while [not puede-moverse? steps and intentos < 8] [
    right 45
    set intentos intentos + 1
  ]
end

to-report puede-moverse? [steps]
  let next-patch patch-ahead steps
  if next-patch != nobody [
    report [pcolor] of next-patch != white
  ]
  report false ; Si no hay un parche adelante, reportar false
end


to-report escoger-comportamiento [gen]
  let prob random-float 1.0
  let combinaciones []

  if gen = "H" [ ; Hombres
    set combinaciones [["correr" "buscar-amigos"] ["control" "calmado"]]
    if prob < 0.15 [ report item 0 combinaciones ]
    if prob >= 0.15 and prob < 0.3 [ report item 1 combinaciones ]
    if prob >= 0.3 and prob < 0.5 [ report "correr" ]
    if prob >= 0.5 and prob < 0.65 [ report "shock" ]
    if prob >= 0.65 and prob < 0.75 [ report "paralizado" ]
    if prob >= 0.75 and prob < 0.85 [ report "buscar-amigos" ]
    if prob >= 0.85 and prob < 0.95 [ report "control" ]
    report "calmado"
  ]

  if gen = "M" [ ; Mujeres
    set combinaciones [["shock" "paralizado"] ["calmado" "control"]]
    if prob < 0.15 [ report item 0 combinaciones ]
    if prob >= 0.15 and prob < 0.3 [ report item 1 combinaciones ]
    if prob >= 0.3 and prob < 0.5 [ report "calmado" ]
    if prob >= 0.5 and prob < 0.65 [ report "paralizado" ]
    if prob >= 0.65 and prob < 0.8 [ report "shock" ]
    if prob >= 0.8 and prob < 0.9 [ report "buscar-amigos" ]
    if prob >= 0.9 and prob < 0.95 [ report "control" ]
    report "correr"
  ]
end

to-report color-segun-comportamiento [comp]
  if comp = "correr" [ report red ]
  if comp = "shock" [ report lime ]
  if comp = "paralizado" [ report sky ]
  if comp = "buscar-amigos" [ report magenta ]
  if comp = "control" [ report pink ]
  report violet
end

to interaccion-shock
  ask personas with [comportamiento = "shock"] [
    let personas-afectadas personas in-radius 5
    ask personas-afectadas [
      if comportamiento = "calmado" [
        if random-float 1 < 0.5 [ ; 50% de probabilidad de empezar a correr
          set comportamiento "correr"
          set color color-segun-comportamiento comportamiento
        ]
      ]
    ]
  ]
end

to interaccion-buscar-amigos
  ask personas with [comportamiento = "buscar-amigos"] [
    let amigo-cercano min-one-of other personas with [comportamiento = "buscar-amigos"] [distance myself]
    if amigo-cercano != nobody and distance amigo-cercano < 3 [ ; Asegúrate de que el amigo cercano exista y está a menos de 3 unidades de distancia
      set comportamiento "calmado"
      set color color-segun-comportamiento comportamiento
      let salon-actual [plabel] of patch-here ; Obtener el nombre del salón en el que se encuentra la tortuga
      set carrera escoger-carrera salon-actual ; Ajustar la carrera según el salón
      ask amigo-cercano [
        set comportamiento "calmado"
        set color color-segun-comportamiento comportamiento
        ; No es necesario cambiar la carrera del amigo porque ya está en el mismo salón
      ]
    ]
  ]
end

to setup-salidas
  ask patches with [(pxcor = min-pxcor) or (pxcor = max-pxcor) or (pycor = min-pycor) or (pycor = max-pycor)] [
    set pcolor 8 ; Las salidas de emergencia se representarán con el color gris
  ]
end

to agrupar-estudiantes
  ask personas [
    let amigos-cercanos other personas with [carrera = [carrera] of myself] in-radius 5
    if any? amigos-cercanos [
      let amigo-cercano one-of amigos-cercanos
      face amigo-cercano
    ]
  ]
end

to comportamiento-ascensor
  ; Si el ascensor se detiene, las personas dentro intentarán salir
  ask patches with [pcolor = 27] [
    let personas-cercanas personas in-radius 2
    ask personas-cercanas [
      set comportamiento "paralizado"
    ]
  ]
end

to etiquetar-personas
  ask personas [
    set label-color white
    set label (word genero"|"comportamiento"|"carrera)
  ]
end

to-report obtener-hora
  if prob-salon <= 0.10 [
    report "2:05 PM"
  ]
  if prob-salon > 0.10 and prob-salon <= 0.20 [
    report "2:10 PM"
  ]
  if prob-salon > 0.20 and prob-salon <= 0.40 [
    report "2:30 PM"
  ]
  if prob-salon > 0.40 and prob-salon <= 0.60 [
    report "4:00 PM"
  ]
  if prob-salon > 0.60 and prob-salon <= 0.90 [
    report "3:30 PM"
  ]
  if prob-salon > 0.90 [
    report "3:40 PM"
  ]
end

to reportar-tortugas-por-salon
  let aula206 count turtles-on patches with [pcolor = 57 and pxcor = 2 and pycor = 10]
  let aula205 count turtles-on patches with [pcolor = 57 and pxcor = 16 and pycor = 10]
  let aula204 count turtles-on patches with [pcolor = 57 and pxcor = 26 and pycor = 10]
  let aula201 count turtles-on patches with [pcolor = 57 and pxcor = -10 and pycor = -10]
  let aula202 count turtles-on patches with [pcolor = 57 and pxcor = 5 and pycor = -10]
  let aula203 count turtles-on patches with [pcolor = 57 and pxcor = 16 and pycor = -10]

  print (word "Aula 206: " aula206)
  print (word "Aula 205: " aula205)
  print (word "Aula 204: " aula204)
  print (word "Aula 201: " aula201)
  print (word "Aula 202: " aula202)
  print (word "Aula 203: " aula203)
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
1104
469
-1
-1
13.64
1
10
1
1
1
0
0
0
1
-32
32
-16
16
0
0
1
ticks
30.0

BUTTON
1125
21
1188
54
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1126
62
1189
95
NIL
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1316
57
1421
102
Evacuados
contador
17
1
11

PLOT
1125
107
1510
339
Perrsonas x comportamiento
Personas
Comportamientos
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"Correr" 1.0 0 -16777216 true "" "plot contador-correr"
"Shock" 1.0 0 -7500403 true "" "plot contador-shock"
"Buscar amigos" 1.0 0 -2674135 true "" "plot contador-buscar-amigos"
"Calma" 1.0 0 -955883 true "" "plot contador-calmado"

PLOT
1126
360
1512
598
Evacuados X Genero
Evacuados
Genero
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"Hombres" 1.0 0 -16777216 true "" "plot contador-H"
"Mujeres" 1.0 0 -7500403 true "" "plot contador-M"

SLIDER
1203
21
1421
54
prob-salon
prob-salon
0
1
0.3
0.1
1
%
HORIZONTAL

MONITOR
1204
57
1304
102
Hora
obtener-hora
17
1
11

MONITOR
212
490
340
535
206
turtles-on patches with [pxcor > -5 and pxcor < 8 and pycor > 5 and pycor < 15]
17
1
11

MONITOR
347
490
476
535
205
turtles-on patches with [pxcor > 8 and pxcor < 20 and pycor > 5 and pycor < 15]
17
1
11

MONITOR
482
490
609
535
204
turtles-on patches with [pxcor > 20 and pxcor < 32 and pycor > 5 and pycor < 15]
17
1
11

MONITOR
214
611
342
656
201
turtles-on patches with [pxcor > -15 and pxcor < -2 and pycor > -15 and pycor < -5]
17
1
11

MONITOR
350
612
478
657
202
turtles-on patches with [pxcor > -2 and pxcor < 10 and pycor > -15 and pycor < -5]
17
1
11

MONITOR
485
611
612
656
203
turtles-on patches with [pxcor > 10 and pxcor < 22 and pycor > -15 and pycor < -5]
17
1
11

MONITOR
246
550
576
595
Pasillo
turtles-on patches with [pxcor > -30 and pxcor < 32 and pycor > -5 and pycor < 5]
17
1
11

@#$#@#$#@
Definiciones
Razas (Breeds)

    personas: Representa individuos en el modelo. Cada persona tiene atributos propios que determinan su comportamiento y características.

Variables Globales

    contador-correr: Contador de personas que corren.
    contador-shock: Contador de personas en shock.
    contador-paralizado: Contador de personas paralizadas.
    contador-buscar-amigos: Contador de personas buscando amigos.
    contador-calmado: Contador de personas calmadas.
    contador-H: Contador de hombres.
    contador-M: Contador de mujeres.
    contador: Contador general de personas.
    hora: Variable para representar la hora actual (aunque no se utiliza en el código proporcionado).

Variables Propias de personas

    genero: Género de la persona (Hombre - "H" o Mujer - "M").
    comportamiento: Describe el comportamiento actual de la persona (e.g., "correr", "shock", etc.).
    carrera: Carrera que estudia la persona (e.g., "sis", "ind").

Procedimientos
setup

Este procedimiento inicializa el modelo:

    Limpia el mundo y establece el entorno.
    Reinicia todos los contadores.
    Crea 200 tortugas (personas) en salones o pasillos basado en una probabilidad (prob-salon no está definido en el código proporcionado).
    Etiqueta a las personas con su género, comportamiento y carrera.
    Resetea el contador de ticks.

crear-tortuga-en [parches-posibles]

Crea una tortuga en una ubicación específica, basada en los parches-posibles proporcionados:

    Elige un parche aleatorio de los parches-posibles.
    Verifica si hay menos de 40 personas en ese parche.
    Crea una nueva persona en ese parche con ciertos atributos (forma, género, comportamiento, carrera, color).

escoger-carrera [salon]

Determina la carrera de una persona basada en el salon en el que se encuentra:

    Cada salón tiene una carrera predominante.
    Hay un 70% de probabilidad de que una persona elija la carrera predominante del salón.
    Si no elige la carrera predominante, elige una carrera alternativa.

setup-entorno

Establece el diseño del edificio en el mundo:

    Establece el color de fondo y define áreas específicas como pasillos, escaleras, ascensores, salones, baños, y puertas.

go

Define las acciones que ocurren en cada tick:

    Las personas se mueven o evacuan dependiendo de su comportamiento y ubicación.
    Ocurren interacciones entre personas.
    Las personas se agrupan.
    Las personas interactúan con el ascensor.
    Si una persona llega a una salida, se actualizan los contadores y la persona es eliminada del modelo.
    Incrementa el contador de ticks.

Otros Procedimientos

El código también incluye procedimientos para:

    Mover o evacuar personas basado en su comportamiento (mover-o-evacuar).
    Elegir un comportamiento para una persona (escoger-comportamiento).
    Interacciones entre personas cuando están en shock (interaccion-shock).
    Interacciones entre personas buscando amigos (interaccion-buscar-amigos).
    Etiquetar a las personas con su género, comportamiento y carrera (etiquetar-personas).
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.3.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
