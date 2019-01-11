//
//  Favorite.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 1/10/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import CoreData

final class Favorite: NSManagedObject {
    @NSManaged var author: String?
    @NSManaged var title: String?
    @NSManaged var descriptions: String?
    @NSManaged var url: String?
    @NSManaged var urlToImage: String?
    @NSManaged var publishedAt: String?
    @NSManaged var content: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(article: Article, insertInto context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: context)
        super.init(entity: entity!, insertInto: context)
        author = article.author
        title = article.title
        descriptions = article.description
        url = article.url
        urlToImage = article.urlToImage
        publishedAt = article.publishedAt
        content = article.content
    }
}
