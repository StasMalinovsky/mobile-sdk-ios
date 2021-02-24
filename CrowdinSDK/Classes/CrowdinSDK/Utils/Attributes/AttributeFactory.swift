//
//  AttributeFactory.swift
//  CrowdinSDK
//
//  Created by Nazar Yavornytskyy on 2/19/21.
//

import Foundation

struct AttributeFactory {

    static func make(_ attribute: LogAttribute) -> NSAttributedString {
        let empty = "Empty"
        let title = attribute.title
        
        switch attribute {
        case let .url(url):
            let text = url.isEmpty ? empty : url
            
            return AttributeFactory.attributeWithTitle(title, text)
        case let .method(method):
            let text = method.isEmpty ? empty : method
            
            return AttributeFactory.attributeWithTitle(title, text)
        case let .parameters(dictionary), let .headers(dictionary):
            let text = dictionary?.description ?? empty
            
            return AttributeFactory.attributeWithTitle(title, text)
        case let .requestBody(body), let .responseBody(body):
            var bodyText = empty
            if let bodyData = body {
                bodyText = bodyData.prettyJSONString ?? empty
            }
            
            return AttributeFactory.attributeWithTitle(title, bodyText)
        case .newLine:
            return NSAttributedString(string: "\n")
        case .separator:
            return NSAttributedString(string: "\n\n\n")
        }
    }
    
    static func attributeWithTitle(_ title: String, _ text: String) -> NSAttributedString {
        let titleAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.blue]
        
        let attribute = NSAttributedString(string: text)
        let attributes = NSMutableAttributedString(string: title, attributes: titleAttribute)
        attributes.append(AttributeFactory.make(.newLine))
        attributes.append(attribute)
        attributes.append(AttributeFactory.make(.newLine))
        
        return attributes
    }
}
