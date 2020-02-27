
import UIKit

class Model: NSObject {

    /* Local Variable */
    var title : String?
    var json2 : [JSON] = [JSON]()
 
    init(jsonObject json : JSON)
    {
        self.json2 = json["stationBeanList"].arrayValue
        self.title = json["executionTime"].stringValue
        
        print(self.json2)
        print(self.title!)
    }
    
    static var loginData : Model?
    
}
