//
//  HomeViewController.swift
//  HealthProfiler
//

import UIKit
import DataCache

class HomeViewController: HPViewController {
    
    @IBOutlet private var temp_label : UILabel!
    @IBOutlet private var heartRate_label : UILabel!
    @IBOutlet private var bp_label : UILabel!
    @IBOutlet private var bmi_label : UILabel!
    @IBOutlet private var height_label : UILabel!
    @IBOutlet private var weight_label : UILabel!
    @IBOutlet private var recent_tableView : UITableView!
    @IBOutlet private var sectionHeader_view : UIView!
    @IBOutlet private var tableFooter_view : UIView!
    @IBOutlet private var search_textField : UITextField!
    
    @IBOutlet private var vitals_button : UIButton!
    @IBOutlet private var latestVisit_button : UIButton!

    @IBOutlet private var segmentbg_view : UIView!
    @IBOutlet private var temperaturebg_view : UIView!
    @IBOutlet private var bpbgbg_view : UIView!
    @IBOutlet private var bmibg_view : UIView!
    @IBOutlet private var heartRatebg_view : UIView!
    
    @IBOutlet private var banner_imageView : UIImageView!
    @IBOutlet private var page_control : UIPageControl!

    @IBOutlet private var name_label : UILabel!
    
    private var isVitalsSelected : Bool!
    
    private var userVital: HPVitalsItem?
    private var dataSource_recentVisit = [HPRecentVisitItem]()
    private var datasource_StaticVisits = [HPRecentVisitsItem]()
    private var dataSource_costEstimatorList = [HPCostEstimatorList]()
    private var user = HealthProfiler.shared.loggedInUser
    
    var images:[String] = []
    var timer = Timer()
    var photoCount:Int = 0
    var recentVisitFailed = Bool()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        recent_tableView.reloadData()
    }
    
    @IBAction func searchButtonAction(_ sender : UIButton) {
        view.endEditing(true)
        
        if search_textField.text?.lowercased() == "urology" {
            callApiForCostEstimatorList()
        }
    }
    
    @IBAction func vitalsButtonAction(_sender: UIButton) {
        
        isVitalsSelected = true
        vitals_button.isSelected = true
        latestVisit_button.isSelected = false

        recent_tableView.tableFooterView = tableFooter_view

        recent_tableView.reloadData()

    }
    
    @IBAction func latestVisitButtonAction(_sender: UIButton) {
        
        isVitalsSelected = false
        vitals_button.isSelected = false
        latestVisit_button.isSelected = true
        recent_tableView.tableFooterView = nil

        recent_tableView.reloadData()


    }
}

//MARK: Private methods
private extension HomeViewController {
    
    private func setupController() {
        
        registerTableCell(recent_tableView, cellClass: REcentVisitTableCell.self)
        registerTableCell(recent_tableView, cellClass: CostListTableCell.self)
        
        datasource_StaticVisits = [HPRecentVisitsItem(.allscript1), HPRecentVisitsItem(.allscript2), HPRecentVisitsItem(.medicin1), HPRecentVisitsItem(.medicin2), HPRecentVisitsItem(.medicin3), HPRecentVisitsItem(.medicin4)]
        
        self.navigationItem.title = ""
        recentVisitFailed = false
        
        name_label.text = "Hi, \(user?.name ?? "")"
        
        banner_imageView.layer.cornerRadius = 10.0
        banner_imageView.layer.masksToBounds = true
        
        isVitalsSelected = true
        vitals_button.isSelected = true
        
        recent_tableView.delegate = self
        recent_tableView.dataSource = self
        recent_tableView.reloadData()
        dropShadowFunction()
        
        callApiForVitalsList()
        callApiForRecentVisitList()
        
        images = ["Flushot", "Image2", "Image3", "Image4", "Image5"]
        banner_imageView.image = UIImage.init(named: "Flushot")
        page_control.numberOfPages = images.count
        page_control.currentPage = 0
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(onTransition), userInfo: nil, repeats: true)
    }
    
    @objc func onTransition() {
        if (photoCount < images.count - 1){
            photoCount = photoCount  + 1;
            page_control.currentPage = photoCount
        }else{
            photoCount = 0;
            page_control.currentPage = 0

        }

        UIView.transition(with: self.banner_imageView, duration: 2.0, options: .transitionCrossDissolve, animations: {
            self.banner_imageView.image = UIImage.init(named: self.images[self.photoCount])
        }, completion: nil)
    }
    
    private func dropShadowFunction(){
       
        segmentbg_view.layer.shadowColor = UIColor.colorFromRGB(220, 220, 220).cgColor
        segmentbg_view.layer.shadowOpacity = 1
        segmentbg_view.layer.shadowOffset = CGSize(width: 0, height: 3)
        segmentbg_view.layer.shadowRadius = 1
        
        temperaturebg_view.layer.shadowColor = UIColor.colorFromRGB(220, 220, 220).cgColor
        temperaturebg_view.layer.shadowOpacity = 1
        temperaturebg_view.layer.shadowOffset = CGSize(width: 0, height: 3)
        temperaturebg_view.layer.shadowRadius = 1
        
        bpbgbg_view.layer.shadowColor = UIColor.colorFromRGB(220, 220, 220).cgColor
        bpbgbg_view.layer.shadowOpacity = 1
        bpbgbg_view.layer.shadowOffset = CGSize(width: 0, height: 3)
        bpbgbg_view.layer.shadowRadius = 1
        
        bmibg_view.layer.shadowColor = UIColor.colorFromRGB(220, 220, 220).cgColor
        bmibg_view.layer.shadowOpacity = 1
        bmibg_view.layer.shadowOffset = CGSize(width: 0, height: 3)
        bmibg_view.layer.shadowRadius = 1
        
        heartRatebg_view.layer.shadowColor = UIColor.colorFromRGB(220, 220, 220).cgColor
        heartRatebg_view.layer.shadowOpacity = 1
        heartRatebg_view.layer.shadowOffset = CGSize(width: 0, height: 3)
        heartRatebg_view.layer.shadowRadius = 1
    }
    
    private func userVitalReceived(vital: HPVitalsItem) {
        
        userVital = vital
        temp_label.text = userVital?.bodytemprature?.numbers
        heartRate_label.text = (userVital?.heartrate ?? "")
        bp_label.text = userVital?.bloodpressure
        bmi_label.text = userVital?.bmi
        height_label.text = userVital?.height
        weight_label.text = userVital?.weight
    }
}

//MARK: - API interaction -
extension HomeViewController {
    
    private func callApiForVitalsList() {
        
        Loader.show()
        
        HealthProfiler.networkManager.getVitalData(id: "24") { [weak self] (vitalItem, error) in
            
            if let strongSelf = self {
                
                if let vitalItem = vitalItem {
                    let date = HPDateFormatter.shared.getString(from: Date(), format: .date)
                    DataCache.instance.write(string: date, forKey: "AllScriptsUpdatedDate")
                    strongSelf.userVitalReceived(vital: vitalItem)
                    
                } else {
//                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
    
    private func callApiForRecentVisitList() {
        
        HealthProfiler.networkManager.getRecentVisitList(id: "24") { [weak self] (visitList, error) in
            
            if let strongSelf = self {
                Loader.dismiss()
                
                if let visitList = visitList {
                    strongSelf.dataSource_recentVisit = visitList.reversed()
                    strongSelf.recent_tableView.reloadData()
                } else {
                    self?.recentVisitFailed = true
//                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
    
    private func callApiForCostEstimatorList()  {
        Loader.show()
        
        HealthProfiler.networkManager.getCostEstimatorResultList(id: "208800000X") { [weak self] (estimatorList, error) in
            
            if let strongSelf = self {
                
                if let estimatorList = estimatorList {
                    Loader.dismiss()
                    strongSelf.dataSource_costEstimatorList = estimatorList
                    strongSelf.recent_tableView.reloadData()
                } else {
                    strongSelf.showInformativeAlert(title: "Error", message: error?.errorMessage)
                }
            }
        }
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource -
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? isVitalsSelected ? 0 : dataSource_recentVisit.count > 0 ? dataSource_recentVisit.count : datasource_StaticVisits.count : dataSource_costEstimatorList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 90 : 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0 :
            let visitsCell = tableView.dequeueReusableCell(withIdentifier: REcentVisitTableCell.reuseableId(), for: indexPath) as! REcentVisitTableCell
            
            if recentVisitFailed {
                visitsCell.configureRecentVisitStaticCell(item: datasource_StaticVisits[indexPath.row], index: indexPath.row )
            }else {
                visitsCell.configureRecentVisitCell(item: dataSource_recentVisit[indexPath.row], index: indexPath.row )
            }
            
            return visitsCell
        case 1:
            
            let costCell = tableView.dequeueReusableCell(withIdentifier: CostListTableCell.reuseableId(), for: indexPath) as! CostListTableCell
            costCell.configureCostListCell(item: dataSource_costEstimatorList[indexPath.row])
            return costCell
            
            
        default:
            break
            
        }
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return section == 1 ? user?.blueButtonConnected ?? false ? sectionHeader_view : nil : nil
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return section == 1 ? user?.blueButtonConnected ?? false ? 151 : 0 : 0
//    }
}
