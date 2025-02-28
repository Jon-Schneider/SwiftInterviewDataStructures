//
//  BinarySearchTreeTests.swift
//  
//
//  Created by Jon Schneider on 2/26/25.
//

@testable import InterviewDataStructures
import XCTest

final class BinarySearchTreeTests: XCTestCase {

    // MARK: Static Implementation Tests

    // We need traversal to test the structure of our BST, so we can't really test them independently - if the test fails we know the issue is with one or the other
    func testBinarySearchTreeStructureAndTraversal() throws {

        //        100
        //       /   \
        //     90    200
        //    /  \   /   \
        //   50   95 110  220
        //        /  \   /   \
        //      105 120 210  230
        let root = BinarySearchTree<Int>.Node(value: 100)
        BinarySearchTree.insert(200, in: root)
        BinarySearchTree.insert(220, in: root)
        BinarySearchTree.insert(90, in: root)
        BinarySearchTree.insert(110, in: root)
        BinarySearchTree.insert(50, in: root)
        BinarySearchTree.insert(95, in: root)
        BinarySearchTree.insert(105, in: root)
        BinarySearchTree.insert(120, in: root)
        BinarySearchTree.insert(210, in: root)
        BinarySearchTree.insert(230, in: root)

        var inorderTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [50, 90, 95, 100, 105, 110, 120, 200, 210, 220, 230])

        var preorderTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .preorder) {
            preorderTraversalValues.append($0)
        }
        XCTAssertEqual(preorderTraversalValues, [100, 90, 50, 95, 200, 110, 105, 120, 220, 210, 230])

        var postOrderTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .postorder) {
            postOrderTraversalValues.append($0)
        }
        XCTAssertEqual(postOrderTraversalValues, [50, 95, 90, 105, 120, 110, 210, 230, 220, 200, 100])

        var breadthFirstTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .breadthFirst) {
            breadthFirstTraversalValues.append($0)
        }
        XCTAssertEqual(breadthFirstTraversalValues, [100, 90, 200, 50, 95, 110, 220, 105, 120, 210, 230])
    }

    func testBinarySearchTreeDeletion() throws {

        //        100
        //       /   \
        //     90    200
        //           /   \
        //        110    220
        var root = BinarySearchTree<Int>.Node(value: 100)
        BinarySearchTree.insert(200, in: root)
        BinarySearchTree.insert(220, in: root)
        BinarySearchTree.insert(90, in: root)
        BinarySearchTree.insert(110, in: root)

        root = try XCTUnwrap(BinarySearchTree.delete(220, from: root))

        var inorderTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [90, 100, 110, 200])

        root = try XCTUnwrap(BinarySearchTree.delete(100, from: root))
        inorderTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [90, 110, 200])

        root = try XCTUnwrap(BinarySearchTree.delete(90, from: root))
        inorderTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [110, 200])
    }

    func testBinarySearchTreeDuplicatesAreNotInserted() throws {
        //        100
        //       /   \
        //     90    200
        //           /   \
        //        110    220
        let root = BinarySearchTree<Int>.Node(value: 100)
        BinarySearchTree.insert(200, in: root)
        BinarySearchTree.insert(220, in: root)
        BinarySearchTree.insert(90, in: root)
        BinarySearchTree.insert(110, in: root)

        // Try reinserting every node, none should be duplicated in the tree
        BinarySearchTree.insert(100, in: root)
        BinarySearchTree.insert(200, in: root)
        BinarySearchTree.insert(220, in: root)
        BinarySearchTree.insert(90, in: root)
        BinarySearchTree.insert(110, in: root)

        var inorderTraversalValues = [Int]()
        BinarySearchTree.traverse(root, .inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [90, 100, 110, 200, 220])
    }

    func testBinarySearchTreeSingleNodeDeletion() {
        // Deleting a root node with no children should return nil for the new root node
        let rootValue = 100
        let root = BinarySearchTree<Int>.Node(value: rootValue)
        XCTAssertNil(BinarySearchTree.delete(rootValue, from: root))
    }

    // MARK: Instance Implementation Tests

    func testInstanceBinarySearchTreeStructureAndTraversal() throws {

        //        100
        //       /   \
        //     90    200
        //    /  \   /   \
        //   50   95 110  220
        //        /  \   /   \
        //      105 120 210  230
        let binarySearchTree = BinarySearchTree<Int>(value: 100)
        binarySearchTree.insert(200)
        binarySearchTree.insert(220)
        binarySearchTree.insert(90)
        binarySearchTree.insert(110)
        binarySearchTree.insert(50)
        binarySearchTree.insert(95)
        binarySearchTree.insert(105)
        binarySearchTree.insert(120)
        binarySearchTree.insert(210)
        binarySearchTree.insert(230)

        var inorderTraversalValues = [Int]()
        binarySearchTree.traverse(.inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [50, 90, 95, 100, 105, 110, 120, 200, 210, 220, 230])

        var preorderTraversalValues = [Int]()
        binarySearchTree.traverse(.preorder) {
            preorderTraversalValues.append($0)
        }
        XCTAssertEqual(preorderTraversalValues, [100, 90, 50, 95, 200, 110, 105, 120, 220, 210, 230])

        var postOrderTraversalValues = [Int]()
        binarySearchTree.traverse(.postorder) {
            postOrderTraversalValues.append($0)
        }
        XCTAssertEqual(postOrderTraversalValues, [50, 95, 90, 105, 120, 110, 210, 230, 220, 200, 100])

        var breadthFirstTraversalValues = [Int]()
        binarySearchTree.traverse(.breadthFirst) {
            breadthFirstTraversalValues.append($0)
        }
        XCTAssertEqual(breadthFirstTraversalValues, [100, 90, 200, 50, 95, 110, 220, 105, 120, 210, 230])
    }


    func testInstanceBinarySearchTreeDeletion() throws {

        //        100
        //       /   \
        //     90    200
        //           /   \
        //        110    220
        let binarySearchTree = BinarySearchTree<Int>(value: 100)
        binarySearchTree.insert(200)
        binarySearchTree.insert(220)
        binarySearchTree.insert(90)
        binarySearchTree.insert(110)

        binarySearchTree.delete(220)

        var inorderTraversalValues = [Int]()
        binarySearchTree.traverse(.inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [90, 100, 110, 200])

        binarySearchTree.delete(100)
        inorderTraversalValues = [Int]()
        binarySearchTree.traverse(.inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [90, 110, 200])

        binarySearchTree.delete(90)
        inorderTraversalValues = [Int]()
        binarySearchTree.traverse(.inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [110, 200])
    }

    func testInstanceBinarySearchTreeDuplicatesAreNotInserted() throws {
        //        100
        //       /   \
        //     90    200
        //           /   \
        //        110    220
        let binarySearchTree = BinarySearchTree<Int>(value: 100)
        binarySearchTree.insert(200)
        binarySearchTree.insert(220)
        binarySearchTree.insert(90)
        binarySearchTree.insert(110)

        // Try reinserting every node, none should be duplicated in the tree
        binarySearchTree.insert(100)
        binarySearchTree.insert(200)
        binarySearchTree.insert(220)
        binarySearchTree.insert(90)
        binarySearchTree.insert(110)

        var inorderTraversalValues = [Int]()
        binarySearchTree.traverse(.inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertEqual(inorderTraversalValues, [90, 100, 110, 200, 220])
    }

    func testInstanceBinarySearchTreeSingleNodeDeletion() {
        // Deleting the only value in a tree should result in a nil root node
        let rootValue = 100
        let binarySearchTree = BinarySearchTree<Int>(value: rootValue)
        binarySearchTree.delete(rootValue)

        XCTAssertNil(binarySearchTree.root)

        var inorderTraversalValues = [Int]()
        binarySearchTree.traverse(.inorder) {
            inorderTraversalValues.append($0)
        }
        XCTAssertTrue(inorderTraversalValues.isEmpty)
    }
}
