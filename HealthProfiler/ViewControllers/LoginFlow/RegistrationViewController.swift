//
//  RegistrationViewController.swift
//  HealthProfiler
//

import UIKit

class RegistrationViewController: HPViewController {
    @IBOutlet private var tableView_register : UITableView!
    @IBOutlet private var terms_label : UILabel!
    @IBOutlet private var  check_button: UIButton!
    @IBOutlet private var  refresh_button: UIButton!
    @IBOutlet private var  verify_textField: UITextField!
    @IBOutlet private var  captcha_label: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        container()?.showBrandingBar(false)
        pop()
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton) {        
        navigateToDashboard()
    }
    
    @IBAction func refreshButtonAction(_ sender: UIButton) {
        
        
    }
    
    @IBAction func checkButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func showPasswordAction(_ sender: UIButton){

    }
}

//MARK: Private methods
private extension RegistrationViewController {
    
    private func setupController() {
        container()?.showBrandingBar(true)
        
        addTapGesture(label: terms_label)
        
        registerTableCellAndNib(tableView_register, tableCellClass: LoginViewCell.self, cellID: "LoginViewCellID", nibName: "LoginViewCell")
        
        tableView_register.delegate = self
        tableView_register.dataSource = self
        tableView_register.reloadData()
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
        
        let text = (terms_label.text)!
        let termsRange = (text as NSString).range(of: "terms & conditions")
        let privacyRange = (text as NSString).range(of: "privacy policy")
        
        if sender.didTapAttributedTextInLabel(label: terms_label, inRange: termsRange) {
            
            print("Tapped terms")
        } else if sender.didTapAttributedTextInLabel(label: terms_label, inRange: privacyRange) {
            
            push(controller: PrivacyPolicyViewController.nibInstance())
        }
    }
}


//MARK: Public methods
extension RegistrationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let loginCell = tableView.dequeueReusableCell(withIdentifier: "LoginViewCellID") as! LoginViewCell
        
        //TODO: try to minimise code from viewController, and place it inside tablecell class
        loginCell.usernameTextField.tag = indexPath.row + 1
        loginCell.usernameTextField.delegate = self
        loginCell.usernameTextField.addDoneButtonOnKeyboard()
        loginCell.txtFieldBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
        loginCell.txtFieldBackgroundView.layer.borderWidth = 1.0
        loginCell.showPasswordButton.tag = indexPath.row + 1
        
        switch  indexPath.row {
            
        case 0:
            loginCell.usernameTextField.placeholder = "Name"
            loginCell.iconImage.image = UIImage(named: "name")
            loginCell.usernameTextField.returnKeyType = .next
            
        case 1:
            loginCell.usernameTextField.placeholder = "Email"
            loginCell.iconImage.image = UIImage(named: "email")
            loginCell.usernameTextField.returnKeyType = .next
            
        case 2:
            loginCell.usernameTextField.placeholder = "Password"
            loginCell.iconImage.image = UIImage(named: "password-icon")
            loginCell.showPasswordButton.addTarget(self, action: #selector(showPasswordAction), for: .touchUpInside)
            loginCell.showPasswordButton.isHidden = false
            loginCell.usernameTextField.isSecureTextEntry = true
            loginCell.usernameTextField.returnKeyType = .next
            
        case 3:
            loginCell.usernameTextField.placeholder = "Confirm Password"
            loginCell.iconImage.image = UIImage(named: "password-icon")
            loginCell.showPasswordButton.addTarget(self, action: #selector(showPasswordAction), for: .touchUpInside)
            loginCell.showPasswordButton.isHidden = false
            loginCell.usernameTextField.isSecureTextEntry = true
            loginCell.usernameTextField.returnKeyType = .done
            
        default: break
        }
        
        return loginCell
    }
}

extension RegistrationViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == .next,
            let passwordTextField = tableView_register.viewWithTag(textField.tag + 1) as? UITextField {
            
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}




