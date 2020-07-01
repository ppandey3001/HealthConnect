//
//  CareTeamSectionTableCell.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 26/06/20.
//  Copyright © 2020 UHG. All rights reserved.
//

import UIKit

class CareTeamSectionTableCell: HPTableViewCell {
    
    @IBOutlet var section_tableView: UITableView!
    
    var datasource_careteamList = [HPCareTeamItem]()
    var dataSourceCernerTeam = [HPCernerCareTeamItem]()
    
    private let user = HealthProfiler.shared.loggedInUser


    func registerCell() {
        
        registerTableCell(section_tableView, cellClass: CareTeamTableCell.self)

        section_tableView.delegate = self
        section_tableView.dataSource = self
        section_tableView.reloadData()

    }

}

extension CareTeamSectionTableCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.isFirstTimeUser == true ? dataSourceCernerTeam.count : datasource_careteamList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let careTeamCell = tableView.dequeueReusableCell(withIdentifier: CareTeamTableCell.reuseableId(), for: indexPath) as! CareTeamTableCell
         
        if user?.isFirstTimeUser ?? false {
            
            careTeamCell.configureCernerCareTeamCell(item: dataSourceCernerTeam[indexPath.row])

        }else {
            careTeamCell.configureCareTeam(item: datasource_careteamList[indexPath.row])

        }
        return careTeamCell
    }
    
    
}
