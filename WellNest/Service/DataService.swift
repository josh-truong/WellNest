//
//  DataService.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import Foundation

class DataService<T: Codable & Identifiable> {
    private let key: String
    
    init(key: DSKey) {
        self.key = key.rawValue
    }
    
    // Save list of data
    func saveDataList(_ dataList: [T]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(dataList) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    // Retrieve list of data
    func loadData() -> [T]? {
        if let savedData = UserDefaults.standard.data(forKey: key),
            let loadedDataList = try? JSONDecoder().decode([T].self, from: savedData) {
            return loadedDataList
        }
        return [T]()
    }
    
    // Update item in the list
    func updateItem(item: T) {
        if var dataList = loadData(),
            let index = dataList.firstIndex(where: { $0.id == item.id }) {
            dataList[index] = item
            saveDataList(dataList)
        }
    }
    
    func addItem(_ item: T) {
        var dataList = loadData() ?? [T]()
        dataList.append(item)
        saveDataList(dataList)
    }
    
    // Remove item from the list
    func removeItem(item: T) {
        if var dataList = loadData(),
           let index = dataList.firstIndex(where: { $0.id == item.id }) {
            dataList.remove(at: index)
            saveDataList(dataList)
        }
    }
    
    // Clear saved data
    func clearData() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}


