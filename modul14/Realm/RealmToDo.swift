

import UIKit
import RealmSwift

let realm = try! Realm()
var todoList: Results<TodoItem> {
    get { return realm.objects(TodoItem.self) }
}

class RealmToDo: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            let item = todoList[indexPath.row]
            cell.textLabel!.text = item.detail
            return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if (editingStyle == .delete){
            let item = todoList[indexPath.row]
            try! realm.write({ realm.delete(item) })
            tableView.deleteRows(at:[indexPath], with: .automatic)
        }
    }
    
    @IBAction func addTask(_ sender: Any) {
        let alertController : UIAlertController = UIAlertController(title: "New Todo", message: "Что мы задумали?", preferredStyle: .alert)
        alertController.addTextField { (UITextField) in }
   
        let action_cancel = UIAlertAction.init(title: "Отмена", style: .cancel) { (UIAlertAction) -> Void in }
         alertController.addAction(action_cancel)

        let action_add = UIAlertAction.init(title: "Добавить", style: .default) { (UIAlertAction) -> Void in
        let textField_todo = (alertController.textFields?.first)! as UITextField
        let todoItem = TodoItem()
            todoItem.detail = textField_todo.text!
            todoItem.status = 0

            try! realm.write({ 
                realm.add(todoItem)
                self.tableView.insertRows(at: [IndexPath.init(row: todoList.count-1, section: 0)], with: .automatic) })
         }
        
         alertController.addAction(action_add)
         present(alertController, animated: true, completion: nil)
     }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

