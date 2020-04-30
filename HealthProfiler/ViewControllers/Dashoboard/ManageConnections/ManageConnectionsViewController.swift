//
//  ManageConnectionsViewController.swift
//  HealthProfiler
//

import UIKit

class ManageConnectionsViewController: HPViewController {
    
    @IBOutlet private var connection_collectionView: UICollectionView!
    
    private var dataSource_connection = [HPConnectionItem]()

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

        registerCollectionViewCellAndNib(connection_collectionView, collectionCellClass: ManageConnectionViewCell.self, cellID: "ManageConnectionViewCellID", nibName: "ManageConnectionViewCell")
        
        connection_collectionView.delegate = self
        connection_collectionView.dataSource = self
        
        connection_collectionView.reloadData()
        
    }
}


//MARK: Public methods
extension ManageConnectionsViewController {
    
}


extension ManageConnectionsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           6
       }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let cellWidth : CGFloat = 165.0
//
//        let numberOfCells = floor(self.view.frame.size.width / cellWidth)
//        let edgeInsets = (self.view.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
//
//        return UIEdgeInsets(top: 15, left: edgeInsets, bottom: 0, right: edgeInsets)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ManageConnectionViewCellID", for: indexPath) as! ManageConnectionViewCell
        collectionCell.configureConnectionCell(item: dataSource_connection[indexPath.row], index: indexPath.row)
        return collectionCell
       }
    
}
