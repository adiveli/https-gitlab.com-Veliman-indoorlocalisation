//
//  Utilities.swift
//  Trilateration
//
//  Created by Tharindu Ketipearachchi on 1/17/18.
//  Copyright © 2018 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit


class Point: NSObject {
    
    var x: Double?
    var y: Double?
    
    init(xx:Double, yy:Double) {
        x = xx
        y = yy
    }
    
}




class Utilities: NSObject {
    
    
    static func normValue(point: Point) -> Double {
        var norm:Double?
        norm = pow(pow(point.x!, 2) + pow(point.y!, 2) , 0.5)
        return norm!
    }
    
    static func trilateration(point1: Point, point2: Point, point3: Point, r1: Double, r2:Double, r3: Double) -> Point {
        
        //unit vector in a direction from point1 to point 2
        var p1p2:Double = pow(pow(point2.x! - point1.x! , 2.0) + pow(point2.y! - point1.y!, 2.0), 0.5)
        
        let ex = Point(xx: (point2.x! - point1.x!) / p1p2, yy: (point2.y! - point1.y!) / p1p2)
        
        let aux = Point(xx: point3.x! - point1.x!, yy: point3.y! - point1.y!)
        
        //signed magnitude of the x component
        let i: Double = ((ex.x)! * (aux.x)!) + ((ex.y)! * aux.y!)
        
        //the unit vector in the y direction.
        let aux2 = Point(xx: point3.x! - point1.x! - (i * (ex.x)!), yy: point3.y! - point1.y! - (i * (ex.y)!))
        
        let ey = Point(xx: (aux2.x!) / self.normValue(point: aux2), yy: (aux2.y!) / self.normValue(point: aux2))
        
        //the signed magnitude of the y component
        let j:Double = ((ey.x)! * (aux.x)!) + ((ey.y)! * (aux.y)!)
        
        //coordinates
        let x:Double = (pow(r1, 2) - pow(r2, 2) + pow(p1p2, 2)) / (2 * p1p2)
        let y:Double = ((pow(r1, 2) - pow(r3, 2) + pow(i, 2) + pow(j, 2))/(2 * j)) - (i * x/j)
        
        //result coordinates
        let finalX:Double = point1.x! + x * ex.x! + y * (ey.x)!
        let finalY:Double = point1.y! + x * ex.y! + y * (ey.y)!
        
        let location = Point(xx: finalX, yy: finalY)
        
        return location
    }
    
}

