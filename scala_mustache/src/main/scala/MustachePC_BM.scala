import mustache.Mustache
import org.json4s.JsonAST.JObject
import org.json4s.native.JsonMethods._

import scala.io.Source

object MustachePC_BM {
  def main(args: Array[String]): Unit = {
    val dataFile = args(0)
    val bindingsFile = args(1)
    val numTests = args(2).toInt
    println(s"do_test $dataFile, $bindingsFile, $numTests")

    val data = Source.fromFile(dataFile).mkString
    val bindingsStr = Source.fromFile(bindingsFile).mkString
    val bindings = parse(bindingsStr)
    // List(
    // (title,JString(What can RabbitMQ do for you?)),
    // (txt1,JString(RabbitMQ ships with an easy-to use management UI that allows you to monitor and control every aspect of your message broker. )),
    // (txt2,JString(RabbitMQ ships in a state where it can be used straight away in simple cases - just start the server and it's ready to go. If you have more complex needs you may need to adjust your server configuration.)),
    // (txt3,JString(These tutorials cover the basics of creating messaging applications using RabbitMQ. You need to have the RabbitMQ server installed to go through the tutorials, please see the installation guide. Code examples of these tutorials are open source, as is RabbitMQ website. ))))

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
    val template = new Mustache(data)

    val t1 = System.currentTimeMillis
    for( a <- 1 to numTests) {
      val res = template.render(bindings2)
    }
    val t2 = System.currentTimeMillis
    println(t2 - t1)
  }
}
