//
//  HumanaViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 10/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class HumanaViewController: HPViewController {
    
    @IBOutlet private var humana_tableView: UITableView!
    
    private var dataSource_humana = [HPHumanaItem]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    @IBAction func connectButtonAction(_ sender: UIButton){
        
        push(controller: PayerSummaryViewController.nibInstance())
    }
}


//MARK: Private methods
private extension HumanaViewController {
    
    private func setupController() {
        
        container()?.showBrandingBar(false)
        
        dataSource_humana.removeAll()
        dataSource_humana = [HPHumanaItem(.planID), HPHumanaItem(.memberID), HPHumanaItem(.dateOfBirth)]
        
        registerTableCell(humana_tableView, cellClass: HumanaTableViewCell.self)
        
        humana_tableView.delegate = self
        humana_tableView.dataSource = self
        humana_tableView.reloadData()
    }
}


extension HumanaViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        humanaCell.input_textField.returnKeyType = (indexPath.row == (dataSource_humana.count - 1) ) ? .done : .next
        
        return humanaCell
    }
}


extension HumanaViewController : UITextFieldDelegate {
    
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
