//
//  ViewController.swift
//  CompactController
//
//  Created by Pavel Paddubotski on 13.05.23.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, SecondViewControllerDelegate {
    private lazy var vc = SecondViewController()
    
    private lazy var presentButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Present", for: .normal)
        button.addTarget(self, action: #selector(presentButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.addSubview(presentButton)
        
        NSLayoutConstraint.activate([
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
    }
    
    @objc private func presentButtonTapped(_ sender: UIButton) {
        vc.delegate = self
        vc.view.backgroundColor = .tertiarySystemGroupedBackground
        vc.preferredContentSize = CGSize(width: 300, height: 280)
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.delegate = self
        vc.popoverPresentationController?.sourceView = sender
        vc.popoverPresentationController?.sourceRect = sender.bounds
        self.present(vc, animated: true)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        .none
    }
    
    func secondViewControllerSegmentedControlDidChange(_ viewController: UIViewController, _ segmentIndex: Int) {
        if segmentIndex == 0 {
            vc.preferredContentSize = CGSize(width: 300, height: 280)
        } else {
            vc.preferredContentSize = CGSize(width: 300, height: 150)
        }
    }
}

