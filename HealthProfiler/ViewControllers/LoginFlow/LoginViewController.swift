//
//  LoginViewController.swift
//  HealthProfiler
//

import UIKit

class LoginViewController: HPViewController {
    
    @IBOutlet private var loginTableView : UITableView!
    @IBOutlet private var headerTableView : UIView!
    @IBOutlet private var footerTableView : UIView!
    @IBOutlet private var termsLabel : UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    func addTappableLabel(){
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(tapLabel))
        termsLabel.isUserInteractionEnabled = true
        termsLabel.addGestureRecognizer(tapAction)
    }
    
    @IBAction func tapLabel(_ sender: UITapGestureRecognizer) {
        let text = (termsLabel.text)!
        let termsRange = (text as NSString).range(of: "terms & conditions")
        let privacyRange = (text as NSString).range(of: "privacy policy")
        
        if sender.didTapAttributedTextInLabel(label: termsLabel, inRange: termsRange) {
            print("Tapped terms")
        } else if sender.didTapAttributedTextInLabel(label: termsLabel, inRange: privacyRange) {
            push(controller: PrivacyPolicyViewController.nibInstance())
        }
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
        loginTableView.tableHeaderView = headerTableView
        loginTableView.tableFooterView = footerTableView
        registerTableCellAndNib(loginTableView, tableCellClass: LoginViewCell.self, cellID: "LoginViewCellID", nibName: "LoginViewCell")
        addTappableLabel()
    }
    
    private func navigateToDashboard() {
        
        //clear and reset input boxes and check boxes
        
        //show custom branding bar
        container()?.showBrandingBar(true)
        
        //Create new dashboard, and push
        push(controller: AppCoordinator.shared.getDashboard())
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
        let cell : LoginViewCell = loginTableView.dequeueReusableCell(withIdentifier: "LoginViewCellID") as! LoginViewCell
        cell.usernameTextField.tag = indexPath.row+1
        cell.usernameTextField.delegate = self
        cell.usernameTextField.addDoneButtonOnKeyboard()
        switch  indexPath.row {
        case 0:
            cell.usernameTextField.placeholder = "Username"
            cell.usernameTextField.returnKeyType = .next
        case 1:
            cell.usernameTextField.placeholder = "Password"
            cell.usernameTextField.isSecureTextEntry = true
            cell.usernameTextField.returnKeyType = .done
        default:
            
            return cell
        }
        return cell
        
        
    }
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            let txt = self.view.viewWithTag(textField.tag + 1) as? UITextField
            txt?.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
    
}
