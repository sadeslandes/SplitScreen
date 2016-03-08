//
//  SnapPoint.swift
//  SplitScreen
//
//  Created by Evan Thompson on 3/4/16.
//  Copyright © 2016 SplitScreen. All rights reserved.
//

import Foundation
import AppKit

class SnapPoint{
    
    private var snap_point = [((Int,Int),(Int,Int))]() // All snap locations that can snap to a point
    private var snap_location: (Int, Int)
    private var dimensions: (Int, Int)
    private var logic: Int
    private var orig_height: Int
    private var orig_width: Int
    
    /**
        Initializes this SnapPoint
     
        Parameters:
        
        height - the original height this layout was designed for
     
        width - the original width this layout was designed for
     
        x_dim - the x dimension of the resize
     
        y_dim - the y dimension of the resize
     
        x_snap_loc - the x-coordinate of where the window will be moved to
     
        y_snap_loc - the y-coordinate of where the window will be moved to
     
        log - the logic bit to determine what action will be performed by the snap
     */
    init(height: Int, width: Int, x_dim: Int, y_dim: Int, x_snap_loc: Int, y_snap_loc: Int, log: Int) {
        snap_location = (x_snap_loc, y_snap_loc)
        dimensions = (x_dim,y_dim)
        logic = log
        orig_height = height
        orig_width = width
    }
    
    /**
        Adds a new snap_point definition
     
        Parameters:
     
        x0 - left x-coordinate
        
        y0 - low y-coordinate
     
        x1 - right x-coordinate
     
        y1 - high y-coordinate
     
        [NOTE: at least one number in the pairings of x0,y0 and x1,y1 must be 0]
     
    */
    func add_snap_point(x0: Int, y0: Int, x1: Int, y1: Int) -> Bool {
        
        if x0 > x1 || y0 > y1 {
            return false
        }
        
        /*if x0 * y0 != 0 || x1 * y1 != 0 {
            return false
        }*/
        
        snap_point.append(((x0, y0),(x1, y1)))
        return true
    }
    
    
    /**
        Checks if a location falls under this snap point
     
        Parameters: 
        
        x - x value of location to check
     
        y - y value of location to check
     */
    func check_point(x: Int, y: Int) -> Bool {
        
        let (scale_factor_h, scale_factor_w) = get_scale_factors()
        print(" \n\nscales: \(scale_factor_h), \(scale_factor_w)")
        
        /*if x * y != 0 {
            return false
        }*/
        
        // run through each snap_point and check if it fits the guessed location
        
        let x_f = CGFloat(x)
        let y_f = CGFloat(y)
        
        for snaps in snap_point{
            
            print(" -- \(x_f) >= \(CGFloat(snaps.0.0) * scale_factor_w) && \(x_f) <= \(CGFloat(snaps.1.0) * scale_factor_w) && \(y_f) >= \(CGFloat(snaps.0.1) * scale_factor_h) && \(y_f) >= \(CGFloat(snaps.1.1) * scale_factor_h)")
            if x_f >= CGFloat(snaps.0.0) * scale_factor_w && x_f <= CGFloat(snaps.1.0) * scale_factor_w && y_f >= CGFloat(snaps.0.1) * scale_factor_h && y_f <= CGFloat(snaps.1.1) * scale_factor_h {
                return true
            }
            
        }
        
        print(" got past for loop")
        
        return false
    }
    
    
    /**
        Returns scaled snap_location value (left hand corner of the snap)
     */
    func get_snap_location() -> (Int, Int) {
        let (scale_factor_h, scale_factor_w) = get_scale_factors()
        
        return (Int(CGFloat(snap_location.0) * scale_factor_w), Int(CGFloat(snap_location.1) * scale_factor_h))

    }
    
    /**
        Returns scaled dimensions of SnapPoint
     */
    func get_dimensions() -> (Int, Int) {
        
        let (scale_factor_h, scale_factor_w) = get_scale_factors()
        
        return (Int(CGFloat(dimensions.0) * scale_factor_w), Int(CGFloat(dimensions.1) * scale_factor_h))
    }
    
    /**
        Returns the logic associated with the snap
     */
    func get_logic() -> Int {
        return Int(logic)
    }

    /**
        Returns the resolution (height, width) that this layout was made with
     
        NOTE: Use for scaling purposes with different resolutions
     */
    func get_orig_resolution() -> (Int, Int){
        return (Int(orig_height), Int(orig_width))
    }
    
    //*************************************************
    //               Private Functions
    //*************************************************
    
    /**
        INTERNAL
            
        returns the scale factor for the dimensions and snap locations
     */
    private func get_scale_factors() -> (CGFloat, CGFloat){
        let curr_height: Int = Int((NSScreen.mainScreen()?.frame.height)!)
        let curr_width: Int = Int((NSScreen.mainScreen()?.frame.width)!)
        
        return (CGFloat(curr_height)/CGFloat(orig_height), CGFloat(curr_width)/CGFloat(orig_width))
    }
    
}