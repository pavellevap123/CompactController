//
//  SecondViewController.swift
//  CompactController
//
//  Created by Pavel Paddubotski on 13.05.23.
//

import UIKit

protocol SecondViewControllerDelegate: AnyObject {
    func secondViewControllerSegmentedControlDidChange(_ viewController: UIViewController, _ segmentIndex: Int)
}

class SecondViewController: UIViewController {
    
    weak var delegate: SecondViewControllerDelegate?
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.insertSegment(withTitle: "280pt", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "150pt", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { _ in
            self.dismiss(animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
                self?.segmentedControl.selectedSegmentIndex = 0
            })
        }), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.addSubview(segmentedControl)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        delegate?.secondViewControllerSegmentedControlDidChange(self, sender.selectedSegmentIndex)
    }
}
