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
    
    //MARK: - Register custom collectionView cell -
    func registerCollectionViewCellAndNib(_ collectionView: UICollectionView!, collectionCellClass: AnyClass!, cellID: String!, nibName: String!) {
        
        collectionView.register(collectionCellClass, forCellWithReuseIdentifier: cellID)
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    
    
    //MARK: - Register custom tableView cell -
    func registerTableCell(_ tableView: UITableView, cellClass: HPTableViewCell.Type) {
        
        let cellID = cellClass.reuseableId()
        tableView.register(cellClass, forCellReuseIdentifier: cellID)
        tableView.register(cellClass.nib(), forCellReuseIdentifier: cellID)
    }
    
    //MARK: - Register custom collectionView cell -
    func registerCollectionCell(_ collectionView: UICollectionView, cellClass: HPCollectionViewCell.Type) {
                
        let cellID = cellClass.reuseableId()
        collectionView.register(cellClass, forCellWithReuseIdentifier: cellID)
        collectionView.register(cellClass.nib(), forCellWithReuseIdentifier: cellID)
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
    func present(controller: UIViewController, animated: Bool = true) {
        
        self.present(controller, animated: true, completion: nil)
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
    
    func showRetryAlert(title: String?, message: String?, retryAction:@escaping() -> Void, cancelAction:@escaping() -> Void) {
        
        let alert = getAlertController(style: .alert, title: title, messege: message, options: ["Retry", "Cancel"], cancelTitle: nil) { (title) in
            if (title == "Retry") {
                DispatchQueue.main.async { retryAction() }
            }
            else {
                DispatchQueue.main.async { cancelAction() }
            }
        }
        present(alert, animated: true) {}
    }
}

//navigationitem
extension UIViewController {
    
    func addDrawerButton() {
        
        let hamburger = UIButton(type: .custom)
        hamburger.frame = CGRect(x: 0.0, y: 0.0, width: 45.0, height: 40.0)
        hamburger.setImage(UIImage(named: "Hamburger.png"), for: .normal)
        hamburger.setImage(UIImage(named: "Hamburger.png"), for: .highlighted)
        hamburger.addTarget(self, action: #selector(openDrawer), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburger)
    }
    
    // MARK: Selector
    @objc func openDrawer() {
        
        drawer()?.open(to: .left)
    }
}
