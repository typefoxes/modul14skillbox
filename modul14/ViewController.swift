

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBAction func saveButton(_ sender: Any) {
        
        Persistance.shared.userLastName = lastnameTextfield.text
        Persistance.shared.userName = nameTextfield.text
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastnameTextfield.text = Persistance.shared.userLastName
        nameTextfield.text = Persistance.shared.userName
        
    }


}

