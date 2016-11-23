# Шаблонизатор Mustache, рендер на разных языках

Результаты скорости рендера в миллисекундах, для 3-х разных шаблонов, количество прогонов 1М.

<table>

<tr>
<th>Данные</th>
<th>Erlang/bbmustache</th>
<th>Erlang/fast</th>
<th>Go</th>
<th>Scala</th>
<th>OCaml</th>
</tr>

<tr>
<td>Шаблон 1</td>
<td>63,329</td>
<td>33,649</td>
<td>35,620</td>
<td>80,622</td>
<td>19,541</td>
</tr>

<tr>
<td>Шаблон 2</td>
<td>21,738</td>
<td>8,330</td>
<td>11,600</td>
<td>17,357</td>
<td>5,865</td>
</tr>

<tr>
<td>Шаблон 3</td>
<td>35,642</td>
<td>12,442</td>
<td>16,188</td>
<td>33,220</td>
<td>9,034</td>
</tr>

</table>



##  Шаблоны

[template 1](data/template1.html) -- 65 строк, 5020 байт, только переменные

[template 2](data/template2.html) -- 11 строк, 383 байта, только переменные

[template 3](data/template3.html) -- 20 строк, 207 байт, с конструкциями if, loop etc


## Erlang

Первая реализация *Erlang/bbmustache* использует библиотеку bbmustache https://github.com/soranoba/bbmustache

- Erlang/OTP 18 erts-7.1
- bbmustache, "1.0.4"

[mustache_bm.erl](erl_bbmustache/src/mustache_bm.erl)

Вторая реализация *Erlang/fast* использует простую функцию на основне binary:split, которая умеет заменять переменные в шаблоне.

[mustache_bm.erl](erl_fast/src/mustache_bm2.erl)


## Go

go1.3.3 linux/amd64

https://github.com/cbroglie/mustache (в соответствии с традициями Go -- неизвестной версии.
Коммит 6857e4b493bdb8d4b1931446eb41704aeb4c28cb на момент теста)

Тесты, конечно, на скомпилированном бинарнике, не в интерпретаторе.

[mustache_bm.go](go_mustache/src/mbm/mustache_bm.go)

Пробовал еще 3 либы:
- https://github.com/aymerick/raymond -- эта либа очень медленная
- https://github.com/ChrisBuchholz/gostache -- не работает с мапами, требует специфичных биндингов
- https://github.com/alexkappa/mustache -- очень медленная


## Scala

Сперва взял библиотеку Scalate

- scala 2.10.6
- "org.fusesource.scalate" %% "scalate-core" % "1.6.1"
- https://github.com/scalate/scalate

Реализация компилирует шаблон в scala-код перед использованием, что для нашего случая плохо.

[MustacheBM.scala](scala_scalate/src/main/scala/MustacheBM.scala)

В итоге оказалось, что работает это жутко медленно:
- 10 рендеров -- 3970 мс
- 100 рендеров -- 19254 мс

Я не особо удивлен, ибо scala-компилятор известен своей медлительностью.
Вместо того, чтобы делать для нас полезное дело, scala все это время сама себя компилирует )


Попробовал другую библиотеку: https://github.com/vspy/scala-mustache

Неизвестной надежности либа, ее надо проверять, тестить.

[MustacheBM.scala](scala_mustache/src/main/scala/MustacheBM.scala)

Результаты получились сравнимые с другими языками.


## OCaml

- Ocaml 4.02.1
- ezjsonm 0.4.1
- mustache 1.0.1 https://github.com/rgrinberg/ocaml-mustache

Тесты на скомпилированном в нативный код бинарнике.

[mustache_bm.ml](ocaml_mustache/src/mustache_bm.ml)

Библиотека генерирует ошибку, если в биндинге нет значения для переменной в шаблоне.
Возможно это настраивается.


## Выводы

На маленьких шаблонах OCaml самый быстрый, Go в 2 раза медленее, Erlang в 4 раза медленее. На больших шаблонах все они показывают близкий результат. Примитивный fast-шаблонизатор на эрланг по скорости сопоставим с Go. Это не замена нормальному шаблонизатору, но подойдет для многих случаев.

Scala сопоставима с эрланг на маленьких шаблонах, но сильно проигрывает на больших.

Эрланг не такой уж и медленный. Конкретно на этой задаче работает быстро.
