//
//  NewsServerController.swift
//  NewApp
//
//  Created by josue cadillo on 3/30/17.
//  Copyright © 2017 FandangoLatam. All rights reserved.
//

import UIKit
import CoreData

class NewsServerController: NSObject {

    static let sharedInstance = NewsServerController()
    
    var serviceApi : AlamoServiceApi
    var coreDataApi : CoreDataApi
    
    required override init() {
        serviceApi = AlamoServiceApi()
        coreDataApi = CoreDataApi()
    }
    
    func getNews(start: @escaping ()->Void,
                 completed: @escaping ([News])->Void,
                 error: @escaping (String)->Void) {
        
        let url = "https://api.myjson.com/bins/zvw1r"
        serviceApi.setUrl(url: url)
        serviceApi.execute(start: {
            
            start()
            
        }, completed: { (response) in
            
            let newsArray = NewsUtil.getNews(newsString: response)
            completed(newsArray)
            
        }) { (errorString) in
            error(errorString)
            
        }
    }
    
    func getTopNews(start: @escaping ()->Void,
                    completed: @escaping (String)->Void,
                    error: @escaping (String)->Void){
        coreDataApi.setEnitity(entityString: "NewsDetail")
        let firstTime = UserDefaults.standard.bool(forKey: "FirstTimeCoreData")
        if firstTime == false {
            coreDataApi.save(key: "newsUrl", value: "https://www.fandango.lat/pe/noticias/marvel-se-vienen-grandes-cambios-para-los-x-men-dentro-de-los-comics-28464")
            UserDefaults.standard.set(true, forKey: "FirstTimeCoreData")
        }
        
        
        coreDataApi.execute(start: {
            
        }, completed: { (array) in
            if let newsUrl = array.first?.value(forKey: "newsUrl") as? String
            {
                completed(newsUrl)
            }
        }) { (errorString) in
            error(errorString)
        }
        
    }
}
