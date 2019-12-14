//
//  userData.swift
//  test
//
//  Created by Mac Mini on 12/8/19.
//  Copyright © 2019 Mac Mini. All rights reserved.
//

import Foundation

class userData : NSObject,NSCoding
{
    let ref1 : String
    let ref2 : String
    let postcode : String
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let ref1 = aDecoder.decodeObject(forKey: "ref1") as? String,
        let ref2 = aDecoder.decodeObject(forKey: "ref2") as? String,
        let postcode = aDecoder.decodeObject(forKey: "postcode") as? String
            else {return nil}
        self.init(x: ref1, y: ref2, z: postcode)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(ref1, forKey : "ref1")
        aCoder.encode(ref2, forKey : "ref2")
        aCoder.encode(postcode, forKey : "postcode")
    }
    
    init (x : String, y : String, z : String)
    {
        self.ref1 = x;
        self.ref2 = y;
        self.postcode = z;
    }
    
}
