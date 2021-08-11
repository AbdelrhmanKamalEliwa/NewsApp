//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Abdelrhman Eliwa on 11/08/2021.
//

import UIKit
import CoreData

class CoreDataManager {
    // MARK: - Properties
    private let defaults = UserDefaults.standard
    private var managedContext: NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            return managedContext
        } else {
            return nil
        }
    }
    
    // MARK: - Methods
    
    /// This function helps you to load the cached atricles
    /// - Returns: optional list of Articles and optional Error
    func loadArticles() -> ([Articles]?, Error?) {
        guard let managedContext = managedContext else { return (nil, nil) }
        let fetchRequest = NSFetchRequest<Articles>(entityName: "Articles")
        do {
            let articles = try managedContext.fetch(fetchRequest)
            return (articles, nil)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return (nil, error)
        }
    }
    
    /// This function helps you to cache atricles
    /// - Parameters:
    ///   - articles: array of Articles
    ///   - pageIndex: page index for pagination
    /// - Returns: optional Error
    func cachArticlesData(_ articles: [ArticleModel], pageIndex: Int) -> Error? {
        if
            let articlesCachStatus = defaults.object(forKey: "ArticlesCachingStatus") as? Bool,
            let articlesCachingStatusPageIndex =  defaults.object(forKey: "ArticlesCachingStatusPageIndex") as? Int {
            
            if articlesCachStatus, pageIndex == articlesCachingStatusPageIndex {
                let result = updateArticles(articles)
                defaults.setValue(true, forKey: "ArticlesCachingStatus")
                return result
            } else {
                let result = saveArticles(articles)
                defaults.setValue(true, forKey: "ArticlesCachingStatus")
                defaults.setValue(pageIndex, forKey: "ArticlesCachingStatusPageIndex")
                return result
            }
        } else {
            let result = saveArticles(articles)
            defaults.setValue(true, forKey: "ArticlesCachingStatus")
            defaults.setValue(pageIndex, forKey: "ArticlesCachingPageIndex")
            return result
        }
    }
    
    /// This function helps you to save atricles
    /// - Parameter articles: array of Articles
    /// - Returns: optional Error
    private func saveArticles(_ articles: [ArticleModel]) -> Error? {
        guard let managedContext = managedContext else { return nil }
        for article in articles {
            let newArticle = NSEntityDescription.insertNewObject(
                forEntityName: "Articles", into: managedContext
            )
            newArticle.setValue(article.title, forKeyPath: "title")
            newArticle.setValue(article.description, forKeyPath: "articleDescription")
            newArticle.setValue(article.source.name, forKeyPath: "source")
            newArticle.setValue(article.publishedAt, forKeyPath: "publishedAt")
            newArticle.setValue(article.urlToImage, forKeyPath: "urlToImage")
            newArticle.setValue(article.url, forKeyPath: "url")
        }
        do {
            try managedContext.save()
            return nil
        } catch {
            print(error)
            return error
        }
    }
    
    /// This function helps you to update cached atricles
    /// - Parameter articles: array of Articles
    /// - Returns: optional Error
    private func updateArticles(_ articles: [ArticleModel]) -> Error? {
        guard let managedContext = managedContext else { return nil }
        let request = NSFetchRequest<Articles>(entityName: "Articles")
        do {
            if let result = try? managedContext.fetch(request) {
                for i in 0...result.count - 1 {
                    result[i].setValue(articles[i].title, forKeyPath: "title")
                    result[i].setValue(articles[i].description, forKeyPath: "articleDescription")
                    result[i].setValue(articles[i].source.name, forKeyPath: "source")
                    result[i].setValue(articles[i].publishedAt, forKeyPath: "publishedAt")
                    result[i].setValue(articles[i].urlToImage, forKeyPath: "urlToImage")
                    result[i].setValue(articles[i].url, forKeyPath: "url")
                }
            }
            try managedContext.save()
            return nil
        } catch {
            print(error)
            return error
        }
    }
}
