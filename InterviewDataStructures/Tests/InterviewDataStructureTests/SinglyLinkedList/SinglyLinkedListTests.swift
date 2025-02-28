//
//  SinglyLinkedListTests.swift
//  
//
//  Created by Jon Schneider on 2/26/25.
//

@testable import InterviewDataStructures
import XCTest

final class SinglyLinkedListTests: XCTestCase {

    // MARK: Static Implementation Tests

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

    // MARK: Instance Implementation Tests

    func testLinkedListInstanceAppendAndTraversal() {
        let linkedList = SinglyLinkedList<Int>(value: 10)
        linkedList.append(20)
        linkedList.append(30)
        linkedList.append(40)

        var linkedListValues = [Int]()
        linkedList.traverse() {
            linkedListValues.append($0)
        }
        XCTAssertEqual(linkedListValues, [10, 20, 30, 40], "SinglyLinkedList.append should append values to the end of the list")
    }

    func testLinkedListInstanceDeletion() throws {
        var linkedList = SinglyLinkedList<Int>(value: 10)

        for i in 2...10 {
            linkedList.append(i * 10)
        }

        // Test deleting first value in Linked List
        linkedList.remove(10)
        var linkedListValues = [Int]()
        linkedList.traverse() {
            linkedListValues.append($0)
        }
        XCTAssertEqual(linkedListValues, [20, 30, 40, 50, 60, 70, 80, 90, 100], "SinglyLinkedList.remove should be able to remove values from the beginning of the list")

        // Test deleting middle value in Linked List
        linkedList.remove(60)
        linkedListValues = [Int]()
        linkedList.traverse() {
            linkedListValues.append($0)
        }
        XCTAssertEqual(linkedListValues, [20, 30, 40, 50, 70, 80, 90, 100], "SinglyLinkedList.remove should be able to remove values from the middle of the list")

        // Test deleting last value in Linked List
        linkedList.remove(100)
        linkedListValues = [Int]()
        linkedList.traverse() {
            linkedListValues.append($0)
        }
        XCTAssertEqual(linkedListValues, [20, 30, 40, 50, 70, 80, 90], "SinglyLinkedList.remove should be able to remove values from the end of the list")

        // Test deletion of single node list nils startNode and endNode, and can no longer removeFirst
        linkedList = SinglyLinkedList(value: 10)
        linkedList.remove(10)

        XCTAssertNil(linkedList.startNode, "Removing the only node in a list should nil startNode")
        XCTAssertNil(linkedList.endNode, "Removing the only node in a list should nil endNode")
        XCTAssertNil(linkedList.removeFirst(), "removeFirst should return nil after removing the last node in a list")
    }

    // Expectation is SinglyLinkedList insertion will append duplication and remove will remove only the first occurance in the LinkedList
    func testLinkedListInstanceDuplicateHandling() throws {
        let linkedList = SinglyLinkedList(value: 10)

        linkedList.append(20)
        linkedList.append(30)

        linkedList.append(10)
        linkedList.append(20)

        var linkedListValues = [Int]()
        linkedList.traverse() {
            linkedListValues.append($0)
        }
        XCTAssertEqual(linkedListValues, [10, 20, 30, 10, 20], "Duplicate values should be appended to end of list")

        linkedList.remove(20)
        linkedListValues = [Int]()
        linkedList.traverse() {
            linkedListValues.append($0)
        }
        XCTAssertEqual(linkedListValues, [10, 30, 10, 20], "Only the first occurance of a value should be removed by calls to 'remove'")
    }

    func testLinkedListInstanceEmptyStateHandling() {
        var linkedList = SinglyLinkedList<Int>()
        XCTAssertNil(linkedList.startNode, "startNode should be nil when list is initialized with nil value")
        XCTAssertNil(linkedList.endNode, "endNode should be nil when list is initialized with nil value")
        XCTAssertNil(linkedList.removeFirst(), "removeFirst should return nil when list is empty")

        linkedList = SinglyLinkedList(value: 10)
        linkedList.append(20)
        linkedList.append(30)
        linkedList.append(40)

        let _ = linkedList.removeFirst()
        let _ = linkedList.removeFirst()
        let _ = linkedList.removeFirst()
        let _ = linkedList.removeFirst()

        XCTAssertNil(linkedList.startNode, "startNode should be nil after last value is popped")
        XCTAssertNil(linkedList.endNode, "endNode should be nil after last value is popped")

        linkedList = SinglyLinkedList(value: 10)
        linkedList.append(20)
        linkedList.append(30)
        linkedList.append(40)

        linkedList.remove(10)
        linkedList.remove(20)
        linkedList.remove(30)
        linkedList.remove(40)

        XCTAssertNil(linkedList.startNode, "startNode should be nil after last value is removed")
        XCTAssertNil(linkedList.endNode, "endNode should be nil after last value is removed")
    }

    func testLinkedListInstanceSingleNodeState() {
        let linkedList = SinglyLinkedList<Int>()
        linkedList.append(10)
        XCTAssertNotNil(linkedList.startNode, "startNode should not be nil after appending to empty list")
        XCTAssertNotNil(linkedList.endNode, "endNode should not be nil after appending to empty list")
        XCTAssertEqual(linkedList.startNode?.value, linkedList.endNode?.value, "startNode should equal endNode when list has a single member")

        linkedList.append(20)
        let _ = linkedList.removeFirst()
        XCTAssertEqual(linkedList.startNode?.value, linkedList.endNode?.value, "startNode should equal endNode when list is reduced to a single node by calling 'removeFirst()'")

        linkedList.append(20)
        let _ = linkedList.remove(20)
        XCTAssertEqual(linkedList.startNode?.value, linkedList.endNode?.value, "startNode should equal endNode when list is reduced to a single node by calling 'remove(value:)'")
    }

    func testLinkedListInstanceStorage() {
        var linkedList = SinglyLinkedList<Int>(value: 10)
        XCTAssertEqual(10, linkedList.removeFirst(), "Calling 'removeFirst()' should return first value in single-node list")
        XCTAssertNil(linkedList.removeFirst(), "'removeFirst()' should remove first value in single-node list")

        linkedList = SinglyLinkedList<Int>(value: 10)
        linkedList.append(20)
        linkedList.append(30)
        linkedList.append(40)

        var linkedListStoredValues = [Int]()
        // We use a a range loop instead of 'while value = linkedList.removeFirst()' because if there is an implementation error and the list never gets emptied that would cause an infinite loop, and that could be painful on CI
        for _ in 0..<4 {
            linkedList.removeFirst().map({ linkedListStoredValues.append($0) })
        }
        XCTAssertEqual(linkedListStoredValues, [10, 20, 30, 40], "Calling 'removeFirst()' should return return elements in the order they are appended")
        XCTAssertNil(linkedList.removeFirst(), "Calling 'removeFirst()' should return nil after all list elements have been removed")

        linkedList = SinglyLinkedList<Int>()
        linkedList.insertAtBeginning(10)
        XCTAssertNotNil(linkedList.startNode, "startNode should not be nil after 'insertAtBeginning()' of empty list")
        XCTAssertNotNil(linkedList.endNode, "endNode should not be nil after 'insertAtBeginning()' of empty list")
        XCTAssertEqual(linkedList.startNode?.value, linkedList.endNode?.value, "startNode should equal endNode after 'insertAtBeginning()' into an empty list")
        XCTAssertEqual(linkedList.removeFirst(), 10, "'removeFirst' should work as normal after 'insertAtBeginning()' is used to add a node to an empty list")
        XCTAssertNil(linkedList.removeFirst(), "'removeFirst' should work as normal after 'insertAtBeginning()' is used to add a node to an empty list")

        linkedList.append(10)
        linkedList.append(20)
        linkedList.append(30)
        linkedList.append(40)
        linkedList.insertAtBeginning(0)

        XCTAssertEqual(linkedList.startNode?.value, 0, "startNode should be updated wwhen 'insertAtBeginning()' is called on a populated list")
        XCTAssertEqual(linkedList.endNode?.value, 40, "endNode should not be updated after 'insertAtBeginning()' is called on a populated list")
    }
}
