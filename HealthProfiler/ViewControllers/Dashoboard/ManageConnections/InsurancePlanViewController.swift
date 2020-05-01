//
//  InsurancePlanViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 01/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class InsurancePlanViewController: UIViewController {
    
    @IBOutlet private var tableView_insurance : UITableView!
    @IBOutlet private var terms_label : UILabel!
    
    private var dataSource_insurance = [HPHealthInsuranceItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
        
    }
    
    @IBAction func openPickerAction(_ sender: UIButton){
        
    }
    
}

//MARK: Private methods
private extension InsurancePlanViewController {
    
    private func setupController() {
        
        container()?.showBrandingBar(true)
        
        dataSource_insurance.removeAll()
        dataSource_insurance = [HPHealthInsuranceItem(.choosePayer), HPHealthInsuranceItem(.planID), HPHealthInsuranceItem(.memberID)]
        
        registerTableCellAndNib(tableView_insurance, tableCellClass: LoginViewCell.self, cellID: LoginViewCell.reuseIdentifier(), nibName: "LoginViewCell")
        
        tableView_insurance.delegate = self
        tableView_insurance.dataSource = self
        
        tableView_insurance.reloadData()
    }
    
    private func addTapGesture(label: UILabel) {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapLabel))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
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
extension InsurancePlanViewController {
    
}


//MARK: UITableViewDataSource, UITableViewDelegate
extension InsurancePlanViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource_insurance.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let insuranceCell = tableView.dequeueReusableCell(withIdentifier: LoginViewCell.reuseIdentifier(), for: indexPath) as! LoginViewCell
        insuranceCell.configureHealthInsuranceCell(item: dataSource_insurance[indexPath.row], index: indexPath.row)
        insuranceCell.textField_input.delegate = self
        insuranceCell.button_showSecureEntry.addTarget(self, action: #selector(openPickerAction), for: .touchUpInside)
        insuranceCell.textField_input.returnKeyType = (indexPath.row == (dataSource_insurance.count - 1) ) ? .done : .next
        
        return insuranceCell
    }
}

//MARK: UITextFieldDelegate
extension InsurancePlanViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.returnKeyType == .next,
            let passwordTextField = tableView_insurance.viewWithTag(textField.tag + 1) as? UITextField {
            
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
