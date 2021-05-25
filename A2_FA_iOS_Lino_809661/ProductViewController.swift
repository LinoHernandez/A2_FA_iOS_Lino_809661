//
//  ProductViewController.swift
//  A2_FA_iOS_Lino_809661
//
//  Created by user195794 on 5/24/21.
//

import UIKit

class ProductViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var productArray:[Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.fetchData()
        self.tableView.reloadData()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let oneRecord = productArray[indexPath.row]
        cell.textLabel!.text = oneRecord.productID! + " " + oneRecord.productName! + " " + oneRecord.productPrice! + "  " + oneRecord.productProvider! + " " + oneRecord.productDescription!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete {
            let city = productArray[indexPath.row]
            context.delete(city)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                productArray = try context.fetch(Product.fetchRequest())
            } catch {
                print(error)
            }
        }
        tableView.reloadData()
    }
    
    
    func fetchData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            productArray = try context.fetch(Product.fetchRequest())
            
        } catch {
            print(error)
        }
    }


}
