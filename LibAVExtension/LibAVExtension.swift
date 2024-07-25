//
//  LibAVExtension.swift
//  LibAVExtension
//
//  Created by Anton Marini on 7/25/24.
//

import Foundation
import ExtensionFoundation
import MediaExtension

/// The AppExtensionConfiguration that will be provided by this extension.
/// This is typically defined by the extension host in a framework.
struct ExampleConfiguration<E:ExampleExtension>: AppExtensionConfiguration {
    
    let appExtension: E
    
    init(_ appExtension: E) {
        self.appExtension = appExtension
    }
    
    /// Determine whether to accept the XPC connection from the host.
    func accept(connection: NSXPCConnection) -> Bool {
        // TODO: Configure the XPC connection and return true
        return false
    }
}

/// The AppExtension protocol to which this extension will conform.
/// This is typically defined by the extension host in a framework.
protocol ExampleExtension : AppExtension { }

extension ExampleExtension {
    var configuration: ExampleConfiguration<some ExampleExtension> {
        // Return your extension's configuration upon request.
        return ExampleConfiguration(self)
    }
}

@main
class LibAVExtension: ExampleExtension {
    required init() {
        // Initialize your extension here.
    }
}
