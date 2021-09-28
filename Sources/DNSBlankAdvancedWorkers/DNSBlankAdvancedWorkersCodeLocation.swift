//
//  DNSBlankAdvancedWorkersCodeLocation.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSCore
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import DNSError
import DNSProtocols

public extension DNSCodeLocation {
    typealias blankAdvancedWorkers = DNSBlankAdvancedWorkersCodeLocation
}
open class DNSBlankAdvancedWorkersCodeLocation: DNSCodeLocation {
    override open class var domainPreface: String { "com.doublenode.blankAdvancedWorkers." }
}
