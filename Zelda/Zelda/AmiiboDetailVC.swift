//
//  AmiiboDetailVC.swift
//  Zelda
//
//  Created by Aksel Kantar on 1/08/2019.
//  Copyright © 2019 Aksel Kantar. All rights reserved.
//

import UIKit

class AmiiboDetailVC: UIViewController {
    
    var amiiboForDetailVC: AmiiboForView?
    var safeArea: UILayoutGuide!
    
    let imageView = CustomImageView()
    let dismissBtn = UIButton()
    let amiiboTextLabel = UILabel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .darkGray
        
        setupImageView()
        setupDismissButton()
        setupAmiiboTextLabel()
        setupData()
    }
    
    func setupImageView() {
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive = true
        imageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
    }
    
    func setupDismissButton() {
        
        view.addSubview(dismissBtn)
        dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        dismissBtn.setTitle("Dismiss", for: .normal)
        dismissBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        dismissBtn.addTarget(self, action: #selector(dismissBtnAction), for: .touchUpInside)
    }
    
    @objc func dismissBtnAction(sender: UIButton!) {
        self.dismiss(animated: true)
    }
    
    func setupAmiiboTextLabel() {
        
        view.addSubview(amiiboTextLabel)
        amiiboTextLabel.textColor = .white
        amiiboTextLabel.translatesAutoresizingMaskIntoConstraints = false
        amiiboTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        amiiboTextLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25).isActive = true
//        amiiboTextLabel.text = "test"
    }
    
    func setupData() {
        
        if
            let amiibo = amiiboForDetailVC,
            let url = URL(string: amiibo.imageUrl) {
            imageView.loadImage(from: url)
            amiiboTextLabel.text = amiibo.name
        }
        
    }
    
}
