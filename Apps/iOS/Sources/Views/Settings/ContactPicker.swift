//
//  ContactPicker.swift
//  Submap
//
//  Created by Joe Blau on 11/10/23.
//

import ContactsUI
import SwiftUI

struct ContactPicker: UIViewControllerRepresentable {
    @Binding var selectedContact: CNContact?
    
    func makeCoordinator() -> ContactPickerCoordinator {
        ContactPickerCoordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let navController = UINavigationController()
        
        let controller = CNContactPickerViewController()
        controller.delegate = context.coordinator
        controller.title = "Select Your Contact"
        controller.navigationItem.largeTitleDisplayMode = .always
        
        navController.viewControllers = [controller]
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
    
    func updateUIViewController(_: UIViewController, context _: Context) {}
}

class ContactPickerCoordinator: NSObject, CNContactPickerDelegate {
    var parent: ContactPicker
    
    init(_ contactPicker: ContactPicker) {
        parent = contactPicker
    }
    
    func contactPicker(_: CNContactPickerViewController, didSelect contact: CNContact) {
        parent.selectedContact = contact
    }
}
