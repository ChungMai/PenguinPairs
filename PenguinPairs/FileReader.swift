//
//  FileReader.swift
//  PenguinPairs
//
//  Created by MacMini on 8/19/16.
//  Copyright © 2016 Home. All rights reserved.
//

import SpriteKit

class FileReader{
    var content : [String] = []
    var it = -1
    init(fileNamed : String){
        let filePath = Bundle.main.path(forResource: fileNamed, ofType: "txt")
        let data = try! String(contentsOfFile: filePath!, encoding: String.Encoding.utf8)
        content = data.components(separatedBy: "\n")
    }
    
    func nextLine() ->String{
        if it > (content.count - 1){
            return ""
        }
        else{
            it += 1;
            return content[it]
        }
    }
    
}
