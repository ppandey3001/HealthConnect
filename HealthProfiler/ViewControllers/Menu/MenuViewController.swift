//
//  MenuViewController.swift
//  HealthProfiler
//

import UIKit

class MenuViewController: HPViewController {

    @IBOutlet private var tableView_menu: HPTableView!
    @IBOutlet private var view_footer: UIView!
    @IBOutlet private  var label_appVersion: UILabel!

    private var dataSource_menu = [HPMenuItem]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
}

//MARK: Private methods
private extension MenuViewController {
    
    private func setupController() {
        
        view.backgroundColor = UIColor.colorFromRGB(105.0, 105.0, 105.0)
        
        //register all table cells to be used
        registerTableCell(tableView_menu, cellClass: MenuTableCell.self)
        
        tableView_menu.delegate = self
        tableView_menu.dataSource = self
        refreshTableDataSource()
        
        if let info = Bundle.main.infoDictionary {
            
            let appVersion = info["CFBundleShortVersionString"] as? String ?? "Unknown"
            let buildVersion = info["CFBundleVersion"] as? String ?? "Unknown"
            label_appVersion.text = String(format: "App version %@ (%@)", appVersion, buildVersion)
        }
    }
    
    private func refreshTableDataSource() {
        
        //refresh datasource
        dataSource_menu.removeAll()
        dataSource_menu = [HPMenuItem(.home), HPMenuItem(.myProfile), HPMenuItem(.manageConnections), HPMenuItem(.myHealthProfile), HPMenuItem(.coverage), HPMenuItem(.myCareTeam), HPMenuItem(.settings)]
        
        //refresh table footer view
        //TODO: not working, must be due to custom container, need to check
        
//        tableView_menu.tableFooterView = view_footer
//        let tableHeaderHeight = (tableView_menu.tableHeaderView?.bounds.height ?? 0.0)
//        let totalCellHeight = (CGFloat(dataSource_menu.count) * MenuTableCell.cellHeight())
//        let footerHeight = (tableView_menu.frame.height - totalCellHeight - tableHeaderHeight)
//        tableView_menu.tableFooterView?.frame = CGRect(x: 0.0, y: 0.0, width: tableView_menu.bounds.width, height: max(footerHeight, 160.0))
        
        tableView_menu.reloadData()
    }
    
    private func navigateWithOption(_ option: HPMenuItem) {
        
        //close drawer
        drawer()?.close(to: .left)

        guard let tabBar = TabBarCoordinator.shared.tabBarController else {
            return
        }
        let navigationIndex = TabBarCoordinator.shared.getNavigationIndex(type: option.type)
        
        guard let navController = tabBar.viewControllers?[navigationIndex] as? UINavigationController else {
            return
        }
        
        
        //navigate as per 'option.type'
        switch option.type {

        case .home, .coverage, .manageConnections:
            navController.popToRootViewController(animated: false)
            tabBar.selectedIndex = navigationIndex
            
//        case .myProfile:
//            navController.pushViewController(RegistrationViewController.nibInstance(), animated: true)
            
        default: break
        }
        
    }
    
    //MARK: IBAction
    @IBAction func buttonAction_cross(_ sender: Any) {
        drawer()?.close(to: .left)
    }
    
    @IBAction func buttonAction_privacyPolicy(_ sender: Any) {
        
    }
    
    @IBAction func buttonAction_logout(_ sender: Any) {
        
        let alrtControl = UIAlertController(title: "Log out", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let no_alertAction = UIAlertAction(title: "No", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        alrtControl.addAction(no_alertAction)
        
        let yes_alertAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive) {
            UIAlertAction in
            DispatchQueue.main.async {
                AppCoordinator.shared.logout()
            }
        }
        alrtControl.addAction(yes_alertAction)
        alrtControl.preferredAction = yes_alertAction
        navigationController?.present(alrtControl, animated: true, completion: nil)
    }
}


//MARK: - Tableview Delegate/DataSource Methods
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource_menu.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MenuTableCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuTableCell = tableView.dequeueReusableCell(withIdentifier: MenuTableCell.reuseableId(), for: indexPath) as! MenuTableCell
        menuTableCell.configureMenuCell(item: dataSource_menu[indexPath.row])
        return menuTableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        navigateWithOption(dataSource_menu[indexPath.row])
    }
}
