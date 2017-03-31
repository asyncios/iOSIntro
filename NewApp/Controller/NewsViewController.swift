//
//  NewsViewController.swift
//  NewApp
//
//  Created by josue cadillo on 3/30/17.
//  Copyright © 2017 FandangoLatam. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    var newsArray = [News]()
    var errorString = ""
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        NewsServerController.sharedInstance.getNews(start: {
            
        }, completed: { (newsArray) in
            self.newsArray = newsArray
            self.tableView.reloadData()
            
        }) { (error) in
            self.errorString = error
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

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = (self.storyboard?.instantiateViewController(withIdentifier: NewsDetailViewController.IDENTIFIER_NAME) as?
                    NewsDetailViewController)
        {
            let news = newsArray[indexPath.row]
            vc.newsUrl = NewsUtil.getNewsUrl(newsId: Util.numberToString(pObject: news.newsId) ?? "", titleSlug: news.titleSlug ?? "")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension NewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = (tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.NIB_NAME, for: indexPath) as? NewsTableViewCell)
        {
            cell.setData(news: newsArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
