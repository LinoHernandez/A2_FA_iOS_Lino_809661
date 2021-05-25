//
//  ViewController.swift
//  A2_FA_iOS_Lino_809661
//
//  Created by user195794 on 5/24/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var provider: UILabel!
    @IBOutlet weak var pdescription: UILabel!
    @IBOutlet weak var searchBttn: UITextField!
    @IBOutlet weak var searchResult: UILabel!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveBtn(_ sender: UIButton) {
        
        let idPro = self.id!.text
        let namePro = self.name!.text
        let pricePro = self.price!.text
        let provPro = self.provider!.text
        let descripPro = self.pdescription!.text
        
        if (idPro?.isEmpty)!{
            self.id.layer.borderColor = UIColor.blue.cgColor
            return
        } else {
            self.id.layer.borderColor = UIColor.black.cgColor
        }
        
        if (namePro?.isEmpty)!{
            self.name.layer.borderColor = UIColor.blue.cgColor
            return
        } else {
            self.name.layer.borderColor = UIColor.black.cgColor
        }
        
        if (pricePro?.isEmpty)!{
            self.price.layer.borderColor = UIColor.blue.cgColor
            return
        } else {
            self.price.layer.borderColor = UIColor.black.cgColor
        }
        
        if (provPro?.isEmpty)!{
            self.provider.layer.borderColor = UIColor.blue.cgColor
            return
        } else {
            self.provider.layer.borderColor = UIColor.black.cgColor
        }
        
        if (descripPro?.isEmpty)!{
            self.pdescription.layer.borderColor = UIColor.blue.cgColor
            return
        } else {
            self.pdescription.layer.borderColor = UIColor.black.cgColor
        }
        
        let nwProduct = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context)
        nwProduct.setValue(self.id!.text, forKey: "productID")
        nwProduct.setValue(self.name!.text, forKey: "productName")
        nwProduct.setValue(self.price, forKey: "productPrice")
        nwProduct.setValue(self.provider, forKey: "productProvider")
        nwProduct.setValue(self.pdescription, forKey: "productDescription")
        
        do {
            try context.save()
            self.id!.text = ""
            self.name!.text = ""
            self.price!.text = ""
            self.provider!.text = ""
            self.pdescription!.text = ""
        } catch {
            print(error)
        }
                
    }
    
    @IBAction func searchBtn(_ sender: UIButton) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        let searchProduct = self.searchBttn?.text
        
        request.predicate = NSPredicate(format: "productName == %@", searchProduct!)
        
        var productPut = ""
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                for online in result {
                    let firstID = (online as AnyObject).value(forKey: "productID") as! String
                    let firstName = (online as AnyObject).value(forKey: "productName") as! String
                    let firstPrice = (online as AnyObject).value(forKey: "productPrice") as! String
                    let firstProvider = (online as AnyObject).value(forKey: "productProvider") as! String
                    let firstDescrip = (online as AnyObject).value(forKey: "productDescription") as! String
                    
                    productPut += firstID + "" + firstName + "" + firstPrice + "" + firstProvider + "" + firstDescrip + "\n"
                }
            } else {
                productPut = "No product found"
            }
            self.searchResult?.text = productPut
        } catch {
            print(error)
        }
    }
    
    
}

