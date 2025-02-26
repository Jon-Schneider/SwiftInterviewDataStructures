//
//  SinglyLinkedListTests.swift
//  
//
//  Created by Jon Schneider on 2/26/25.
//

import InterviewDataStructures
import XCTest

final class SinglyLinkedListTests: XCTestCase {

    func testLinkedListAppendAndTraversal() {
        let linkedList = SinglyLinkedList.Node(value: 10)

        SinglyLinkedList.append(20, to: linkedList)
        SinglyLinkedList.append(30, to: linkedList)
        SinglyLinkedList.append(40, to: linkedList)

        var linkedListValues = [Int]()
        SinglyLinkedList.traverse(linkedList) {
            linkedListValues.append($0)
        }
        XCTAssertEqual(linkedListValues, [10, 20, 30, 40], "SinglyLinkedList.append should append values to the end of the list")
    }

    func testLinkedListDeletion() throws {
        var linkedList: SinglyLinkedList<Int>.Node = SinglyLinkedList.Node(value: 10)

        for i in 2...10 {
            SinglyLinkedList.append(i * 10, to: linkedList)
        }

        // Test deleting first value in Linked List
        linkedList = try XCTUnwrap(SinglyLinkedList.remove(10, from: linkedList))
        var linkedListValues = [Int]()
        SinglyLinkedList.traverse(linkedList) {
            linkedListValues.append($0)
        }
        XCTAssertEqual(linkedListValues, [20, 30, 40, 50, 60, 70, 80, 90, 100], "SinglyLinkedList.remove should be able to remove values from the beginning of the list")

        // Test deleting middle value in Linked List
        linkedList = try XCTUnwrap(SinglyLinkedList.remove(60, from: linkedList))
        linkedListValues = [Int]()
        SinglyLinkedList.traverse(linkedList) {
            linkedListValues.append($0)
        }
        XCTAssertEqual(linkedListValues, [20, 30, 40, 50, 70, 80, 90, 100], "SinglyLinkedList.remove should be able to remove values from the middle of the list")

        // Test deleting last value in Linked List
        linkedList = try XCTUnwrap(SinglyLinkedList.remove(100, from: linkedList))
        linkedListValues = [Int]()
        SinglyLinkedList.traverse(linkedList) {
            linkedListValues.append($0)
        }
        XCTAssertEqual(linkedListValues, [20, 30, 40, 50, 70, 80, 90], "SinglyLinkedList.remove should be able to remove values from the end of the list")

        // Test deletion of single node list returns nil
        linkedList = SinglyLinkedList.Node(value: 10)
        XCTAssertNil(SinglyLinkedList.remove(10, from: linkedList), "Removing the only node in a list should return nil for the new list head")
    }

    // Expectation is SinglyLinkedList insertion will append duplication and remove will remove only the first occurance in the LinkedList
    func testLinkedListDuplicateHandling() throws {
        var linkedList: SinglyLinkedList<Int>.Node = SinglyLinkedList.Node(value: 10)

        SinglyLinkedList.append(20, to: linkedList)
        SinglyLinkedList.append(30, to: linkedList)

        SinglyLinkedList.append(10, to: linkedList)
        SinglyLinkedList.append(20, to: linkedList)

        var linkedListValues = [Int]()
        SinglyLinkedList.traverse(linkedList) {
            linkedListValues.append($0)
        }
        XCTAssertEqual(linkedListValues, [10, 20, 30, 10, 20], "Duplicate values should be appended to end of list")

        linkedList = try XCTUnwrap(SinglyLinkedList.remove(20, from: linkedList))
        linkedListValues = [Int]()
        SinglyLinkedList.traverse(linkedList) {
            linkedListValues.append($0)
        }
        XCTAssertEqual(linkedListValues, [10, 30, 10, 20], "Only the first occurance of a value should be removed by calls to 'remove'")
    }
}
