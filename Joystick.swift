//
//  Joystick.swift
//  HungryKnight
//
//  Created by Jared Warren on 12/20/19.
//  Copyright © 2019 Warren. All rights reserved.
//

import UIKit

/// Receives directional updates from the Joystick.
protocol JoystickDelegate: AnyObject {
    func joystickDirectionChanged(_ direction: Direction?)
}

/// Converts the user's touches to a Direction.
class Joystick: UIImageView {
    
    // MARK: - Properties
    
    weak var delegate: JoystickDelegate?
    private var currentDirection: Direction? = .none {
        didSet {
            updateViewForNewDirection()
        }
    }
    
    // MARK: - Method Overrides
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Reset currentDirection once the player lets go.
        currentDirection = .none
        delegate?.joystickDirectionChanged(.none)
    }
    
    // MARK: - Private Methods
  
    private func touched(_ touches: Set<UITouch>) {
        // Get location from the touch.
        // rawLocation is to the topLeft of the actual JoystickView
        guard let rawLocation = touches.first?.location(in: self) else { return }
        
        // takes the rawLocation and centers it over the middle of the Joystick
        let centeredLocation = CGPoint(x: rawLocation.x - bounds.width/2, y: -rawLocation.y + bounds.height/2)
       
        // Find out the Direction
        let touchDirection = checkForDirection(centeredLocation)
        
        // Notify delegate if the direction has changed.
        if currentDirection != touchDirection {
            self.currentDirection = touchDirection
            delegate?.joystickDirectionChanged(touchDirection)
        }
    }
    
    private func updateViewForNewDirection() {
        let imageName = "Joystick-" + (currentDirection?.rawValue ?? "idle")
        image = UIImage(named: imageName)
    }
    
    /// Converts a location on the Joystick into a Direction or returns nil if it's in the middle.
    private func checkForDirection(_ location: CGPoint) -> Direction? {
        var direction: Direction? = .none
        
        // Creates a deadzone in the center of the joystick.
        let diameter = bounds.width
        let deadZone = diameter * 0.2
        if abs(location.x) + abs(location.y) > deadZone {
            
            // Divides the 8 directions into even slices
            let sliceSize = diameter * 0.125
            
            // Right third of the Joystick
            if location.x >= sliceSize {
                if location.y >= sliceSize {
                    direction = .upRight
                } else if location.y <= -sliceSize {
                    direction = .downRight
                } else {
                    direction = .right
                }
                
                // Left third of the Joystick
            } else if location.x <= -sliceSize {
                if location.y >= sliceSize {
                    direction = .upLeft
                } else if location.y <= -sliceSize {
                    direction = .downLeft
                } else {
                    direction = .left
                }
                
                // Middle third of the Joystick
            } else if location.y >= 0 {
                direction = .up
            } else {
                direction = .down
            }
        }
        return direction
    }
}
