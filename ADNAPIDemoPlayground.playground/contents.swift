// Playground - noun: a place where people can play

import Cocoa
import XCPlayground

let urlString = "https://api.app.net/" + "posts/stream/global"

let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

let urlRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
urlRequest.HTTPMethod = "GET"
urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

/*:
# Create a sesseion


*/
let sessionTask = session.dataTaskWithRequest(urlRequest) { (data, response, error) -> () in
    
    let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
    
    var jsonError: NSError? = nil
    let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
    //    println("dictionary: \(dictionary)")
    let data = dictionary["data"] as! [AnyObject]
    //    println("data: \(data)")
    for post in data {
        //        println("post: \(post)")
        if let text = post["text"] as? String, user = post["user"] as? [String:AnyObject], username = user["username"] as? String {
            println("*** @\(username) **********")
            println("\(text)\n\n")
        }
    }
}

XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)

sessionTask.resume()
