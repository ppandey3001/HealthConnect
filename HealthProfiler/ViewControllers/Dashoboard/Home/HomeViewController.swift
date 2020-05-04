//
//  HomeViewController.swift
//  HealthProfiler
//

import UIKit
import MultiSlider

class HomeViewController: HPViewController {
    
    @IBOutlet var view_welcomeMessageContainer: UIView!
    @IBOutlet var label_welcomeMessageTitle: UILabel!
    
    @IBOutlet var multiSlider: MultiSlider!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupController()
    }
    
    @IBAction func buttonAction_getStarted(_ sender: UIButton) {
        
        view_welcomeMessageContainer.isHidden = true
        tabBarController?.selectedIndex = HPTabType.manageConnections.tabIndex
    }
}

//MARK: Private methods
private extension HomeViewController {
    
    private func setupController() {
        
//        multiSlider.disabledThumbIndices = [3]
//
//        if #available(iOS 13.0, *) {
//            multiSlider.minimumImage = UIImage(systemName: "moon.fill")
//            multiSlider.maximumImage = UIImage(systemName: "sun.max.fill")
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.multiSlider.value = [0.4, 2.8]
//            self.multiSlider.valueLabelPosition = .top
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.multiSlider.thumbCount = 5
//            self.multiSlider.valueLabelPosition = .right
//            self.multiSlider.isValueLabelRelative = true
//        }
        
        let horizontalMultiSlider = MultiSlider()
               horizontalMultiSlider.orientation = .horizontal
//               horizontalMultiSlider.minimumValue = 10 / 4
//               horizontalMultiSlider.maximumValue = 10 / 3
//               horizontalMultiSlider.outerTrackColor = .gray
//               horizontalMultiSlider.value = [2.718, 3.14]
//               horizontalMultiSlider.valueLabelPosition = .top
//               horizontalMultiSlider.tintColor = .purple
//               horizontalMultiSlider.trackWidth = 32
//               horizontalMultiSlider.showsThumbImageShadow = false
//               view.addConstrainedSubview(horizontalMultiSlider, constrain: .leftMargin, .rightMargin, .bottomMargin)
//               view.layoutMargins = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
//
//               multiSlider.keepsDistanceBetweenThumbs = false
//               horizontalMultiSlider.keepsDistanceBetweenThumbs = false
//               horizontalMultiSlider.valueLabelFormatter.positiveSuffix = " 𝞵s"

//               if #available(iOS 13.0, *) {
//                   horizontalMultiSlider.minimumImage = UIImage(systemName: "scissors")
//                   horizontalMultiSlider.maximumImage = UIImage(systemName: "paperplane.fill")
//               }
        
        label_welcomeMessageTitle.text = "Welcome John Doe!"
    }
}


//MARK: Public methods
extension HomeViewController {
    
}

