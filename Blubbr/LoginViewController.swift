//
//  LoginViewController.swift
//  Blubbr
//
//  Created by Ben Munge on 5/20/17.
//  Copyright © 2017 Blubbr App. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Superclarendon-BlackItalic", size: 40.0)
        label.textAlignment = .center
        label.text = "blubbr"
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Login using Untappd", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Superclarendon-Italic", size: 18.0)
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        button.layer.cornerRadius = Spacing.half
        button.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var poweredByUntappdLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "poweredByUntappdWhite")
        imageView.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
        imageView.contentMode = .center
        self.view.addSubview(imageView)
        return imageView
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupStaticConstraints()
        registerForNotifications()
    }

    @objc private func didTapLogin() {
        UntappdAuthenticator.sharedInstance.requestAuthentication()
    }
    
    private func setupStaticConstraints() {
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.two),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.two),
            poweredByUntappdLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.two),
            poweredByUntappdLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.two),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.two),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.two),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Spacing.four),
            poweredByUntappdLogo.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Spacing.two)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(authenticationSuccessful), key: .untappdAuthorizationSuccessful, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(authenticationFailed), key: .untappdAuthorizationFailed, object: nil)
    }
    
    @objc private func authenticationSuccessful() {
        let successAlert = UIAlertController(title: "Success!", message: "We were able to authenticate your Untappd account.", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(successAlert, animated: true, completion: nil)
    }
    
    @objc private func authenticationFailed() {
        let failureAlert = UIAlertController(title: "Uh oh!", message: "We encountered an issue authenticating you with Untappd, please try again.", preferredStyle: .alert)
        failureAlert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(failureAlert, animated: true, completion: nil)
    }
}

