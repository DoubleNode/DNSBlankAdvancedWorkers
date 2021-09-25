//
//  WKRBlankNFCTagsWorker.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBlankWorkers
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import DNSBlankWorkers
import DNSProtocols
import DNSProtocolsAdvanced
import Foundation

open class WKRBlankNFCTagsWorker: WKRBlankBaseWorker, PTCLNFCTags
{
    public var callNextWhen: PTCLProtocol.Call.NextWhen = .whenUnhandled
    public var nextWorker: PTCLNFCTags?
    
    public required init() {
        super.init()
    }
    public func register(nextWorker: PTCLNFCTags,
                         for callNextWhen: PTCLProtocol.Call.NextWhen) {
        self.callNextWhen = callNextWhen
        self.nextWorker = nextWorker
    }
    
    override open func disableOption(_ option: String) {
        super.disableOption(option)
        nextWorker?.disableOption(option)
    }
    override open func enableOption(_ option: String) {
        super.enableOption(option)
        nextWorker?.enableOption(option)
    }
    @discardableResult
    public func runDo(runNext: PTCLCallBlock?,
                      doWork: PTCLCallResultBlockThrows = { return $0?(.unhandled) }) throws -> Any? {
        return try self.runDo(callNextWhen: self.callNextWhen, runNext: runNext, doWork: doWork)
    }

    // MARK: - Business Logic / Single Item CRUD

    open func doScanTags(for key: String,
                         with progress: PTCLProgressBlock?,
                         and block: PTCLNFCTagsBlockVoidArrayNFCNDEFMessage?) throws {
        try self.runDo(runNext: {
            guard let nextWorker = self.nextWorker else { return nil }
            return try nextWorker.doScanTags(for: key, with: progress, and: block)
        },
                       doWork: {
            return try self.intDoScanTags(for: key, with: progress, and: block, then: $0)
        })
    }

    // MARK: - Internal Work Methods
    open func intDoScanTags(for key: String,
                            with progress: PTCLProgressBlock?,
                            and block: PTCLNFCTagsBlockVoidArrayNFCNDEFMessage?,
                            then resultBlock: PTCLResultBlock?) throws {
        _ = resultBlock?(.unhandled)
    }
}
