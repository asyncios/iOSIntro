//
//  NewsDetailViewController.swift
//  NewApp
//
//  Created by josue cadillo on 3/31/17.
//  Copyright © 2017 FandangoLatam. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    static let IDENTIFIER_NAME = "NewsDetailViewController"
    
    var newsUrl = ""
    
    @IBOutlet var newsWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.newsWebView.delegate = self
        self.newsWebView.isHidden = false
        
        if newsUrl == ""{
            NewsServerController.sharedInstance.getTopNews(start: {
                
            }, completed: { (url) in
                self.newsUrl=url
                if let pUrl = URL(string: self.newsUrl){
                    self.newsWebView.loadRequest(URLRequest(url: pUrl))
                }
            }, error: { (errorString) in
                
            })
        }
        else{
            if let pUrl = URL(string: newsUrl){
                newsWebView.loadRequest(URLRequest(url: pUrl))
            }
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

extension NewsDetailViewController: UIWebViewDelegate {
    
}
