
import UIKit

class SecondVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //MARK: - Variable Declaration
    
    /* TableView */
    @IBOutlet weak var tblView: UITableView!
    
    /* Label */
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text! = (Model.loginData?.title)!
        
        tblView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  (Model.loginData?.json2.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DetailCell! = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as? DetailCell
        
        cell.lblTitle.text = Model.loginData?.json2[indexPath.row]["stationName"].stringValue
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
