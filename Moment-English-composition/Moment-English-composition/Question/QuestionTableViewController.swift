//
//  QuestionTableViewController.swift
//  Moment-English-composition
//
//  Created by 信次　智史 on 2019/03/30.
//  Copyright © 2019 stoshi nobutsugu. All rights reserved.
//

import Foundation
import UIKit

class QutestionTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // cellの識別子
    let cellIdentifier = "quesionCell"
    var list:[String] = ["1","2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // セルの表示件数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    // セルの表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.text = list[indexPath.row]
        return cell!
    }
    
    // セルが押下された時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuestionVC")
        vc.title = list[indexPath.row]
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
