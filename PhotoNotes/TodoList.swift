//
//  TodoList.swift
//  PhotoNotes
//
//  Created by rkalvani on 2/23/17.
//  Copyright © 2017 rkalvani. All rights reserved.
//

import Foundation
import UIKit

class TodoList {
class var sharedInstance : TodoList {
    struct Static {
        static let instance: TodoList = TodoList()
    }
    return Static.instance
}

fileprivate let ITEMS_KEY = "todoItems"

func allItems() -> [TodoItem] {
    let todoDictionary = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) ?? [:]
    let items = Array(todoDictionary.values)
    return items.map({
        let item = $0 as! [String:AnyObject]
        return TodoItem(deadline: item["deadline"] as! Date, title: item["title"] as! String, UUID: item["UUID"] as! String!)
    }).sorted(by: {(left: TodoItem, right:TodoItem) -> Bool in
        (left.deadline.compare(right.deadline) == .orderedAscending)
    })
}

func addItem(_ item: TodoItem) {
    // persist a representation of this todo item in NSUserDefaults
    var todoDictionary = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) ?? Dictionary() // if todoItems hasn't been set in user defaults, initialize todoDictionary to an empty dictionary using nil-coalescing operator (??)
    todoDictionary[item.UUID] = ["deadline": item.deadline, "title": item.title, "UUID": item.UUID] // store NSData representation of todo item in dictionary with UUID as key
    UserDefaults.standard.set(todoDictionary, forKey: ITEMS_KEY) // save/overwrite todo item list
    
    // create a corresponding local notification
    let notification = UILocalNotification()
    notification.alertBody = "Todo Item \"\(item.title)\" Is Overdue" // text that will be displayed in the notification
    notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
    notification.fireDate = item.deadline as Date // todo item due date (when notification will be fired)
    notification.soundName = UILocalNotificationDefaultSoundName // play default sound
    notification.userInfo = ["title": item.title, "UUID": item.UUID] // assign a unique identifier to the notification so that we can retrieve it later
    
    UIApplication.shared.scheduleLocalNotification(notification)
}
    
}
