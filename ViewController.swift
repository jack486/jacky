
import UIKit
import Alamofire

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapGet(_ sender: UIButton) {
        
        print("GET")
        
        //let url = "https://jsonplaceholder.typicode.com/todos/1"
        
        let url = "https://feeds.citibikenyc.com/stations/stations.json"
        
        /* Show Progress View */
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Alamofire.request(url).responseJSON { response in
            
            /* Hide Progress View */
            MBProgressHUD.hide(for: self.view, animated: true)
            
            // check for errors
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling GET")
                print(response.result.error!)
                return
            }
            
            // make sure we got some JSON since that's what we expect
            guard let json = response.result.value as? [String: Any] else {
                print("didn't get object as JSON from API")
                if let error = response.result.error {
                    print("Error: \(error)")
                }
                return
            }
            
            let jsonResponse = JSON(json)
            
            print(jsonResponse)
            
            let loginData = Model(jsonObject:jsonResponse)
            
            Model.loginData = loginData
        }
        
    }
    
    @IBAction func didTapPost(_ sender: UIButton) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SecondVC") as? SecondVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
        /* print("POST")
         
         let url = "URL"
         
         let para = ["KEY":"VALUE",
         "KEY":"VALUE"]
         
         var urlRequest = URLRequest(url: URL(string: url)!)
         urlRequest.httpMethod = HTTPMethod.post.rawValue
         let request = try! Alamofire.URLEncoding().encode(urlRequest as URLRequestConvertible, with: para)
         
         /* Show Progress View */
         MBProgressHUD.showAdded(to: self.view, animated: true)
         
         Alamofire.request(request).responseJSON { (response) in
         
         /* Hide Progress View */
         MBProgressHUD.hide(for: self.view, animated: true)
         
         guard response.result.error == nil else {
         // got an error in getting the data, need to handle it
         print("error calling POST")
         print(response.result.error!)
         return
         }
         // make sure we got some JSON since that's what we expect
         guard let json = response.result.value as? [String: Any] else {
         print("didn't get object as JSON from API")
         if let error = response.result.error {
         print("Error: \(error)")
         }
         return
         }
         
         let jsonResponse = JSON(json)
         
         print(jsonResponse)
         
         }*/
    }
    
    @IBAction func didTapUploadImage(_ sender: UIButton) {
        
        //https://stackoverflow.com/questions/40519829/upload-image-to-server-using-alamofire
        
        print("POST")
        
        let url = "API_URL"
        
        let para = ["KEY":"VALUE",
                    "KEY":"VALUE"]
        
        /* Show Progress View */
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
        hud.detailsLabel.text = "0%"
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(UIImageJPEGRepresentation(UIImage(named: "profile")!, 0.2)!, withName: "KEY",fileName: "profile.jpg", mimeType: "image/jpg")
            
            /* Optional for extra parameters */
            for (key, value) in para {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
        },to:url)
        { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                    
                    hud.detailsLabel.text = "\(progress.fractionCompleted * 100)%"
                })
                
                upload.responseJSON { response in
                    
                    /* Hide Progress View */
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    print(response.result.value as Any)
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
}

