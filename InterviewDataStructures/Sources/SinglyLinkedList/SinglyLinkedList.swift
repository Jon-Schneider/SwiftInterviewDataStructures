//
//  SinglyLinkedList.swift
//  
//
//  Created by Jon Schneider on 2/25/25.
//

import Foundation

public class SinglyLinkedList<Value: Equatable> {
    // I would prefer to define Nodes as structs and use inout functions to mutate the structure of linked list so the linked list can be a value type but value types cannot recursively use themselves
    // There are workarounds, but making Node a class is cleaner
    public class Node {
        public let value: Value
        public var next: Node?

        public init(value: Value, next: Node? = nil) {
            self.value = value
            self.next = next
        }
    }

    // Start and end node references for class instances
    var startNode: Node?
    var endNode: Node?

    public init(value: Value? = nil) {
        if let value {
            append(value)
        }
    }
}
