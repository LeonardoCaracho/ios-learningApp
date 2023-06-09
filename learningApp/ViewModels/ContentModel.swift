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
    
    // Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current Question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // Current lesson explanation
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    // Current selected content and text
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int?
    
    init() {
        getLocalData()
        getRemoteData()
    }
    
    
    // MARK: - Data methods
    
    func getRemoteData() {
        let urlString = "https://codewithchris.github.io/learningJSON/data.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return
            }
            
            let modules = self.jsonDecode(url: url!)
            
            DispatchQueue.main.async {
                self.modules += modules
            }
        }.resume()
    }
    
    func getLocalData() {
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        let modules = self.jsonDecode(url: jsonUrl!)
        
        self.modules = modules
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        }
        catch {
            print("Couldn't parse style data")
        }
    }
    
    private func jsonDecode(url:URL) -> [Module] {
        do {
            let jsonData = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            
            return try jsonDecoder.decode([Module].self, from: jsonData)
        }
        catch {
            print(error)
            return []
        }
    }
    
    // MARK: - Module navigation methods
    
    func beginModule(_ moduleId:Int) {
        currentModule = modules.first {
            $0.id == moduleId
        }
    }
    
    func beginLesson(_ lessonIndex:Int) {
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func hasNextLesson() -> Bool {
        guard currentModule != nil else {
            return false
        }
        return (currentLessonIndex + 1) < currentModule!.content.lessons.count
    }
    
    func nextLesson() {
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        } else {
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func beginTest(_ moduleId:Int) {
        beginModule(moduleId)
        
        currentQuestionIndex = 0
        
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            
            codeText = addStyling(currentQuestion!.content);
        }
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        
        if currentQuestionIndex < currentModule!.test.questions.count {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        } else {
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    // MARK: - Code styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        
        if styleData != nil {
            data.append(styleData!)
        }
        
        data.append(Data(htmlString.utf8))
        
        if let attributeString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        ) {
            resultString = attributeString
        }
        
        return resultString
    }
}
