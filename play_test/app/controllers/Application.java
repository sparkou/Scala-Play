package controllers;

import models.UserModel;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;
import views.html.index;

import com.fasterxml.jackson.databind.JsonNode;

public class Application extends Controller {

    public static Result index() {
    	
    	String username = request().getQueryString("exampleInputEmail1");
    	String password = request().getQueryString("exampleInputPassword1");
    	UserModel user = new UserModel();
    	user.setUsername(username);
    	user.setPassword(password);
    	
    	JsonNode json = Json.toJson(user);
        return ok(index.render(json.toString())); 
    }
    
    
}
