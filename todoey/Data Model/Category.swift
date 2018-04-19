//
//  Category.swift
//  todoey
//
//  Created by alwyn tablatin on 19/04/2018.
//  Copyright © 2018 alwyn tablatin. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
