//
//  PayerSummaryViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 01/05/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class PayerSummaryViewController: HPViewController {
    
    @IBOutlet private var view_summary : UIView!
    @IBOutlet private var view_brief : UIView!
    @IBOutlet private var label_healthplan : UILabel!
    @IBOutlet private var tableView_Summary : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
        
    }
    
    @IBAction func payerDetailAction(_ sender : UIButton) {
        view_brief.isHidden = true
    }
    
    @IBAction func showDetailsAction(_ sender : UIButton){
        
        let briefView = tableView_Summary.viewWithTag(sender.tag)
        briefView?.isHidden = true
        
        tableView_Summary.reloadData()
    }
    
    @IBAction func blueButtonAction(_ sender : UIButton) {
        
        push(controller: ConnectedPlansViewController.nibInstance())
        
    }

}

//MARK: Private methods
private extension PayerSummaryViewController {
    
    private func setupController() {
        
        container()?.showBrandingBar(true)
        
        view_summary.layer.borderColor = UIColor.orange.cgColor
        view_summary.layer.borderWidth = 1.0
        
        registerTableCellAndNib(tableView_Summary, tableCellClass: SummaryBenefitCell.self, cellID: SummaryBenefitCell.reuseIdentifier(), nibName: "SummaryBenefitCell")
        tableView_Summary.delegate = self
        tableView_Summary.dataSource = self

    }
}

//MARK: Public methods
extension PayerSummaryViewController {
    
}

extension PayerSummaryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let summaryCell = tableView.dequeueReusableCell(withIdentifier: SummaryBenefitCell.reuseIdentifier(), for: indexPath) as! SummaryBenefitCell
        
        summaryCell.medicareDetail_button.addTarget(self, action: #selector(showDetailsAction), for: .touchUpInside)
        summaryCell.pharmacyDetail_button.addTarget(self, action: #selector(showDetailsAction), for: .touchUpInside)

        return summaryCell
    }
}

