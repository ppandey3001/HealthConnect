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
        
        addTapGesture(label: terms_label)
        
        dataSource_register.removeAll()
        dataSource_register = [HPProfileItem(.name), HPProfileItem(.userName), HPProfileItem(.email), HPProfileItem(.password), HPProfileItem(.confirmPassword)]

        registerTableCell(tableView_register, cellClass: LoginViewCell.self)
        
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
        
        // For demo purpose registration is not working so pop to login view controller
        showRegistrationAlert(title: "Success", message: "Registration is successfully completed. Login to get started")

        //clear and reset input boxes and check boxes

        //Create new dashboard, and push
//        push(controller: AppCoordinator.shared.getDashboard(), animated: false)
//        tabBarController?.selectedIndex = HPTabType.manageConnections.tabIndex
        
    }
    
    @IBAction private func tapLabel(_ sender: UITapGestureRecognizer) {
        
        let text = (terms_label.text)!
        let termsRange = (text as NSString).range(of: "terms & conditions")
        let privacyRange = (text as NSString).range(of: "privacy policy")
        
        if sender.didTapAttributedTextInLabel(label: terms_label, inRange: termsRange) {
            
            print("Tapped terms")
        } else if sender.didTapAttributedTextInLabel(label: terms_label, inRange: privacyRange) {
            
            let webContentController = WebContentViewController.nibInstance()
            webContentController.type = .privacyPolicy
            present(controller: UINavigationController(rootViewController: webContentController))
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
        
        let loginCell = tableView.dequeueReusableCell(withIdentifier: LoginViewCell.reuseableId(), for: indexPath) as! LoginViewCell
        loginCell.configureRegisterCell(item: dataSource_register[indexPath.row], index: indexPath.row)
        loginCell.textField_input.delegate = self
        loginCell.button_showSecureEntry.setImage(nil , for: .normal)
        loginCell.button_showSecureEntry.addTarget(self, action: #selector(showPasswordAction), for: .touchUpInside)
        loginCell.textField_input.returnKeyType = (indexPath.row == (dataSource_register.count - 1) ) ? .done : .next

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
        
    }
}




