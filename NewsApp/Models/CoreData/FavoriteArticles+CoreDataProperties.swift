//
//  FavoriteArticles+CoreDataProperties.swift
//  
//
//  Created by Abdelrhman Eliwa on 11/08/2021.
//
//

import Foundation
import CoreData


extension FavoriteArticles {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteArticles> {
        return NSFetchRequest<FavoriteArticles>(entityName: "FavoriteArticles")
    }

    @NSManaged public var articleId: String?
    @NSManaged public var articles: NSSet?

}

// MARK: Generated accessors for articles
extension FavoriteArticles {

    @objc(addArticlesObject:)
    @NSManaged public func addToArticles(_ value: Articles)

    @objc(removeArticlesObject:)
    @NSManaged public func removeFromArticles(_ value: Articles)

    @objc(addArticles:)
    @NSManaged public func addToArticles(_ values: NSSet)

    @objc(removeArticles:)
    @NSManaged public func removeFromArticles(_ values: NSSet)

}
