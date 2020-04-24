//
//  NavBar.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 21/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

protocol NavBarDelegate {
    func signOutPressed()
}


class NavBar: UIView {
    @IBOutlet var signOutButton: UIButton!
    var ifSignOutClicked = false
    
    var delegate : NavBarDelegate?
        
    class func instanceFromNib() -> NavBar {
        return UINib(nibName: "NavBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NavBar
    }
    
    @IBAction func signOut() {
//        delegate?.signOutPressed()
    }
    
    func signOutPressed() {
//        delegate?.signOutPressed()
    }
   
}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
