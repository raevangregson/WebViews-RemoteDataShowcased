//
//  ViewController.swift
//  GregsonRaevan_CE8
//
//  Created by Raevan Gregson on 12/12/16.
//  Copyright © 2016 Raevan Gregson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // I use two outlets to later reference two my two sets of data too that I take from the JSON
    
    @IBOutlet weak var titleView: UITextView!
    @IBOutlet weak var bodyView: UITextView!
    
    // I use two arrays to store one to store the key with title and its values and another to store the key that contains body and store those values
    var titles = [String]()
    var body = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        //set up the session
        let config = URLSessionConfiguration.default
        
        //create the session
        let session = URLSession(configuration: config)
        
        if let url = URL(string:"https://jsonplaceholder.typicode.com/posts"){
            
            //create the task for the session to do
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                if error != nil{
                    //error check
                    print("Data Task failed with error:\(error)")
                    return
                }
                //console will print success if all is well then another check which within I call the function to parse my JSON data
                print ("Success")
                if let http = response as? HTTPURLResponse{
                    if http.statusCode == 200{
                        self.parseJSON(data: data!)
                    }
                }
                //setup two variables where after parsing my data I can then loop through the two arrays I seperated the data into and add them each to there own string
                var text = ""
                var bodText = ""
                var num = 1
                for index in 0..<self.titles.count{
                    //to help match which title belongs to which body and that there are an even amount of both I add a num string that continues to grow with each loop
                    text += "Title \(num):\n\r\(self.titles[index])\n\r\n\r"
                    num += 1
                }
                //reset the num var
                num = 1
                for index in 0..<self.body.count{
                    bodText += "Body \(num):\n\r \(self.body[index])\n\r\n\r"
                    num += 1
                }
                //after this is done I async the info into the view and set the two UI objects (text views) to the two different string vars one for titles and one for bodys
                DispatchQueue.main.async{
                    self.titleView.text = text
                    self.bodyView.text = bodText
                }
            }
            )
            task.resume()
        }
    }
    
    //this is the function that I call in the viewdidload during the task, to be performed in the background
    private func parseJSON(data:Data){
        
        //do try check for my json deserialization to get the data object
        do{
            let json = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)
            //parse the data object into an array of dictionaries in order to reach the dictionaries that hold the key values of info
            if let rootArray = json as? [[NSObject:AnyObject]]{
                //loop through each dictionary inside of the array to get the data for each one
                for data in rootArray{
                    // then loop through those key values and look for the specific keys - or data I want the values of in this case I just take the data(values) for the title and the body keys. I then append these to my arrays which in the dispatch async in the viewdidload I turn into a singular formatted string for my two text views.
                    for (key,value) in data{
                        if key as! String == "title"{
                            titles.append(value as! String)
                        }
                        else if key as! String == "body"{
                            body.append(value as! String)
                        }
                    }
                }
            }
            
        }catch{
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
