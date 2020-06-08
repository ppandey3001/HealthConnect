//
//  HSIDLoginViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 03/06/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class HSIDLoginViewController: HPViewController {
    
    @IBOutlet private var tableView_login : UITableView!
    
    private var dataSource_login = [HPProfileItem]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        var userName: String?
        var password: String?
        
        for profileItem in dataSource_login {
            switch profileItem.type {
            case .userName:
                userName = profileItem.value?.trimmingCharacters(in: .whitespacesAndNewlines)
                
            case .password:
                password = profileItem.value?.trimmingCharacters(in: .whitespacesAndNewlines)
                
            default: continue
            }
        }
        
        if let userName = userName,
            let password = password,
            ((userName.count > 0) && (password.count > 0)) {
            
            view.endEditing(true)
            
            DummyData.shared.authorise(username: userName, pwd: password) { [weak self] (user, error) in
                
                if let strongSelf = self {
                    
                    if let user = user {
                        strongSelf.userAuthorised(user: user)
//                        DataCache.instance.write(string: userName, forKey: "myKey")

                    } else {
                        strongSelf.showInformativeAlert(title: "Error", message: "Sorry, your username and/or password are incorrect. Please try again.")
                    }
                }
            }
        } else {
            showInformativeAlert(title: "Error", message: "Sorry, your username and/or password are incorrect. Please try again.")
        }
    }
    
    @IBAction func buttonAction_back(_ sender: UIButton) {
        
        container()?.showBrandingBar(false)
        pop()
    }

}

//MARK: Private methods
private extension HSIDLoginViewController {
    
    private func setupController() {
        
        container()?.showBrandingBar(true)
                
        dataSource_login.removeAll()
        dataSource_login = [HPProfileItem(.userName), HPProfileItem(.password)]
        
        registerTableCell(tableView_login, cellClass: LoginViewCell.self)
        
        tableView_login.delegate = self
        tableView_login.dataSource = self
        refreshDataSourceAndReload()
    }
    
    private func refreshDataSourceAndReload() {
        
        dataSource_login.removeAll()
        dataSource_login = [HPProfileItem(.userName), HPProfileItem(.password)]
        
        //WARNING: dev purpose only, remove once completed
        for item in dataSource_login {
            item.value = "fredrick"
        }

        tableView_login.reloadData()
    }

    
    private func userAuthorised(user: HPUserItem) {
        
        HealthProfiler.shared.loggedInUser = user
        navigateToDashboard(isNewUser: user.isFirstTimeUser)
        refreshDataSourceAndReload()
    }
    
    private func navigateToDashboard(isNewUser: Bool) {
        
        //clear and reset input boxes and check boxes
        
        //show custom branding bar
        container()?.showBrandingBar(true)
        
        //Create new dashboard, and push
        push(controller: AppCoordinator.shared.getDashboard(), animated: false)
        
        TabBarCoordinator.shared.tabBarStatus(isUserConnected: !isNewUser)
        TabBarCoordinator.shared.tabBarNavigationTitle(isDetailDisplayed: isNewUser ? false : true)
        TabBarCoordinator.shared.tabBarController?.selectedIndex = isNewUser ? HPTabType.manageConnections.tabIndex : HPTabType.home.tabIndex
    }
}


//MARK: Public methods
extension HSIDLoginViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource_login.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let loginCell = tableView.dequeueReusableCell(withIdentifier: LoginViewCell.reuseableId(), for: indexPath) as! LoginViewCell
        loginCell.configureLoginCell(item: dataSource_login[indexPath.row], index: indexPath.row)
        loginCell.textField_input.delegate = self
        loginCell.textField_input.returnKeyType = (indexPath.row == (dataSource_login.count - 1) ) ? .done : .next
        
        return loginCell
    }
}

extension HSIDLoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == .next,
            let passwordTextField = tableView_login.viewWithTag(textField.tag + 1) as? UITextField {
            
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let index = textField.tag - 1
        if index >= 0, index < dataSource_login.count {
            
            let textFieldText: NSString = (textField.text ?? "") as NSString
            let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
            
            let profileItem = dataSource_login[index]
            profileItem.value = txtAfterUpdate
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        let index = textField.tag - 1
        if index >= 0, index < dataSource_login.count {
            
            let profileItem = dataSource_login[index]
            profileItem.value = ""
        }
        
        return true
    }
}
