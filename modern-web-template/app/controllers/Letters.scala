package controllers

import com.google.inject.Singleton
import org.slf4j.{LoggerFactory, Logger}
import play.api.libs.json.{JsArray, Json}
import play.api.mvc.{Action, Controller}
import play.modules.reactivemongo.MongoController
import play.modules.reactivemongo.json.collection.JSONCollection
import play.api.libs.concurrent.Execution.Implicits.defaultContext
import reactivemongo.api.Cursor

import scala.concurrent.Future

/**
 * Created by spark.ou on 6/11/2015.
 */
@Singleton
class Letters extends Controller with MongoController{

  private  final val logger: Logger = LoggerFactory.getLogger(classOf[Letters])

  def collection: JSONCollection = db.collection[JSONCollection]("letters")

  import models.Letter
  import models.JsonFormats1._

  def createLetter = Action.async(parse.json) {
    request =>
      request.body.validate[Letter].map {
        letter =>
          collection.insert(letter).map {
            lastError =>
              logger.debug(s"Successfully inserted with LastError: $lastError")
              Created(s"Letter Created")
          }
      }.getOrElse(Future.successful(BadRequest("invalid json")))
  }
//    def createLetter = Action.async {
//      val letter = Letter("1", "2", "3","4")
//      // insert the user
//      val futureResult = collection.insert(letter)
//      // when the insert is performed, send a OK 200 result
//      futureResult.map(_ => Ok)
//    }
  def deleteLetter(firstLine: String, middleLine: String, lastLine: String) = Action.async(parse.json) {
    request =>
      request.body.validate[Letter].map {
        letter =>
          val nameSelector = Json.obj("firstLine" -> firstLine, "middleLine" -> middleLine, "lastLine" -> lastLine)
          collection.remove(nameSelector,null, true).map {
              lastError =>
                logger.debug(s"Successfully deleted with LastError: $lastError")
                Created(s"Letter Deleted")
          }
      }.getOrElse(Future.successful(BadRequest("invalid json")))
//      Redirect(routes.Letters.findLetters())
  }

//  def updateUser(firstName: String, lastName: String) = Action.async(parse.json) {
//    request =>
//      request.body.validate[User].map {
//        user =>
//          // find our user by first name and last name
//          val nameSelector = Json.obj("firstName" -> firstName, "lastName" -> lastName)
//          collection.update(nameSelector, user).map {
//            lastError =>
//              logger.debug(s"Successfully updated with LastError: $lastError")
//              Created(s"User Updated")
//          }
//      }.getOrElse(Future.successful(BadRequest("invalid json")))
//  }
//
  def findLetters = Action.async {
    // let's do our query
    val cursor: Cursor[Letter] = collection.
      // find all
      find(Json.obj("firstLine" -> "2")).
      // sort them by creation date
      sort(Json.obj("firstLine" -> -1)).
      // perform the query and get a cursor of JsObject
      cursor[Letter]

    // gather all the JsObjects in a list
    val futureUsersList: Future[List[Letter]] = cursor.collect[List]()

    // transform the list into a JsArray
    val futurePersonsJsonArray: Future[JsArray] = futureUsersList.map { letters =>
      Json.arr(letters)
    }
    // everything's ok! Let's reply with the array
    futurePersonsJsonArray.map {
      letters =>
        Ok(letters(0))
//        Ok(views.html.index())
    }
  }
}
