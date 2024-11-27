//
//  Pentominoes.swift
//  Assets for Assignment 4
//
//  Created by Alfares, Nader on 1/28/23.
//
import Foundation


//Mark:- Shapes models
struct Point : Codable {
    let x : Int
    let y : Int
}

struct Size : Codable {
    let width : Int
    let height : Int
}

typealias Outline = [Point]

struct PentominoOutline : Codable {
    let name : String
    let size : Size
    let outline : Outline
}

struct PuzzleOutline : Codable {
    let name : String
    let size : Size
    let outlines : [Outline]
}

//Mark:- Pieces Model

// specifies the complete position of a piece using unit coordinates
struct Position : Codable {
    var x : Int = 0
    var y : Int = 0
    var orientation: Orientation = .up
}

// a Piece is the model data that the view uses to display a pentomino
struct Piece : Codable {
    var position : Position = Position()
    var outline : PentominoOutline
}

/*
struct Solutions: Codable {
    var solutions: [String : [String : Position]]
}
 */

struct threeDimRotations {
    // Number of 180, 180, or 90 degree rotations for each respective dimension
    var xRot: Int = 0
    var yRot: Int = 0
    var zRot: Int = 0
}

func orientationToThreeDimRotation(from orientation: Orientation) -> threeDimRotations {
    switch orientation {
    // Default
    case .up:
        return threeDimRotations(xRot: 0, yRot: 0, zRot: 0)
    case .down:
        return threeDimRotations(xRot: 1, yRot: 0, zRot: 0)
    case .left:
        return threeDimRotations(xRot: 0, yRot: 0, zRot: 3)
    case .right:
        return threeDimRotations(xRot: 0, yRot: 0, zRot: 1)
    case .upMirrored:
        return threeDimRotations(xRot: 1, yRot: 1, zRot: 0)
    case .downMirrored:
        return threeDimRotations(xRot: 0, yRot: 1, zRot: 2)
    case .leftMirrored:
        return threeDimRotations(xRot: 1, yRot: 1, zRot: 3)
    case .rightMirrored:
        return threeDimRotations(xRot: 1, yRot: 1, zRot: 3)
    }
}




