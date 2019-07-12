//
//  main.swift
//  cloctotc
//
//  Created by Eric Marchand on 10/07/2019.
//  Copyright © 2019 phimage. All rights reserved.
//

import Foundation

func usage(progname: String) {
    print("Usage: \((progname as NSString).lastPathComponent) <file>\n")
    exit(1)
}

guard let path = CommandLine.arguments.dropFirst().first else {
    usage(progname: CommandLine.arguments.first ?? "cloctotc")
    exit(1)
}

let data = try Data(contentsOf: URL(fileURLWithPath: path))

// MARK: Model
/*
struct Header: Decodable {
    var cloc_url           : String
    var cloc_version       : String
    var elapsed_seconds    : Double
    var n_files            : Int
    var n_lines            : Int
    var files_per_second   : Double
    var lines_per_second   : Double
}*/

struct Type {
    var nFiles : Int
    var blank: Int
    var comment: Int
    var code: Int
}

struct Cloc {

    /*var header: Header*/
    var types: [String: Type]

}

// MARK: Model decodable

extension Type: Decodable {}
//extension Header: Decodable {}

struct DynamicKey: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    var intValue: Int? { return nil }
    init?(intValue: Int) { return nil }
}
extension KeyedDecodingContainer where Key == DynamicKey {

    func decode<T: Decodable>(_ type: T.Type) -> [String: T] {
        var dict = [String: T]()
        for key in allKeys {
            if let v = try? decode(T.self, forKey: key) {
                dict[key.stringValue] = v
            } else {
                // print("Key \(key.stringValue) type not supported")
            }
        }
        return dict
    }

}

extension Cloc: Decodable {

    /*enum ClocCodingKey: String, CodingKey { // declaring our keys
        case header = "header"
    }*/

    init(from decoder: Decoder) throws {
        let dynamicContainer = try decoder.container(keyedBy: DynamicKey.self)
        types = dynamicContainer.decode(Type.self)

        /*let container = try decoder.container(keyedBy: ClocCodingKey.self)
        header = try container.decode(Header.self, forKey: .header)*/
    }
}



var cloc: Cloc = try JSONDecoder().decode(Cloc.self, from: data)


///print("\(cloc)")
print("<build>")
for (language, type) in cloc.types {
    print("<statisticValue key=\"\(language)(code)\" value=\"\(type.code)\"/>")
    print("<statisticValue key=\"\(language)(comment)\" value=\"\(type.comment)\"/>")
    print("<statisticValue key=\"\(language)(blank)\" value=\"\(type.blank)\"/>")
    print("<statisticValue key=\"\(language)(nFiles)\" value=\"\(type.nFiles)\"/>")
}
print("</build>")
