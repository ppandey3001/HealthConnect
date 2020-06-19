//
//  HumanaCredentialsViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 04/06/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class HumanaCredentialsViewController: UIViewController {
    
    @IBOutlet private var humana_tableView: UITableView!
    
    private var dataSource_humana = [HPHumanaItem]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton){
        
        TabBarCoordinator.shared.tabBarNavigationTitle(isDetailDisplayed: true)
        HealthProfiler.shared.loggedInUser?.isInsurerConnected = true
        TabBarCoordinator.shared.tabBarStatus(isUserConnected: false)
        push(controller: ConnectedPlansViewController.nibInstance())
    }
}


//MARK: Private methods
private extension HumanaCredentialsViewController {
    
    private func setupController() {
                
        dataSource_humana.removeAll()
        dataSource_humana = [HPHumanaItem(.username), HPHumanaItem(.password)]
        
        registerTableCell(humana_tableView, cellClass: HumanaTableViewCell.self)
        
        humana_tableView.delegate = self
        humana_tableView.dataSource = self
        humana_tableView.reloadData()
    }
}


extension HumanaCredentialsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource_humana.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let humanaCell = tableView.dequeueReusableCell(withIdentifier: HumanaTableViewCell.reuseableId(), for: indexPath) as! HumanaTableViewCell
        humanaCell.configureHumanaCell(item: dataSource_humana[indexPath.row], index: indexPath.row)
        humanaCell.input_textField.delegate = self
        humanaCell.input_textField.text = indexPath.row == 0 ? "wilma_smart" : "111111"
        humanaCell.input_textField.isSecureTextEntry = indexPath.row == 0 ? false : true
        humanaCell.input_textField.returnKeyType = (indexPath.row == (dataSource_humana.count - 1) ) ? .done : .next
        
        return humanaCell
    }
}


extension HumanaCredentialsViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == .next,
            let passwordTextField = humana_tableView.viewWithTag(textField.tag + 1) as? UITextField {
            
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}

