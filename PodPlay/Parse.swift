//
//  Parse.swift
//  PodPlay
//
//  Created by Nishanth P on 2/12/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import Foundation

class Parse{
    
    func getPodData(data:Data) -> (title:String?,imageURL:String?) {
       
        let xml = SWXMLHash.parse(data)
        
        
        print(xml["rss"]["channel"]["title"].element?.text)
        print(xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)
        return (xml["rss"]["channel"]["title"].element?.text,xml["rss"]["channel"]["itunes:image"].element?.attribute(by: "href")?.text)
    }
}
