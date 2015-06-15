package models

/**
 * Created by spark.ou on 6/11/2015.
 */
case class Letter( firstLine: String,
               middleLine: String,
               lastLine: String,
               author: String)

object JsonFormats1 {
  import play.api.libs.json.Json

  // Generates Writes and Reads for Feed and User thanks to Json Macros
  implicit val letterFormat = Json.format[Letter]
}