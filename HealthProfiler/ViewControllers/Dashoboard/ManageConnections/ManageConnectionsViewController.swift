//
//  ManageConnectionsViewController.swift
//  HealthProfiler
//

import UIKit
import DataCache

class ManageConnectionsViewController: HPViewController {
    
    @IBOutlet private var connection_collectionView: UICollectionView!
    @IBOutlet private var view_welcomeMessageContainer: UIView!
    @IBOutlet private var label_welcomeMessageTitle: UILabel!
    @IBOutlet private var label_name: UILabel!

    private var dataSource_connection = [HPConnectionItem]()
    private let margin : CGFloat = (UIScreen.main.bounds.width - 200.0) / 3.0
    
    let user = HealthProfiler.shared.loggedInUser
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        connection_collectionView.reloadData()
        
//        if user?.isFirstTimeUser ?? false {
//            self.navigationItem.title = user?.isInsurerConnected ?? false ? "\(user?.name! ?? "")  |  \(user?.age! ?? "") Y  | \(user?.gender! ?? "")" : "\(user?.name! ?? "")"
//        }
    }
    
    @IBAction func buttonAction_getStarted(_ sender: UIButton) {
        
        view_welcomeMessageContainer.isHidden = true
    }
}

//MARK: Private methods
private extension ManageConnectionsViewController {
    
    private func setupController() {
        
        
        dataSource_connection.removeAll()
        dataSource_connection.append(HPConnectionItem(.healthInsurance))
        dataSource_connection.append(HPConnectionItem(.providers))
        dataSource_connection.append(HPConnectionItem(.labs))
        dataSource_connection.append(HPConnectionItem(.devices))
        dataSource_connection.append(HPConnectionItem(.pharmacy))
        dataSource_connection.append(HPConnectionItem(.others))
        
        registerCollectionCell(connection_collectionView, cellClass: ManageConnectionViewCell.self)
        
        connection_collectionView.alwaysBounceVertical = true
        connection_collectionView.delegate = self
        connection_collectionView.dataSource = self
        connection_collectionView.reloadData()
        
        
        if user?.isFirstTimeUser == false {
            
            view_welcomeMessageContainer.isHidden = true
        } else {
            view_welcomeMessageContainer.isHidden = user?.isInsurerConnected ?? false ? true : false
        }
        let name = user?.name
        label_name.text = "Hi, \(name!)"
    }
}

//MARK: Public methods
extension ManageConnectionsViewController {
    
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ManageConnectionsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource_connection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 20, left: 15, bottom: 20, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 170, height: 150)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ManageConnectionViewCell.reuseableId(), for: indexPath) as! ManageConnectionViewCell
        collectionCell.configureConnectionCell(item: dataSource_connection[indexPath.row], index: indexPath.row)
        
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let connectionItem = dataSource_connection[indexPath.row]
        switch connectionItem.type {
            
        case .healthInsurance:
            if user?.isFirstTimeUser == false ||  HealthProfiler.shared.loggedInUser?.isInsurerConnected ?? false{
                
                let connectedPlans = ConnectedPlansViewController.nibInstance()
                connectedPlans.isFromProvider = false
                push(controller: connectedPlans)
                
            } else {
                
                push(controller: InsurancePlanViewController.nibInstance())
            }
            
        case .providers:
            if HealthProfiler.shared.loggedInUser?.isInsurerConnected ?? false {
            let connectedPlans = ConnectedPlansViewController.nibInstance()
            connectedPlans.isFromProvider = true
            push(controller: connectedPlans)
            }
            
        default: break
        }
    }
}
