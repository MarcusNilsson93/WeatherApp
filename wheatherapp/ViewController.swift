//
//  ViewController.swift
//  wheatherapp
//
//  Created by Marcus Nilsson on 2020-02-05.
//  Copyright © 2020 Marcus Nilsson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
// Array med städer
    let citys = ["Arvika","Askersund","Avesta","Boden","Bollnäs","Borgholm","Borlänge","Borås","Bro","Båstad","Djursholm","Eksjö","Eskilstuna","Fagersta","Falkenberg","Falköping","Falun","Filipstad","Gränna","Gävle","Hagfors","Halmstad","Haparanda","Hedemora","Helsingborg","Hjo","Hudiksvall","Huskvarna","Härnösand","Hässleholm","Jönköping","Kalmar","Karlshamn","Karlskoga","Karlskrona","Karlstad","Katrineholm","Kiruna","Kramfors","Kristianstad","Kristinehamn","Kumla","Kungsbacka","Kungsholmen","Kungälv","Laholm","Landskrona","Lidingö","Lindesberg","Linköping","Ljungby","Ludvika","Luleå","Lund","Lycksele","Lysekil","Mariefred","Mariestad","Marstrand","Motala","Nacka","Nora","Norrköping","Nybro","Nyköping","Nynäshamn","Öregrund","Örnsköldsvik","Oskarshamn","Östersund","Östhammar","Oxelösund","Ronneby","Sala","Sandviken","Sigtuna","Simrishamn","Skara","Skellefteå","Skänninge","Skövde","Sollefteå","Solna","Stockholm","Strängnäs","Strömstad","Sundbyberg","Sundsvall","Säffle","Säter","Sävsjö","Tidaholm","Torshälla","Tranås","Trelleborg","Trosa","Uddevalla","Ulricehamn","Uppsala","Vadstena","Varberg","Vaxholm","Vetlanda","Vimmerby","Visby","Vänersborg","Värnamo","Västervik","Växsjö","Ystad"]
    
    var searchCity = [String]()
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchCity.count
        }else{
            return 10
        }
    }
    //TableView setUp
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // tableViewCell -> MakkansCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as?
        CustomTableViewCell
       
        if searching{
            cell?.myCityLable.text = searchCity[indexPath.row]
        }else{
            cell?.myCityLable.text = citys[indexPath.row]
 
        }
            return cell!
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // kollar vilken array som används i tableviewn och ser till att man får
        //Värde med sig till nästa View
        if searching{
            self.performSegue(withIdentifier: "toDetailView", sender: self)
            print("You selected cell #\(searchCity[indexPath.row])!")
        }else{
            self.performSegue(withIdentifier: "toDetailView", sender: self)
            print("You selected cell #\(citys[indexPath.row])!")
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if searching{
            if segue.identifier == "toDetailView" {
            let detailVC = segue.destination as! DetailViewController
            let selectedRowIndex = self.tableView.indexPathForSelectedRow
            detailVC.specCity = searchCity[selectedRowIndex!.row]
            
        }
        
    }
        if(searching == false){
            if segue.identifier == "toDetailView" {
            let detailVC = segue.destination as! DetailViewController
            let selectedRowIndex = self.tableView.indexPathForSelectedRow
            detailVC.specCity = citys[selectedRowIndex!.row]
            }
        
        }

    }
    
}
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        searchCity = citys.filter({$0.prefix(searchText.count) == searchText})

        if searchText == "" {
            searching = false
        } else {
            searching = true
        }
        tableView.reloadData()
    }
}


