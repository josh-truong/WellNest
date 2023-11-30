//
//  DataService.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import Foundation

class DataService<T: Codable> {
    private let key: String
    
    init(key: String) {
        self.key = key
    }
    
    // Save list of data
    func saveDataList(_ dataList: [T]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(dataList) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    // Retrieve list of data
    func loadListData() -> [T]? {
        if let savedData = UserDefaults.standard.data(forKey: key),
            let loadedDataList = try? JSONDecoder().decode([T].self, from: savedData) {
            return loadedDataList
        }
        return nil
    }
    
    // Update item in the list
    func updateItem(updatedItem: T, atIndex index: Int) {
        if var dataList = loadListData(), index < dataList.count {
            dataList[index] = updatedItem
            saveDataList(dataList)
        }
    }
    
    // Remove item from the list
    func removeItem(atIndex index: Int) {
        if var dataList = loadListData(), index < dataList.count {
            dataList.remove(at: index)
            saveDataList(dataList)
        }
    }
    
    // Clear saved data
    func clearData() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}


