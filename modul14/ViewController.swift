

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    
    @IBAction func saveItButton(_ sender: UIButton) {
        view.endEditing(true)
        Persistance.shared.userLastName = lastnameTextfield.text
        Persistance.shared.userName = nameTextfield.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HideKeyboard()
        lastnameTextfield.text = Persistance.shared.userLastName
        nameTextfield.text = Persistance.shared.userName
        
    }
    
    func HideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
        }
    }
    


