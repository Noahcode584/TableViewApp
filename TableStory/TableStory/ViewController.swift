//
//  ViewController.swift
//  TableStory
//
//  Created by Noah Trevino on 3/19/25.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "A Bronx Tale", neighborhood: "Downtown", desc: "A coming-of-age crimge drama about a young boy torn between his hardworking father and a charismatic mob boss.", lat: 40.7704, long: -73.9301, imageName: "abt"),
    Item(name: "Selena", neighborhood: "Hyde Park", desc: "A biographical drama that tells the inspiring and tragic story of Selena Quintanilla, a beloved Mexican-American singer.", lat: 29.4252, long: -98.4946, imageName: "sel"),
    Item(name: "Halloween 4: The Return of Michael Myers", neighborhood: "Mueller", desc: "This movie picks up ten years after the events of the original Hallowen films. Michael espcapes from a psychiatric institution and returns to Haddonfield to hunt down his neice, Jamie Lloyd.", lat: 40.7606, long: -111.8881, imageName: "hallow"),
    Item(name: "Poetic Justice", neighborhood: "UT", desc: "A romantic drama that follows a young woman named Justice who lost her boyfriend due to gang violence. Through her work as a hairdresser and her passion for poetry, she forms a unlikely bond with a mailman named Lucky who Tupac Shakur plays. ", lat: 37.8044, long: -122.2712, imageName: "pjustice"),
    Item(name: "The Terminator", neighborhood: "Hyde Park", desc: "A sci-fi thriller thats about a cyborg assasin sent from the future to kill Sarah Connor, whose unborn son will one day lead humanity's resistance against a machine uprising.", lat: 34.0549, long: -118.2426, imageName: "tterm")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}


class ViewController:UIViewController,
UITableViewDelegate, UITableViewDataSource
 {

    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      
      
      //Add image references
      let image = UIImage(named: item.imageName)
      cell?.imageView?.image = image
      cell?.imageView?.layer.cornerRadius = 10
      cell?.imageView?.layer.borderWidth = 5
      cell?.imageView?.layer.borderColor = UIColor.white.cgColor
      
      return cell!
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let item = data[indexPath.row]
       performSegue(withIdentifier: "ShowDetailSegue", sender: item)
     
   }
    // add this line in the class declaration of the DetailViewController to reference the Item struct.
                 var item: Item?

           // add this function to original ViewController
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowDetailSegue" {
                 if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                     // Pass the selected item to the detail view controller
                     detailViewController.item = selectedItem
                 }
             }
         }
         
             
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        
        //add this code in viewDidLoad function in the original ViewController, below the self statements
        
        //set center, zoom level and region of the map
        let coordinate = CLLocationCoordinate2D(latitude: 38.7946, longitude: -106.5348)
        let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 17, longitudeDelta: 17))
        mapView.setRegion(region, animated: true)
        
        // loop through the items in the dataset and place them on the map
        for item in data {
            let annotation = MKPointAnnotation()
            let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
            annotation.coordinate = eachCoordinate
            annotation.title = item.name
            mapView.addAnnotation(annotation)
        }
        
        
    }


}

