
import UIKit
import CoreData

class CoreData: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tasks: [Tasks] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButton(_ sender: Any) {
        let alertController : UIAlertController = UIAlertController(title: "Новая задача", message: "Что мы задумали?", preferredStyle: .alert)
       
        let action_add = UIAlertAction(title: "Добавить", style: .default) { action in
        let textField_todo = alertController.textFields?.first
            if let newTask = textField_todo?.text {
                self.saveTask(withTitle: newTask)
                self.tableView.reloadData()
            }
        }
            alertController.addTextField { _ in }
            
            let action_cancel = UIAlertAction(title: "Отмена", style: .cancel) { _ in }
            
            alertController.addAction(action_cancel)
            alertController.addAction(action_add)
            
            present( alertController, animated: true, completion: nil)
        }
    
    func saveTask(withTitle title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: context) else { return }
        let taskObject = Tasks(entity: entity, insertInto: context)
        taskObject.title = title
        
        do {
            try context.save()
            tasks.append(taskObject)
        } catch let error as NSError{ print(error.localizedDescription) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        do { tasks = try context.fetch(fetchRequest)
            
        } catch let error as NSError { print(error.localizedDescription) }
            
    }
 
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        if (editingStyle == .delete){
        let item = tasks[indexPath.row]
        if let tasks = try? context.fetch(fetchRequest) {
            context.delete(item)}
            tableView.reloadData()
        }
        do { try context.save() }
        catch let error as NSError { print(error.localizedDescription) }
    }
    @IBOutlet weak var tableView: UITableView!
}



