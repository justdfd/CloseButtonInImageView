//
//  ViewController.swift
//  CloseButtonInImageView
//
//  Created by Dave Dombrowski on 4/12/20.
//  Copyright © 2020 justDFD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imageView = UIImageView()
    let myImage = UIImage(named: "pic2.jpg")
    let button = UIButton(type: .system)
    var btnTop:NSLayoutConstraint!
    var btnTrailing:NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.image = myImage
        
        button.setImage(UIImage(systemName: "xmark")!, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.blue.cgColor
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.red
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        btnTop = button.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10)
        btnTop.isActive = true
        btnTrailing = button.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10)
        btnTrailing.isActive = true

        //button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        //button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true

    }
    override func viewDidLayoutSubviews() {
        //print(imageView.frame)
        repositionCloseButton()
    }
    func repositionCloseButton() {
        let scaledSize = imageView.scaledSize
        var imageFrame = CGRect(origin: CGPoint.zero, size: scaledSize)
        if scaledSize.width == imageView.frame.width {
            // image fills view along width, calculate Y constant
            imageFrame.origin.y = (imageView.frame.height - scaledSize.height) / 2
        } else {
            // image fills view along height, calculate X constant
            imageFrame.origin.x = (imageView.frame.width - scaledSize.width) / 2
        }
        //btnTop.constant = imageFrame.width - 30
        btnTop.constant = imageFrame.origin.y + 10
        btnTrailing.constant = ((imageView.frame.width - imageFrame.width - imageFrame.origin.x) * -1) - 10
        print(imageView.frame)
        print(imageFrame)
        print(btnTrailing.constant)
        //origin.x == 200
        //imageview.widt == 300
    }
}
extension UIImageView {
    public var scaleFactor:CGFloat {
        guard let image = self.image, self.frame != CGRect.zero  else {
            return 0.0
        }
        
        let frame = self.frame
        let extent = image.size
        let heightFactor = frame.height/extent.height
        let widthFactor = frame.width/extent.width
        
        if extent.height > frame.height || extent.width > frame.width {
            if heightFactor < 1 && widthFactor < 1 {
                if heightFactor > widthFactor {
                    return widthFactor
                } else {
                    return heightFactor
                }
            } else if extent.height > frame.height {
                return heightFactor
            } else {
                return widthFactor
            }
        } else if extent.height < frame.height && extent.width < frame.width {
            if heightFactor < widthFactor {
                return heightFactor
            } else {
                return widthFactor
            }
        } else {
            return 1
        }
    }
    
    public var imageSize:CGSize {
        if self.image == nil {
            return CGSize.zero
        } else {
            return CGSize(width: (self.image?.size.width)!, height: (self.image?.size.height)!)
        }
    }
    
    public var scaledSize:CGSize {
        guard let image = self.image, self.frame != CGRect.zero  else {
            return CGSize.zero
        }
        let factor = self.scaleFactor
        return CGSize(width: image.size.width * factor, height: image.size.height * factor)
    }
}

