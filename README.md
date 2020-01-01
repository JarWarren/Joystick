# Joystick

*An 8-direcitonal joystick class that sends updates to a delegate. Drag and drop to install. Does not come with assets.*

*I needed a joystick for a SpriteKit demo I was building and couldn't find anything online.*
*I hope that by uploading it to github, someone else may be able to benefit from the way I implemented it - or perhaps even use it directly in their own project.*
![Joystick Demo](Joystick_Demo.gif)

### Explanation

My HUD is built in UIKit and sends user input via the delegate pattern.
Joystick is a subclass of UIImageView that reads user touches, determines where in itself they occured, and translates them into a direction.

The delegate is only notified when the direciton changes, so that the hero can react accordingly. If the user lets go of the joystick, the delegate receives a `nil` direction. An opportunity to "idle" your hero.

.

### Installation
1. Drag and drop both Swift files into your project.
2. Add a `UIImageView` to your storyboard and sublcass it as a `Joystick`.
3. Check the box that says `User Interaction Enabled`. (Or set `isUserInteractionEnabled = true` in Swift).
4. Create an outlet and in `viewDidLoad()`, set your ViewController as the joystick's delegate.
5. Conform to `JoystickDelegate`.

*Feel free to make any edits you want. (Ex. rotate a single asset instead of providing one for each direction.)*
