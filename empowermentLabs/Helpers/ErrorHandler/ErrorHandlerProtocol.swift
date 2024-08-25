//
//  ErrorHandlerProtocol.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import Foundation

protocol ErrorHandlerProtocol: AnyObject {
    func showError(error: Error)
}

protocol ErrorProcessorProtocol {
    var errorHandler: ErrorHandlerProtocol? { get set }
}
