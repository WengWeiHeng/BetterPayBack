//
//  MenuViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/29.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit
import Firebase
import CoreData

var passwordUpDate:String = ""

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser {
            if let controller = storyboard?.instantiateViewController(withIdentifier: "password"){
                present(controller, animated: true, completion: nil)
            }
            
            let userName = String(user.displayName ?? "none")
            
            getPassword(uN:userName)
            
            print("nowUserName:\(userName)")
            print("passwordTest:\(passwordTest)")
            
        }
        
    }
    
    func getPassword(uN:String){
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let moc = context
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PassWord")
        //search条件
        let searchContent = NSPredicate(format: "userName = '\(uN)'")
        fetchRequest.predicate = searchContent
        
        do{
            //結果をresultsに入れる
            let results = try moc.fetch(fetchRequest) as! [PassWord]
            for info in results{
                passwordTest = info.password ?? "xxxxxx"
            }
            
        }catch{
            print("get user,password error(PasswordViewController)")
        }
    }
    

    @IBAction func btnLoginTapped(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "login"){
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnRegisterTapped(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "register"){
            present(controller, animated: true, completion: nil)
        }
    }
    
}
