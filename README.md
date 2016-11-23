# Шаблонизатор Mustache, рендер на разных языках

Результаты скорости рендера в миллисекундах, для 3-х разных шаблонов, количество прогонов 1М.

### Без прекомпиляции шаблонов

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
<td>23,971</td>
<td>33,649</td>
<td>35,620</td>
<td>80,622</td>
<td>19,541</td>
</tr>

<tr>
<td>Шаблон 2</td>
<td>16,471</td>
<td>8,330</td>
<td>11,600</td>
<td>17,357</td>
<td>5,865</td>
</tr>

<tr>
<td>Шаблон 3</td>
<td>31,246</td>
<td>12,442</td>
<td>16,188</td>
<td>33,220</td>
<td>9,034</td>
</tr>

</table>


### С прекомпиляций шаблонов

<table>

<tr>
<th>Данные</th>
<th>Erlang/bbmustache</th>
<th>Erlang/erlydtl</th>
<th>Go</th>
<th>Scala/scalate</th>
<th>Scala/mustache</th>
<th>OCaml</th>
</tr>

<tr>
<td>Шаблон 1</td>
<td>1,814</td>
<td>29,495</td>
<td>19,406</td>
<td>11,156</td>
<td>5,646</td>
<td>1,007</td>
</tr>

<tr>
<td>Шаблон 2</td>
<td>2,525</td>
<td>7,293</td>
<td>7,545</td>
<td>6,250</td>
<td>3,482</td>
<td>1,452</td>
</tr>

<tr>
<td>Шаблон 3</td>
<td>2,265</td>
<td>x</td>
<td>9,854</td>
<td>4,947</td>
<td>3,965</td>
<td>2,269</td>
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

[mustache_bm2.erl](erl_fast/src/mustache_bm2.erl)

bbmustache с прекомпиляцией:
[mustache_pc_bm.erl](erl_bbmustache/src/mustache_pc_bm.erl)

Для bbmustache важно использовать опцию _{key\_type, string}_ (или не указывать опции, это будет по умолчанию). _{key\_type, binary}_ замедляет рендер, в некоторых случая существенно.

И для сравнения ErlyDTL https://github.com/erlydtl/erlydtl с прекомпиляцией:
[mustache_bm3.erl](erl_erlydtl/src/mustache_bm3.erl)
(Для 3-го шаблона тест не делался, т.к. он несовместим с DTL).

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

Вариант без прекомпиляции шаблона [MustacheBM.scala](scala_scalate/src/main/scala/MustacheBM.scala) работает жутко медленно:
- 10 рендеров -- 3970 мс
- 100 рендеров -- 19254 мс

Зато с прекомпиляцией [MustachePC_BM.scala](scala_scalate/src/main/scala/MustachePC_BM.scala) показывает хорошие результаты.

Попробовал другую библиотеку: https://github.com/vspy/scala-mustache

[MustacheBM.scala](scala_mustache/src/main/scala/MustacheBM.scala)
[MustachePC_BM.scala](scala_mustache/src/main/scala/MustachePC_BM.scala)

Результаты получились сравнимые с другими языками.


## OCaml

- Ocaml 4.02.1
- ezjsonm 0.4.1
- mustache 1.0.1 https://github.com/rgrinberg/ocaml-mustache

Тесты на скомпилированном в нативный код бинарнике.

[mustache_bm.ml](ocaml_mustache/src/mustache_bm.ml)
[mustache_pc_bm.ml](ocaml_mustache/src/mustache_pc_bm.ml)


Библиотека генерирует ошибку, если в биндинге нет значения для переменной в шаблоне.
Возможно это настраивается.


## Выводы

OCaml самый быстрый.

Erlang/bbmustache с прекомпиляцией работает не хуже OCaml. Без прекомпиляции хуже, но неплохо на фоне других языков.
