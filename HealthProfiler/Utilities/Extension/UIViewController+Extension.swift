//
//  UIViewController+Extension.swift
//  HealthProfiler
//

import Foundation
import UIKit

extension UIViewController {
    
    static func nibInstance() -> Self {
        
        let nibName = self.className
        
        guard let _ = Bundle.main.path(forResource: nibName, ofType: "nib") else {
            fatalError("Could not load nib with name: \(className)")
        }
        
        return self.init(nibName: nibName, bundle: nil)
    }
    
    //MARK: - Register custom table cell -
    func registerTableCellAndNib(_ tableView: UITableView!, tableCellClass: AnyClass!, cellID: String!, nibName: String!) {
        
        tableView.register(tableCellClass, forCellReuseIdentifier: cellID)
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    //MARK: - Navigation helper method -
    func push(controller: UIViewController, animated: Bool = true) {
        
        self.navigationController?.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        
        _ = self.navigationController?.popViewController(animated: animated)
    }
    
    func popTo(controller: UIViewController, animated: Bool = true) {
        
        _ = self.navigationController?.popToViewController(controller, animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        
        _ = self.navigationController?.popToRootViewController(animated: animated)
    }
    
    
    //Return alertController with style (.actionSheet OR .alert)
    func getAlertController(style: UIAlertController.Style, title:String?, messege: String?, options:[String], cancelTitle: String?, clickAction:@escaping(_ title: String) -> Void) ->  UIAlertController {
        
        let alrtControl = UIAlertController(title: title, message: messege, preferredStyle: style)
        
        for item in options {
            
            let alertAction = UIAlertAction(title: item, style: UIAlertAction.Style.default) {
                UIAlertAction in
                DispatchQueue.main.async { clickAction(item) }
            }
            alrtControl.addAction(alertAction)
        }
        
        if let cancel = cancelTitle {
            
            let cancelAction = UIAlertAction(title: cancel, style: .cancel) {
                UIAlertAction in
                DispatchQueue.main.async { clickAction(cancel) }
            }
            alrtControl.addAction(cancelAction)
        }
        
        return alrtControl
    }
    
    
    func showInformativeAlert(title: String?, message: String?, cancelAction:(() -> Void)? = nil) {
        
        let alert = getAlertController(style: .alert, title: title, messege: message, options: [], cancelTitle: "OK") { (title) in
            if (title == "OK") {
                DispatchQueue.main.async { cancelAction?() }
            }
        }
        present(alert, animated: true) {}
    }
    
}
