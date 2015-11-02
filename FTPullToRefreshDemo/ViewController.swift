//
//  ViewController.swift
//  FTPullToRefreshDemo
//
//  Created by luckytantanfu on 15/11/2.
//  Copyright © 2015年 futantan. All rights reserved.
//

import UIKit

private let ReusableCellIdentifier = "Cell"

class ViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

}

// MARK: - UITableViewDataSource

extension ViewController {
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(ReusableCellIdentifier, forIndexPath: indexPath)
    cell.textLabel?.text = "item \(indexPath.row)"
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension ViewController {
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}