//
//  ContentModel.swift
//  learningApp
//
//  Created by Leonardo Caracho on 11/03/23.
//

import Foundation

class ContentModel: ObservableObject {
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    
    // MARK: - Data methods
    
    func getLocalData() {
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            let jsonDecoder = JSONDecoder()
            
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            self.modules = modules
        }
        catch {
            print("Couldn't parse local data")
        }
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        }
        catch {
            print("Couldn't parse style data")
        }
    }
    
    // MARK: - Module navigation methods
    
    func beginModule(_ moduleId:Int) {
        currentModule = modules.first {
            $0.id == moduleId
        }
    }
}
