import scala.io.Source
import org.json4s.native.JsonMethods._
import org.fusesource.scalate.{Binding, TemplateEngine}

object MustacheBM {
  def main(args: Array[String]): Unit = {
    val dataFile = args(0)
    val bindingsFile = args(1)
    val numTests = args(2).toInt
    println(s"do_test $dataFile, $bindingsFile, $numTests")

    val path = "../data/"
    val data = Source.fromFile(path + dataFile).mkString
    val bindingsStr = Source.fromFile(path + bindingsFile).mkString
    val bindings = parse(bindingsStr)

    // TODO need to convert JObject to Map
    val bindings2 = Map(
      "title" -> "Some title",
      "txt1" -> "Some txt",
      "txt2" -> "Some txt",
      "txt3" -> "Some txt",
      "title" -> "Hello",
      "image_url" -> "some image url",
      "icon_url" -> "some icon url",
      "short_description" -> "show bla-bla-bla",
      "detail_description" -> "detail bla-bla-bla-bla-bla",
      "offer_id" -> "42",
      "name" -> "Chris",
      "age" -> "25",
      "company" -> "<b>GitHub</b>",
      "person" -> "false"
    )

    val t1 = System.currentTimeMillis
    for( a <- 1 to numTests) {
      val engine = new TemplateEngine
      val template = engine.compileMoustache(data) // extremely slow
      val output = engine.layout("some", template, bindings2)
    }
    val t2 = System.currentTimeMillis
    println(t2 - t1)
  }
}
