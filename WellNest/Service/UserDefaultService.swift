//
//  DataService.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import Foundation

class UserDefaultService {
    func isKeyPresent(key: UDKey) -> Bool {
        return UserDefaults.standard.object(forKey: key.rawValue) != nil
    }
    
    func getExecutedPreload() -> Bool {
        if (!isKeyPresent(key: .executePreload)) {
            UserDefaults.standard.set(true, forKey: UDKey.executePreload.rawValue)
        }
        return UserDefaults.standard.bool(forKey: UDKey.executePreload.rawValue)
    }
    
    func setExecutedPreload(_ set: Bool? = true) {
        if (isKeyPresent(key: .executePreload)) {
            UserDefaults.standard.set(set, forKey: UDKey.executePreload.rawValue)
        }
    }
    
//    
//    func add(_ item: T) {
//        var dataList = load() ?? [T]()
//        dataList.append(item)
//        saveDataList(dataList)
//    }
//    
//    // Remove item from the list
//    func remove(_ item: T) {
//        if var dataList = load(),
//           let index = dataList.firstIndex(where: { $0.id == item.id }) {
//            dataList.remove(at: index)
//            saveDataList(dataList)
//        }
//    }
//    
//    func move(from fromOffsets: IndexSet, to toOffset: Int) {
//        guard var dataList = load() else {
//            return
//        }
//        
//        dataList.move(fromOffsets: fromOffsets, toOffset: toOffset)
//        saveDataList(dataList)
//    }
//    
//    // Clear saved data
//    func clear() {
//        UserDefaults.standard.removeObject(forKey: key)
//    }
}


