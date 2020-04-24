//
//  LoginViewController.swift
//  HealthProfiler
//
//  Created by Pandey, Pooja on 20/04/20.
//  Copyright © 2020 Pandey, Pooja. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    @IBOutlet var bottomView:UIView!
    @IBOutlet var tableViewLogin: UITableView!
    @IBOutlet var bottomLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
      //  provideGesturetoLabel()
        // Do any additional setup after loading the view.
    }
    
    func provideGesturetoLabel(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("privacyPolicyTapped:")))
        gestureRecognizer.delegate = self
        bottomLabel?.isUserInteractionEnabled = true
        bottomLabel?.addGestureRecognizer(gestureRecognizer)
    }
    
  func privacyPolicyTapped(gestureRecognizer: UIGestureRecognizer) {
        print("privacy policy tapped")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 3
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.row == 0 || indexPath.row == 1 {
           return 70
         } else if indexPath.row == 3 {
             return 40
         } else {
             return 200
         }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           switch  indexPath.row {
           case 0...1:
             let cell = tableView.dequeueReusableCell(withIdentifier: "LoginViewCellID") as! LoginViewCell
             cell.loginTextField.delegate = self
             cell.loginTextField.tag = indexPath.row

             if indexPath.row == 0 {
                 cell.iconImageView.image = UIImage(named: "user-icon")
             }
             if indexPath.row == 1 {
                cell.loginTextField.placeholder = "Password"
                 cell.iconImageView.image = UIImage(named: "password-icon")
                cell.loginTextField.isSecureTextEntry = true
                cell.loginTextField.returnKeyType = .done

             }
                          return cell
             
           default:
               let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCellID") as! ButtonTableViewCell
               //cell.loginButton.setTitle(arrayElements[indexPath.row], for: .normal)
              
                // if indexPath.row == 3 {
                 //    cell.loginButton.backgroundColor = UIColor.clear
                 //    cell.loginButton.setTitleColor(UIColor.black, for: .normal)
                // }else if indexPath.row == 2 {
                 //     cell.loginButton.addTarget(self, action: #selector(showLogin), for: .touchUpInside)
                // }  else if indexPath.row == 4 {
                     
                  //   cell.loginButton.addTarget(self, action: #selector(showNext), for: .touchUpInside)
              // }
                            return cell
           }
          
          // return UITableViewCell()
      }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       /*  if indexPath.row == 4 {
             performSegue(withIdentifier: "showRegister", sender: self)
         } else if indexPath.row == 2 {
             performSegue(withIdentifier: "showDashboardSegue", sender: self)
         }*/
     }
    
    // TextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let txtField1 = self.view.viewWithTag(textField.tag + 1) as? UITextField {
           txtField1.becomeFirstResponder()
        } else {
           // Not found, so remove keyboard.
           textField.resignFirstResponder()
        
        }
    return false

    }

}

