//
//  ViewController.swift
//  todoAppYashi
//
//  Created by user181154 on 10/5/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var todos =
        [
            Todo(title: "Do all the COMP4977 Assignments by Saturday"),
            Todo(title: "Do BLAW Quiz after lecture on Tuesday"),
            Todo(title: "Enjoy Kim's Convenience after that!"),

        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBSegueAction func todoViewController(_ coder: NSCoder) -> TodoViewController? {
        let vc =  TodoViewController(coder: coder)
        if let indexPath = tableView.indexPathForSelectedRow{
            let todo = todos[indexPath.row]
            vc!.todo = todo
        }
        vc?.delegate = self
        return vc
    }
    @IBAction func startEditing(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todos.remove(at: sourceIndexPath.row)
        todos.insert(todo, at: destinationIndexPath.row)
    }

}

extension ViewController: UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "checked cell", for: indexPath) as! CheckTableViewCell
        cell.delegate = self
        let todo = todos[indexPath.row]
        
//        let cell = CheckTableViewCell()
        
        cell.set(title: todo.title, checked: todo.isComplete)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Done"){
            action, view, complete in
            let todo = self.todos[indexPath.row].completeToggled()
            self.todos[indexPath.row] = todo
            let cell = tableView.cellForRow(at: indexPath) as! CheckTableViewCell
            cell.set(checked: todo.isComplete)
            
            complete(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
        
}

extension ViewController: CheckTableViewCellDelegate{
    func checkTableViewCell(_ cell: CheckTableViewCell, didChangeCheckedState checked: Bool) {
        guard let indexPath =  tableView.indexPath(for: cell) else{
            return
        }
        let todo = todos[indexPath.row]
        let newTodo = Todo(title: todo.title, isComplete: checked)
        todos[indexPath.row] = newTodo
    }
}

extension ViewController: TodoViewControllerDelegate{
    func todoViewController(_ vc: TodoViewController, didSaveTodo todo: Todo) {
        
        
        
        dismiss(animated: true){ [self] in
            
            if let indexPath = self.tableView.indexPathForSelectedRow{
                self.todos[indexPath.row] = todo
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }else{
                self.todos.append(todo)
                self.tableView.insertRows(at: [IndexPath(row: todos.count-1, section: 0)], with: .automatic)
            }
        }
    }
    
}
