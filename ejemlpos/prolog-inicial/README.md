# How to use?

## ArchLinux
instale swi-prolog, y ejecute cada uno de los script con la siguiente estructura:

```bash
swipl ancestro.pl
```

## Para ver el flujo

Pra ver el flujo de comprobaciones (la profesora dijo algo de un árbol, pero no entendí bien) ejecute el programa y anexe el comando ```trace```.

## Preguntas

### Adora

¿Qué animales están definidos?

```prolog

?- animal(X).
```

¿Qué pájaros están definidos?

```prolog
?- pajaro(X).
```

¿Qué gatos están definidos?

```prolog
?- gato(X).
```

¿Qué chanchos están definidos?

```prolog
?- chancho(X).
```

¿Qué animales adora María?

```prolog
?- adora(maria, X).
```

¿María adora a Silvestre?

```prolog
?- adora(maria, silvestre).
```

¿María adora a algún gato?

```prolog
?- adora(maria, X), gato(X).
```

¿Hay algún animal que no sea ni pájaro, ni gato, ni chancho?

```prolog
?- animal(X), not(pajaro(X)), not(gato(X)), not(chancho(X)).
```

### alivia

¿Quién padece gripe?

```prolog
padece(gripe, Persona).
```

¿Qué enfermedades padece Pedro?

```prolog
padece(Enfermedad, pedro).
```

¿Qué síntomas presenta María?

```prolog
presenta(Sintoma, maria).
```

¿Qué fármaco suprime la fiebre?

```prolog
suprime(fiebre, Farmaco).
```

¿Qué enfermedades tienen cansancio como síntoma?

```prolog
sintoma(Enfermedad, cansancio).
```

¿Qué fármaco se debe formular para Carlos?

```prolog
formula(Farmaco, carlos).
```

¿Quiénes padecen una enfermedad que tiene cansancio como síntoma?

```prolog
padece(Enfermedad, Persona), sintoma(Enfermedad, cansancio).
```

¿Qué fármacos se pueden utilizar para aliviar la hepatitis?

```prolog
alivia(hepatitis, Farmaco).
```

¿Qué síntomas presenta alguien que padece intoxicación?

```prolog
    presenta(Sintoma, Persona), padece(intoxicacion, Persona).
```

¿Qué enfermedades padecen tanto Pedro como Juan?

```prolog
padece(Enfermedad, pedro), padece(Enfermedad, juan).
```

### familia

Consultar los Padres: ¿Quién es el padre o la madre de una persona en particular?

```prolog
padre(Padre, juan).
madre(Madre, maria).
```

Consultar Hermanos: ¿Quiénes son los hermanos de una persona en particular?

```prolog
hermano(Hermano, alberto).
```

Consultar Tíos y Tías: ¿Quiénes son los tíos o tías de una persona en particular?

```prolog
tia(Tia, lucas).
tio(Tio, ana).
```

Consultar Esposos: ¿Quién es el esposo o la esposa de una persona en particular?

```prolog
esposo(Esposo, flor).
esposa(Esposa, jose).
```

Consultar Cuñadas: ¿Quiénes son las cuñadas de una persona en particular?

```prolog
cunada(Cunada, miguel).
```

Consultar Ancestros: ¿Quiénes son los ancestros de una persona en particular?

```prolog
ancestro(Ancestro, pedro).
```

Consultar Descendientes: ¿Quiénes son los descendientes de una persona en particular?

```prolog
ancestro(maria, Descendiente).
```

Consultar Relaciones Complejas: ¿Quiénes son los hermanos de los tíos de una persona en particular?

```prolog
tio(Tio, juan), hermano(Hermano, Tio).
```

Consultar Género: ¿Quiénes son los hombres o mujeres en la familia?

```prolog
hombre(Hombre).
mujer(Mujer).
```

Consultar Relaciones Matrimoniales: ¿Quiénes son las parejas casadas en la familia?

```prolog
esposo(Esposo, Esposa).
```

### horóscopo

Consultar el Signo de una Fecha Específica: Puedes preguntar qué signo corresponde a una fecha de nacimiento específica.

```prolog
?- signo(15, 5, Signo).
```

Consultar las Fechas de un Signo Específico: Puedes preguntar cuál es el rango de fechas para un signo específico.

```prolog
?- horoscopo(geminis, DiaIni, MesIni, DiaFin, MesFin).
```

Consultar Todos los Signos: Puedes preguntar por todos los signos y sus respectivos rangos de fechas.

```prolog
?- horoscopo(Signo, DiaIni, MesIni, DiaFin, MesFin).
```

Consultar la Transición entre Signos: Puedes preguntar qué signo sigue inmediatamente después de otro, basándote en las fechas.

```prolog
?- horoscopo(Signo1, _, _, 21, Mes), horoscopo(Signo2, 21, Mes, _, _).
```

Consultar la Validez de una Fecha: Puedes preguntar si una fecha dada es válida dentro de los rangos de fechas definidos para los signos.

```prolog
?- signo(Dia, Mes, _).
```

Consultar Signos para Fechas Límite: Puedes preguntar qué signos corresponden a las fechas límite, como el primer o último día de un mes.

```prolog
?- signo(21, Mes, Signo).
```

Errores y cosas interesantes, 30 de febrero, 21 de marzo, 32 de agosto; Se deben añadir clausulas para cada mes.
