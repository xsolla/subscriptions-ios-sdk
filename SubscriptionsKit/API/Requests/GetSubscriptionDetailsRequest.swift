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

class GetSubscriptionDetailsRequest: SubscriptionsBaseRequest<GetSubscriptionDetailsRequest.Params>,
                                         APIRequestProtocol
{
    typealias ResponseModel = GetSubscriptionDetailsResponse
    typealias ErrorHandler  = APIBaseErrorHandler
    typealias ErrorModel    = SubscriptionsAPIErrorModel
    typealias ErrorType     = SubscriptionsAPIError
    typealias Callback      = (Result<ResponseModel, ErrorType>) -> Void

    let errorHandler = ErrorHandler()

    // MARK: - Request settings

    override var httpMethod: HTTPMethod { .get }

    override var relativePath: String { "/user/v1/projects/\(String(params.projectId))/subscriptions/\(params.subscriptionId)" }

    override var authenticationToken: String? { params.accessToken }

    override var defaultParameters: APIBaseRequest.QueryParameters
    {
        [
            "locale": params.locale
        ]
    }

    func handleSuccess(model: ResponseModel, completionHandler: Callback)
    {
        completionHandler(.success(model))
    }

    func handleFailure(error: ErrorType, completionHandler: Callback)
    {
        completionHandler(.failure(error))
    }
}

extension GetSubscriptionDetailsRequest
{
    struct Params: RequestParams
    {
        let accessToken: String

        let projectId: Int
        let subscriptionId: String

        let locale: String?
    }
}
