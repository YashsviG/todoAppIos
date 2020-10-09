//
//  TodoViewController.swift
//  todoAppYashi
//
//  Created by user181154 on 10/7/20.
//

import UIKit
protocol TodoViewControllerDelegate: AnyObject{
    func todoViewController(_ vc: TodoViewController, didSaveTodo: Todo)
}

class TodoViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var todo: Todo?
    
    weak var delegate: TodoViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.text = todo?.title
    }


    @IBAction func save(_ sender: Any) {
        let todo = Todo(title: textField.text!)
        delegate?.todoViewController(self, didSaveTodo: todo)
    }
}
