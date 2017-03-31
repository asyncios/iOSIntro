//
//  NewsDetail+CoreDataProperties.swift
//  
//
//  Created by josue cadillo on 3/31/17.
//
//

import Foundation
import CoreData


extension NewsDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsDetail> {
        return NSFetchRequest<NewsDetail>(entityName: "NewsDetail");
    }

    @NSManaged public var newsUrl: String?

}
