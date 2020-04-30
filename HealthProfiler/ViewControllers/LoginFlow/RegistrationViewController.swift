//
//  RegistrationViewController.swift
//  HealthProfiler
//

import UIKit

class RegistrationViewController: HPViewController {
    
    @IBOutlet private var tableView_register : UITableView!
    @IBOutlet private var terms_label : UILabel!
    @IBOutlet private var check_button: UIButton!
    @IBOutlet private var refresh_button: UIButton!
    @IBOutlet private var verify_textField: UITextField!
    @IBOutlet private var captcha_label: UILabel!
    
    private var dataSource_register = [HPProfileItem]()

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
        
        dataSource_register.removeAll()
        dataSource_register.append(HPProfileItem(.name))
        dataSource_register.append(HPProfileItem(.userName))
        dataSource_register.append(HPProfileItem(.email))
        dataSource_register.append(HPProfileItem(.password))
        dataSource_register.append(HPProfileItem(.confirmPassword))

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
        push(controller: AppCoordinator.shared.getDashboard(), animated: false)
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


//MARK: UITableViewDataSource, UITableViewDelegate
extension RegistrationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource_register.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let loginCell = tableView.dequeueReusableCell(withIdentifier: "LoginViewCellID") as! LoginViewCell
        loginCell.configureRegisterCell(item: dataSource_register[indexPath.row], index: indexPath.row)
        loginCell.textField_input.delegate = self
        loginCell.button_showSecureEntry.addTarget(self, action: #selector(showPasswordAction), for: .touchUpInside)
        loginCell.textField_input.returnKeyType = (indexPath.row == (dataSource_register.count - 1) ) ? .next : .done

        return loginCell
    }
}

//MARK: UITextFieldDelegate
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
//        switch textField.tag {
//        case 1:
//            dataSource_register.name = textField.text
//        case 2:
//            dataSource_register.email = textField.text
//        case 3:
//            dataSource_register.password = textField.text
//        case 4:
//            dataSource_register.confirmPassword = textField.text
//        case 5:
//            dataSource_register.verificationCode = textField.text
//            
//        default: break
//            
//        }
    }
}




