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
        var todoDictionary = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) ?? Dictionary()
        todoDictionary[item.UUID] = ["deadline": item.deadline, "title": item.title, "UUID": item.UUID]
        UserDefaults.standard.set(todoDictionary, forKey: ITEMS_KEY) // save/overwrite todo item list
        
        // create a corresponding local notification
        let notification = UILocalNotification()
        notification.alertBody = "Todo Item \"\(item.title)\" Is Overdue" // text that will be displayed in the notification
        notification.alertAction = "open"
        notification.fireDate = item.deadline as Date // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["title": item.title, "UUID": item.UUID] // assign a unique identifier to the notification so that we can retrieve it later
        
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    func removeItem(_ item: TodoItem) {
        let scheduledNotifications: [UILocalNotification]? = UIApplication.shared.scheduledLocalNotifications
        guard scheduledNotifications != nil else {return}
        for notification in scheduledNotifications! {
            if (notification.userInfo!["UUID"] as! String == item.UUID) {
                UIApplication.shared.cancelLocalNotification(notification)
                break
            }
        }
        
        if var todoItems = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) {
            todoItems.removeValue(forKey: item.UUID)
            UserDefaults.standard.set(todoItems, forKey: ITEMS_KEY) // save/overwrite todo item list
        }
    }
}
