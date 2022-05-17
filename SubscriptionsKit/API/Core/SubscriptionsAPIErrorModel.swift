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

struct SubscriptionsAPIErrorModel: Decodable
{
    let error: ErrorDetails
    let requestID: String

    enum CodingKeys: String, CodingKey
    {
        case error
        case requestID = "request_id"
    }

    struct ErrorDetails: Decodable
    {
        let code: String
        let errorDescription: Description

        enum CodingKeys: String, CodingKey
        {
            case code
            case errorDescription = "description"
        }

        init(from decoder: Decoder) throws
        {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            // Legacy integer code support
            if let integerCode = try? container.decode(Int.self, forKey: .code)
            {
                code = String(describing: integerCode)
            }
            else
            {
                code = try container.decode(String.self, forKey: .code)
            }

            errorDescription = try container.decode(Description.self, forKey: .errorDescription)
        }
    }

    enum Description: Decodable
    {
        case string(String)
        case list([Item])

        init(from decoder: Decoder) throws
        {
            if let list = try? decoder.singleValueContainer().decode([Item].self)
            {
                self = .list(list)
                return
            }

            if let string = try? decoder.singleValueContainer().decode(String.self)
            {
                self = .string(string)
                return
            }

            throw DescriptionError.missingValue
        }

        struct Item: Decodable
        {
            let property: String
            let message: String
        }

        enum DescriptionError: Error
        {
            case missingValue
        }
    }
}

extension SubscriptionsAPIErrorModel: APIDecodableErrorModelProtocol
{
    var code: String { error.code }
    var description: String { String(describing: error.errorDescription) }
    var extendedDescription: String { String(describing: error.errorDescription) }
}
