//
//  ViewController.swift
//  ProfileView
//
//  Created by GD on 12/13/21.
//
//  Photos by Mike and Min An from Pexels

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var bottomContainer: UIView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var maxConstraintConstant: CGFloat {
        return mainContainer.frame.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 3.0
        avatarImageView.layer.cornerRadius = 50.0
    }

    @IBAction func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let yTranslation = gesture.translation(in: view).y
    
        switch gesture.state {
        case .began, .changed:
            handleYTranslation(yTranslation)
        case .cancelled, .ended:
            handleEndGesture(yTranslation)
        default:
            break
        }
        gesture.setTranslation(.zero, in: view)
    }
    
    func handleYTranslation(_ yTranslation: CGFloat) {
        if yTranslation < 0 && bottomContainer.frame.minY < view.safeAreaInsets.top ||
            yTranslation >= 0 && bottomContainer.frame.minY > mainContainer.frame.maxY {
           return
        }
        topConstraint.constant += yTranslation
        view.layoutIfNeeded()
    }
    
    func handleEndGesture(_ yTranslation: CGFloat) {
        topConstraint.constant =
            abs(topConstraint.constant) > maxConstraintConstant/2.0
                ? -maxConstraintConstant
                : 0
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 10.0,
            options: .curveEaseInOut) {
                self.view.layoutIfNeeded()
            }
    }
}

