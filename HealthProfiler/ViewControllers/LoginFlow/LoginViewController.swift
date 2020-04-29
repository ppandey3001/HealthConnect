//
//  LoginViewController.swift
//  HealthProfiler
//

import UIKit

class LoginViewController: HPViewController {
    
    @IBOutlet private var tableView_login : UITableView!
    @IBOutlet private var termsLabel : UILabel!
    
    private var dataSource_login = LoginModal()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        
        navigateToDashboard()
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        
        container()?.showBrandingBar(true)
        push(controller: RegistrationViewController.nibInstance())
    }
}

//MARK: Private methods
private extension LoginViewController {
    
    private func setupController() {
        
        container()?.showBrandingBar(false)
        
        addTapGesture(label: termsLabel)
        
        registerTableCellAndNib(tableView_login, tableCellClass: LoginViewCell.self, cellID: "LoginViewCellID", nibName: "LoginViewCell")
        
        tableView_login.delegate = self
        tableView_login.dataSource = self
        tableView_login.reloadData()
    }
    
    private func addTapGesture(label: UILabel) {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapLabel))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
    }
    
    private func navigateToDashboard() {
        
        //clear and reset input boxes and check boxes
        
        //show custom branding bar
        container()?.showBrandingBar(true)
        
        //Create new dashboard, and push
        push(controller: AppCoordinator.shared.getDashboard())
    }
    
    @IBAction private func tapLabel(_ sender: UITapGestureRecognizer) {
        
        let text = (termsLabel.text)!
        let termsRange = (text as NSString).range(of: "terms & conditions")
        let privacyRange = (text as NSString).range(of: "privacy policy")
        
        if sender.didTapAttributedTextInLabel(label: termsLabel, inRange: termsRange) {
            
            print("Tapped terms")
        } else if sender.didTapAttributedTextInLabel(label: termsLabel, inRange: privacyRange) {
            
            push(controller: PrivacyPolicyViewController.nibInstance())
        }
    }
}


//MARK: Public methods
extension LoginViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let loginCell = tableView.dequeueReusableCell(withIdentifier: "LoginViewCellID") as! LoginViewCell
        
        loginCell.configureLoginCell(index: indexPath.row, item : dataSource_login)
        
        loginCell.usernameTextField.delegate = self
        
        return loginCell
    }
}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == .next,
            let passwordTextField = tableView_login.viewWithTag(textField.tag + 1) as? UITextField {
            
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag {
        case 1:
            dataSource_login.username = textField.text
        case 2:
            dataSource_login.password = textField.text
            
        default: break
            
        }
    }
}
