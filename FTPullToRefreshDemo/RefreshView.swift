//
//  RefreshView.swift
//  FTPullToRefreshDemo
//
//  Created by luckytantanfu on 15/11/2.
//  Copyright © 2015年 futantan. All rights reserved.
//

import UIKit

protocol RefreshViewDelegate {
  func refreshViewDidRefresh(refreshView: RefreshView)
}

class RefreshView: UIView {
  var progress: CGFloat = 0.0
  var isRefreshing: Bool = false
  var delegate: RefreshViewDelegate?
  
  unowned var scrollView: UIScrollView
  
  init(frame: CGRect, scrollView: UIScrollView) {
    self.scrollView = scrollView
    super.init(frame: frame)
    self.backgroundColor = UIColor.greenColor()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func animateWithProgress(progress: CGFloat) {
    print("animate... with progress")
  }
  
  // 触发刷新条件，例如访问服务器时的动画
  func animateWhileRefreshing() {
    isRefreshing = true
    print("animate... while refreshing")
  }
  
  // 当刷新工作完成之后调用
  func endRefreshing() {
    isRefreshing = false
    shouldRefreshViewBeLocked(false)
  }
  
  func shouldRefreshViewBeLocked(shouldLock: Bool) {
    var contentInset = self.scrollView.contentInset
    contentInset.top = shouldLock ?
      (contentInset.top + self.frame.size.height) : (contentInset.top - self.frame.size.height)
    self.scrollView.contentInset = contentInset
  }
  
}

// MARK: - UIScrollViewDelegate

extension RefreshView: UIScrollViewDelegate {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    // 计算向下滑动了多少距离
    let offsetY = max(-(scrollView.contentOffset.y + scrollView.contentInset.top), 0.0)
    self.progress = min(offsetY / frame.size.height, 1.0)
    
    if !isRefreshing {
      animateWithProgress(progress)
    }
  }
  
  func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    if !isRefreshing && self.progress == 1.0 {
      delegate?.refreshViewDidRefresh(self)
      animateWhileRefreshing()
      shouldRefreshViewBeLocked(true)
    }
  }
}