//
//  FavoriteArticles+CoreDataProperties.swift
//  
//
//  Created by Abdelrhman Eliwa on 14/08/2021.
//
//

import Foundation
import CoreData


extension FavoriteArticles {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteArticles> {
        return NSFetchRequest<FavoriteArticles>(entityName: "FavoriteArticles")
    }

    @NSManaged public var articleDescription: String?
    @NSManaged public var articleId: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var source: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var sourceId: String?

}
