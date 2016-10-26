//
//  ProcedureKit
//
//  Copyright © 2016 ProcedureKit. All rights reserved.
//

// MARK: - URLSession

public protocol URLSessionTaskProtocol {
    func resume()
    func cancel()
}

public protocol URLSessionDataTaskProtocol: URLSessionTaskProtocol { }
public protocol URLSessionDownloadTaskProtocol: URLSessionTaskProtocol { }

public protocol URLSessionTaskFactory {
    associatedtype DataTask: URLSessionDataTaskProtocol
    associatedtype DownloadTask: URLSessionDownloadTaskProtocol

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTask

    func downloadTask(with request: URLRequest, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> DownloadTask
}

extension URLSessionTask: URLSessionTaskProtocol { }
extension URLSessionDataTask: URLSessionDataTaskProtocol {}
extension URLSessionDownloadTask: URLSessionDownloadTaskProtocol {}
extension URLSession: URLSessionTaskFactory { }

extension URL: ExpressibleByStringLiteral {

    public init(unicodeScalarLiteral value: String) {
        self.init(string: value)!
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(string: value)!
    }

    public init(stringLiteral value: String) {
        self.init(string: value)!
    }
}

public struct HTTPResult<Payload: Equatable>: Equatable {
    public static func == (lhs: HTTPResult<Payload>, rhs: HTTPResult<Payload>) -> Bool {
        return lhs.payload == rhs.payload && lhs.response == rhs.response
    }
    public var payload: Payload
    public var response: HTTPURLResponse
}
