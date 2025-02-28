//
//  File.swift
//  
//
//  Created by Jon Schneider on 2/26/25.
//

import Foundation

public extension SinglyLinkedList {

    // MARK: Instance Implementation

    func append(_ value: Value) {
        // We can do this faster inside a SinglyLinkedList class instance than the static func because we have access to a tail pointer

        let newNode = Node(value: value)

        // If list is not empty add to end of list
        if let endNode {
            endNode.next = newNode
            self.endNode = newNode
        }

        // if endNode is nil then the list is empty
        else {
            startNode = newNode
            endNode = newNode
        }
    }

    func insertAtBeginning(_ value: Value) {
        guard let oldStartNode = startNode else {
            // append() already has logic for insertion into empty list, so don't duplicate it
            append(value)
            return
        }

        let newNode = Node(value: value)
        self.startNode = newNode
        newNode.next = oldStartNode
    }

    func removeFirst() -> Value? {
        guard let startNode else {
            return nil
        }

        self.startNode = startNode.next

        // Nil end node reference if start node is now nil
        if self.startNode == nil {
            endNode = nil
        }

        return startNode.value
    }

    func remove(_ value: Value) {
        guard let startNode else {
            return
        }

        self.startNode = SinglyLinkedList.remove(value, from: startNode)

        // This is not effecient, and there's nothing we can do about it
        // There's no guarentee next will reach the end
        self.endNode = self.startNode.map({ SinglyLinkedList.last(in: $0) }) ?? nil
    }


    // MARK: Static Implementation

    /// Appends value to end of LinkedList
    /// - Parameters:
    ///   - value: Value to be appended to end of list. Values are not checked for duplicates
    ///   - linkedList: The head node of the linked list the value should be appended to
    /// - Returns: The head of the linked list after appending the new value
    static func append(_ value: Value, to linkedList: Node) {
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

    // MARK: Private

    private static func last(in linkedList: Node) -> Node? {
        guard let next = linkedList.next else {
            return linkedList
        }
        return last(in: next)
    }
}
