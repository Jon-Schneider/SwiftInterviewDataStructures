//
//  File.swift
//  
//
//  Created by Jon Schneider on 2/26/25.
//

import Foundation

public extension SinglyLinkedList {
    
    /// Appends value to end of LinkedList
    /// - Parameters:
    ///   - value: Value to be appended to end of list. values are not checked for duplicates
    ///   - linkedList: The head node of the linked list the value should be appended to
    /// - Returns: The head of the linked list after appending the new value
    static func append(_ value: Value, to linkedList: Node) {
        // TODO: Check duplicate state

        var lastNode = linkedList
        while let next = lastNode.next {
            lastNode = next
        }

        lastNode.next = Node(value: value)
    }

    /// Deletes value (if present) from linked list
    /// - Parameters:
    ///   - value: Value to be deleted from the list. If the value appears multiple times in the linked list only the first instance will be deleted
    ///   - linkedList: The head node of the linked list the value should be deleted from to
    /// - Returns: The head of the linked list after deleting the value, which will be nil if value was the value for the only node in the list
    static func remove(_ value: Value, from linkedList: Node) -> Node? {
        if value == linkedList.value {
            return linkedList.next
        }

        else if let next = linkedList.next {
            linkedList.next = remove(value, from: next)
        }

        return linkedList
    }
}
