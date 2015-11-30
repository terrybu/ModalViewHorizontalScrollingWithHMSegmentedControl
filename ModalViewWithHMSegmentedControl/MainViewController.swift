//
//  MainViewController.swift
//  ModalViewWithHMSegmentedControl
//
//  Created by Terry Bu on 11/30/15.
//  Copyright © 2015 Terry Bu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var maskView : UIView!
    var modalVC : ModalViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction
    func modalStartButtonPressed(sender: UIButton) {
        modalVC = ModalViewController()
        modalVC.mainVC = self
        self.addChildViewController(modalVC)
        
        maskView = UIView(frame: self.view.frame)
        maskView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(maskView)
        
        let modalWidth = self.view.frame.width-40
        let modalHeight = self.view.frame.height-100
        modalVC.view.frame = CGRectMake(20, self.view.frame.height, modalWidth, modalHeight)
        self.view.addSubview(modalVC.view)
        modalVC.didMoveToParentViewController(self)
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.modalVC.view.frame = CGRectMake(20, 80, modalWidth, modalHeight)
            self.maskView.backgroundColor = UIColor.blackColor()
            self.maskView.alpha  = 0.60
            }) { (Bool finished) -> Void in
        }
    }
    
    //MARK: Modal related
    func closeAboutPIModal() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.modalVC.view.frame = CGRectMake(20, self.view.frame.height, self.view.frame.width-40, self.view.frame.height-100)
            self.maskView.backgroundColor = UIColor.clearColor()
            self.maskView.alpha = 1.0
            }) { (Bool finished) -> Void in
                self.modalVC.view.removeFromSuperview()
                self.modalVC.removeFromParentViewController()
                self.maskView.removeFromSuperview()
        }
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        let location = gestureRecognizer.locationInView(self.view)
        print("from navdrawer handleTap \(location)")
        if (location.y < self.modalVC.view.frame.origin.y) || (location.y > self.modalVC.view.frame.height + self.modalVC.view.frame.origin.y) || (location.x > self.modalVC.view.frame.width + self.modalVC.view.frame.origin.x) || (location.x < self.modalVC.view.frame.origin.x) {
            closeAboutPIModal()
        }
    }
    
}
