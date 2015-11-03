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
  
  var refreshView: RefreshView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    addRefreshView()
  }
  
  // MARK: - Helper
  
  func addRefreshView() {
    let kRefreshViewHeight: CGFloat = 120.0
    let refreshFrame = CGRect(x: 0.0, y: -kRefreshViewHeight, width: CGRectGetWidth(view.frame), height: kRefreshViewHeight)
    refreshView = RefreshView(frame: refreshFrame, scrollView: tableView)
    refreshView.delegate = self
    view.addSubview(refreshView)
  }

}

// MARK: - UIScrollViewDelegate

extension ViewController {
  override func scrollViewDidScroll(scrollView: UIScrollView) {
    self.refreshView.scrollViewDidScroll(scrollView)
  }
  
  override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    refreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
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


// MARK: - RefreshViewDelegate

extension ViewController: RefreshViewDelegate {
  func refreshViewDidRefresh(refreshView: RefreshView) {
    print("搬砖3秒")
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(3*NSEC_PER_SEC))
    dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
      refreshView.endRefreshing()
    }
  }
}
