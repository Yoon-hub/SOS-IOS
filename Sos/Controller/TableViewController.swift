//
//  TableViewController.swift
//  Sos
//
//  Created by 최윤제 on 2022/03/31.
//

import UIKit

var contact: [Contact] = [
    Contact(relationship: "엄마", number: "01022224444"),
    Contact(relationship: "아빠", number: "01044447777")
]


class TableViewController: UITableViewController {

    @IBOutlet var tableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didDismissPostCommentNotification(_:)), name: DidDismissPostCommentViewController, object: nil)
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTable")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTable", for: indexPath) as! TableViewCell //
        
        cell.reationLabel.text = contact[indexPath.row].relationship
        cell.phoneNumberLabel.text = String(contact[indexPath.row].number)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contact.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contact.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert{
            
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "삭제"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        tableVIew.reloadData()
//    }
    
    @objc func didDismissPostCommentNotification(_ noti: Notification) {
      // 이 부분을 해주어야 다시 comment들을 api로 가져올 수 있었다.
      // 즉, reload할 데이터를 불러와야 바뀌는 게 있다는 의미다.
        OperationQueue.main.addOperation { // DispatchQueue도 가능.
            self.tableView.reloadData()
        }

    }
    
}
