// Copyright 2021-present Xsolla (USA), Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at q
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing and permissions and

import Foundation

class APIBaseRequest
{
    let apiConfiguration: APIConfigurationProtocol

    var customJSONDecoder: JSONDecoder? { nil }

    var basePath: String { apiConfiguration.apiBasePath }
    var relativePath: String { fatalError("The field must be intentionally defined in successor") }
    var path: String { "\(basePath)\(relativePath)" }
    var url: URL { createUrl() }
    var request: URLRequest { createRequest() }

    var httpMethod: HTTPMethod { fatalError("The field must be intentionally defined in successor") }
    var timeoutInterval: TimeInterval { 30 }
    var cachePolicy: URLRequest.CachePolicy { .reloadIgnoringLocalAndRemoteCacheData }

    /// Creates a URLRequest by applying all parameters and a payload
    func createRequest() -> URLRequest
    {
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)

        // Base configuration
        request.httpMethod = httpMethod.rawValue

        // Headers
        self.headers.forEach
        { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        // Cookies
        let cookiesString = self.cookies.map { "\($0.key)=\($0.value)" }.joined(separator: ";")
        request.addValue(cookiesString, forHTTPHeaderField: HTTPHeaderKey.cookie)

        // Http body for all requests excepting GET
        if httpMethod != HTTPMethod.get
        {
            request.httpBody = bodyData
        }

        return request
    }

    /// Creates a URL by adding query items if any
    func createUrl() -> URL
    {
        guard var urlComponents = URLComponents(string: path) else { fatalError("Endpoint path error") }

        let queryItems = self.queryParameters.reduce(into: [URLQueryItem]())
        { result, parameter in

            let key = parameter.key

            if let array = parameter.value as? Array<CustomStringConvertible>
            {
                let items = array.map { element in URLQueryItem(name: "\(key)[]", value: element.description) }
                result.append(contentsOf: items)
                return
            }

            if let value = parameter.value
            {
                result.append(URLQueryItem(name: key, value: String(describing: value)))
            }
        }

        if !queryItems.isEmpty { urlComponents.queryItems = queryItems }

        guard
            let unprocessedUrl = urlComponents.url,
            let url = URL(string: unprocessedUrl.absoluteString.replacingOccurrences(of: "%5B%5D", with: "[]"))
        else
        {
            fatalError("Endpoint path error")
        }

        return url
    }

    // MARK: - Query String

    typealias QueryParameters = [String: CustomStringConvertible?]

    var specialQueryParameters: QueryParameters { [:] }

    var queryParameters: QueryParameters
    {
        var parameters = defaultParameters

        parameters.merge(specialQueryParameters) { (_, new) in new }

        return parameters
    }

    var defaultParameters: QueryParameters { [:] }

    // MARK: - Http Body

    var bodyParameters: Encodable? { nil }
    var bodyData: Data? { bodyParameters?.getJSONData(encoder: bodyParametersEncoder) }

    var bodyParametersEncoder: JSONEncoder?
    {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = keyEncodingStrategy
        return encoder
    }

    var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy
    {
        .useDefaultKeys
    }

    // MARK: - Http Headers

    typealias HTTPHeaders = [String: String]

    var headers: HTTPHeaders
    {
        var headers = defaultHeaders

        headers.merge(authHeaders) { (_, new) in new }
        headers.merge(specialHeaders) { (_, new) in new }

        return headers
    }

    var authenticationToken: String? { nil }
    var authHeaders: HTTPHeaders
    {
        guard let token = authenticationToken else { return [:] }
        return [HTTPHeaderKey.authorization: "Bearer \(token)"]
    }

    var specialHeaders: HTTPHeaders { [:] }

    var defaultHeaders: HTTPHeaders
    {
        [
            HTTPHeaderKey.accept: "application/json",
            HTTPHeaderKey.contentType: "application/json",
            HTTPHeaderKey.acceptCharset: "utf-8"
        ]
    }

    // MARK: - Http Cookies

    typealias Cookies = [String: String]

    var cookies: Cookies
    {
        var cookies = defaultCookies

        cookies.merge(specialCookies) { (_, new) in new }

        return cookies
    }

    var specialCookies: Cookies { [:] }
    var defaultCookies: Cookies { [:] }

    // MARK: - Initialization

    init(apiConfiguration: APIConfigurationProtocol)
    {
        self.apiConfiguration = apiConfiguration
    }
}

fileprivate extension Encodable
{
    func getJSONData(encoder: JSONEncoder? = nil) -> Data?
    {
        let encoder = encoder ?? JSONEncoder()
        return try? encoder.encode(self)
    }
}
