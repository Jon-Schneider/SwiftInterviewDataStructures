//
//  SinglyLinkedList+Traversal.swift
//
//
//  Created by Jon Schneider on 2/26/25.
//

import Foundation

public extension SinglyLinkedList {
    static func traverse(_ linkedList: Node, forEach: (Value) -> Void) {
        var lastNode = linkedList
        forEach(lastNode.value)

        while let next = lastNode.next {
            forEach(next.value)
            lastNode = next
        }
    }
}
