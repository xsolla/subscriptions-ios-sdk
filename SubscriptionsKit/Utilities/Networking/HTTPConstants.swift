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

enum HTTPMethod: String
{
    case get  = "GET"
    case post = "POST"
    case put  = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

enum HTTPHeaderKey
{
    static let authorization = "Authorization"
    static let accept = "Accept"
    static let acceptCharset = "Accept-Charset"
    static let acceptLanguage = "Accept-Language"
    static let contentType = "Content-Type"
    static let origin = "Origin"
    static let cookie = "Cookie"
    static let unauthorizedId = "x-unauthorized-id"
    static let user = "x-user"
}

enum HTTPCookieKey
{
    static let locale = "locale"
}
