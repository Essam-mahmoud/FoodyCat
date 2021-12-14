
import UIKit
import SwiftyJSON

struct CodableHandler {
    
    static func decode<T : Decodable>(_ type: T.Type, from jsonObject: JSON) -> Any?
    {
        do {
            let data = jsonObject.description.data(using: .utf8)
            let jsonDecoder = JSONDecoder()
            let contactModel = try jsonDecoder.decode( type,from: data ??  Data() )
            return contactModel
        }catch let caught as NSError {
            print(caught)
            return nil
        }
    }
    
    
    
    static func encode<T : Encodable>(_ type: T) -> [String : Any]?
    {
        do{
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(type)
            let jsonEncode =  try JSONSerialization.jsonObject(with: jsonData) //String(data: jsonData, encoding: .utf8) ?? ""
            return jsonEncode as? [String : Any]
        }catch let caught as NSError {
            print(caught)
            return nil
        }
        
    }
    
    
    static func decodeClass<T : Decodable>(_  type: T.Type , classJsonData : JSON) -> Any?{
        

//        do {
//
//            let productDetail = try? JSONDecoder().decode(type.self, from: classJsonData.rawData())
//
//        } catch let jsonError {
//
//            print("Error serializing json:", jsonError)
//        }
//
        let decoder = JSONDecoder()
        let modelClass = try? decoder.decode(type.self, from: classJsonData.rawData())
        
        return modelClass ?? nil
        
    }
    
    
    
    
    
}

// Type Eraser
class Dynamic<T>: Codable where T: Codable {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        self.listener?(self.value)
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private enum CodingKeys: CodingKey {
        case value
    }
    
}
