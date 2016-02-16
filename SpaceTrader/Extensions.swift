//
//  Workaround.swift
//  DataPersist
//
//  Created by Marc Auger on 1/11/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import Foundation

extension String {
    
    var lastPathComponent: String {
        
        get {
            return (self as NSString).lastPathComponent
        }
    }
    var pathExtension: String {
        
        get {
            
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingLastPathComponent: String {
        
        get {
            
            return (self as NSString).stringByDeletingLastPathComponent
        }
    }
    var stringByDeletingPathExtension: String {
        
        get {
            
            return (self as NSString).stringByDeletingPathExtension
        }
    }
    var pathComponents: [String] {
        
        get {
            
            return (self as NSString).pathComponents
        }
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(ext: String) -> String? {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathExtension(ext)
    }
}

// patch for NSCoding enums
//protocol NSCodableEnum {
//    func int() -> Int;
//    init?(rawValue:Int);
//    init(defaultValue:Any)
//}
//extension NSCoder {
//    func encodeEnum(e:T, forKey:String) {
//        self.encodeInteger(e.int(), forKey: forKey)
//    };
//    func decodeEnum(forKey:String) -> T {
//        if let t = T(rawValue:self.decodeIntegerForKey(forKey)) {
//            return t
//        } else {
//            return T(defaultValue:0)
//        }
//    }
//}



// FROM APPLE DEV FORUM:

//// The actual values represented by this type in the
//// code below correspond to JSON. No fancy types are used.
//
//typealias Archive = Dictionary<NSString, NSCoding>
//protocol ArchivableValue {
//    static var archiveTypeName: String { get }
//    var archive: Archive { get }
//    init (archive: Archive)
//}
//
//// This is a global register for archivable types.
//// Each type capable of archiving must register itself
//// by calling the registerType function, like so:
//// registerType(Int)
//// registerType(B<Int>)
//
//var registeredTypes: [String: ArchivableValue.Type] = [:]
//func registerType(t: ArchivableValue.Type) {
//    registeredTypes[t.archiveTypeName] = t
//}
//
//// Functions for converting an ArchivableValue to Archive and back.
//
//func archiveFromValue(value: ArchivableValue) -> Archive {
//    var typedArchive: Archive = ["@type": value.dynamicType.archiveTypeName]
//    
//    for (key, value) in value.archive {
//        typedArchive[key] = value
//    }
//    
//    return typedArchive
//}
//
//func valueFromArchive(archive: Archive) -> ArchivableValue {
//    let typeName = archive["@type"] as! String
//    if let type = registeredTypes[typeName] {
//        return type.init(archive: archive) // <- probably the most fancy part
//    }
//    fatalError("Unknown type \(typeName), please register it for unarchiving with registerType(\(typeName)) call")
//}
//
//// Convenience overload, this function makes the actual archiving/unarchiving code easier to read
//
//func valueFromArchive(value: NSCoding?) -> ArchivableValue {
//    return valueFromArchive(value as! Archive)
//}
//
//// Functions for converting Archive to NSData and back
//
//func dataFromArchive(archive: Archive) -> NSData {
//    return NSKeyedArchiver.archivedDataWithRootObject(archive)
//}
//func archiveFromData(data: NSData) -> Archive {
//    return NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Archive
//}
//
//// Convenience functions for converting ArchivableValue directly to NSData and back
//
//func dataFromValue(value: ArchivableValue) -> NSData {
//    return dataFromArchive(archiveFromValue(value))
//}
//func valueFromData(data: NSData) -> ArchivableValue {
//    return valueFromArchive(archiveFromData(data))
//}
//
//
//
//
//// Below follows an actual implementation of the ArchivableValue protocol on several important types.
//// Int, String, simple Struct, generic Struct and generic Enum are covered in the examples below.
//
//// How to make existing value types archivable:
//
//extension Int: ArchivableValue {
//    static var archiveTypeName: String { return "Int" }
//    
//    var archive: Archive {
//        return ["value": self]
//    }
//    
//    init (archive: Archive) {
//        self = archive["value"] as! Int
//    }
//}
//
//extension String: ArchivableValue {
//    static var archiveTypeName: String { return "String" }
//    
//    var archive: Archive {
//        return ["value": self]
//    }
//    
//    init(archive: Archive) {
//        self = archive["value"] as! String
//    }
//}
//
//// How to make custom struct archivable:
//
//struct A: ArchivableValue {
//    static var archiveTypeName: String { return "A" }
//    
//    var a1: Int
//    var a2: String
//    
//    var archive: Archive {
//        return [
//            "a1": a1,
//            "a2": a2
//        ]
//    }
//    
//    init(a1: Int, a2: String) {
//        self.a1 = a1
//        self.a2 = a2
//    }
//    
//    init(archive: Archive) {
//        a1 = archive["a1"] as! Int
//        a2 = archive["a2"] as! String
//    }
//}
//
//// How to make custom generic struct archivable:
//
//struct B<T: ArchivableValue>: ArchivableValue {
//    var b1: Int
//    var b2: String
//    var b3: T
//    
//    init (b1: Int, b2: String, b3: T) {
//        self.b1 = b1
//        self.b2 = b2
//        self.b3 = b3
//    }
//    
//    init (archive: Archive) {
//        b1 = archive["b1"] as! Int
//        b2 = archive["b2"] as! String
//        
//        // Types that do not conform to NSCoding protocol (nor are they bridged to
//        // Cocoa class that conforms NSCoding protocol) must be encoded and decoded
//        // using the archiveFromValue and valueFromArchive functions
//        b3 = valueFromArchive(archive["b3"]) as! T
//    }
//    
//    static var archiveTypeName: String {
//        return "B<\(T.archiveTypeName)>"
//    }
//    
//    var archive: Archive {
//        return [
//            "b1": b1,
//            "b2": b2,
//            
//            // Types that do not conform to NSCoding protocol (nor are they bridged to
//            // Cocoa class that conforms NSCoding protocol) must be encoded and decoded
//            // using the archiveFromValue and valueFromArchive functions
//            "b3": archiveFromValue(b3)
//        ]
//    }
//}
//
//// How to make custom generic enum archivable:
//
//enum E<T1: ArchivableValue, T2: ArchivableValue>: ArchivableValue {
//    
//    case Option1
//    case Option2(T1, T2)
//    
//    init (archive: Archive) {
//        let tag = archive["tag"] as! String
//        
//        switch tag
//        {
//        case "Option1":
//            self = Option1
//        case "Option2":
//            
//            // Types that do not conform to NSCoding protocol (nor are they bridged to
//            // Cocoa class that conforms NSCoding protocol) must be encoded and decoded
//            // using the archiveFromValue and valueFromArchive functions
//            let e1 = valueFromArchive(archive["e1"]) as! T1
//            let e2 = valueFromArchive(archive["e2"]) as! T2
//            self = Option2(e1, e2)
//        default:
//            fatalError("Could not decode enum E, invalid tag: \(tag)")
//        }
//    }
//    
//    static var archiveTypeName: String {
//        return "E<\(T1.archiveTypeName),\(T2.archiveTypeName)>"
//    }
//    
//    var archive: Archive {
//        switch self
//        {
//        case .Option1:
//            return [
//                "tag": "Option1"
//            ]
//        case let .Option2(e1, e2):
//            return [
//                "tag": "Option2",
//                
//                // Types that do not conform to NSCoding protocol (nor are they bridged to
//                // Cocoa class that conforms NSCoding protocol) must be encoded and decoded
//                // using the archiveFromValue and valueFromArchive functions
//                "e1": archiveFromValue(e1),
//                "e2": archiveFromValue(e2)
//            ]
//        }  
//    }  
//}
//
//// This is probably the weakest point of this archiving approach.
//// Unfortunately, it is necessary to register each type that can be archived
//// and unarchived using the registerType() call.
////
//// The worst thing about this is that this may lead to combinatorial explosion
//// when dealing with many different generic structs that may be type parameterized
//// with many different other types.
////
//// As soon as Swift provides a way to construct a generic Type (metatype?) value
//// at runtime and pass it as a parameter to function, this can be simplified
//// drastically. Maybe something like Type(type: Any.Type, parameters: [Any.Type]) -> Type  ?
//
//registerType(Int)
//registerType(String)
//registerType(A)
//registerType(B<A>)
//registerType(B<Int>)
//registerType(E<Int, String>)
//registerType(B<String>)
//registerType(E<Int, B<String>>)
//
//
//// You can play with the whole system by uncommenting
//// different values below. The startValue is converted
//// into NSData, then, the NSData is converted back to
//// the original value.
//
//
////let startValue = A(a1: 4, a2: "test")
////let startValue = B(b1: 4, b2: "test", b3: A(a1: 10, a2: "inner"))
////let startValue = B(b1: 4, b2: "test", b3: 123)
////let startValue = E<Int, String>.Option2(1, "test")
//
//
//let startValue = E<Int, B<String>>.Option2(1, B(b1: 4, b2: "test", b3: "test2"))
//let data: NSData = dataFromValue(startValue)
//let endValue = valueFromData(data)
//
//print(endValue)

//extension NSCoder {
//    func encodeObject(objv: AnyObject?, forKey key: DifficultyType) {
//        self.encodeObject(objv, forKey:key.rawValue)
//    }
//}