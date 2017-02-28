//
//  SecondViewController.swift
//  GregsonRaevan_CE8
//
//  Created by Raevan Gregson on 12/12/16.
//  Copyright © 2016 Raevan Gregson. All rights reserved.
//

import UIKit
import WebKit

class SecondViewController: UIViewController,WKNavigationDelegate {
    
    //here I reference my view that I drop into my viewcontroller
    @IBOutlet weak var viewItem: UIView!
    
    //variable to
    var webViewer:WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //create a webview
        let webView = WKWebView(frame: view.frame)
        
        //configure it
        webView.navigationDelegate = self
        
        //add to super view or in this case the viewItems view
        viewItem.addSubview(webView)
        
        //load a request
        if let url = NSURL(string:"https://www.google.com/"){
            webView.load(NSURLRequest(url:url as URL) as URLRequest)
            webViewer = webView
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //action for all my nav buttons, I differentiate between them by using there tag values
    @IBAction func navButtons(_ sender: UIBarButtonItem) {
        if sender.tag == 0{
            _ = webViewer?.goBack()
        }
        else if sender.tag == 1{
            _ = webViewer?.goForward()
        }
        else{
            _ = webViewer?.reload()
        }
    }
    
    //three functions that need to be called for the webview
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("started")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("failed with error \(error)")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print ("Finished")
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
