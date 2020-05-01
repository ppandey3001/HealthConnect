//
//  ManageConnectionsViewController.swift
//  HealthProfiler
//

import UIKit

class ManageConnectionsViewController: HPViewController {
    
    @IBOutlet private var connection_collectionView: UICollectionView!
    
    private var dataSource_connection = [HPConnectionItem]()
    private let margin : CGFloat = (UIScreen.main.bounds.width - 300.0) / 3.0

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
}

//MARK: Private methods
private extension ManageConnectionsViewController {
    
    private func setupController() {
        
        container()?.showBrandingBar(true)
                
        dataSource_connection.removeAll()
        dataSource_connection.append(HPConnectionItem(.healthInsurance))
        dataSource_connection.append(HPConnectionItem(.providers))
        dataSource_connection.append(HPConnectionItem(.labs))
        dataSource_connection.append(HPConnectionItem(.devices))
        dataSource_connection.append(HPConnectionItem(.pharmacy))
        dataSource_connection.append(HPConnectionItem(.others))

        registerCollectionViewCellAndNib(connection_collectionView, collectionCellClass: ManageConnectionViewCell.self, cellID: ManageConnectionViewCell.reuseIdentifier(), nibName: "ManageConnectionViewCell")
        
        connection_collectionView.alwaysBounceVertical = true
        connection_collectionView.delegate = self
        connection_collectionView.dataSource = self
        connection_collectionView.reloadData()
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
        
        return UIEdgeInsets.init(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 150)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: ManageConnectionViewCell.reuseIdentifier(), for: indexPath) as! ManageConnectionViewCell
        collectionCell.configureConnectionCell(item: dataSource_connection[indexPath.row])
        
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        container()?.showBrandingBar(true)
        
        self.navigationItem.title = ""
        push(controller:InsurancePlanViewController.nibInstance())
    }
}
