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

// swiftlint:disable line_length

import Foundation

typealias SubscriptionsAPIError = Error
typealias SubscriptionsAPIResult<T> = Result<T, SubscriptionsAPIError>
typealias SubscriptionsAPICompletion<T> = (SubscriptionsAPIResult<T>) -> Void

protocol SubscriptionsAPIProtocol
{
    func getSubscriptionPublicPlans(projectId: Int,
                                    planId: [Int]?,
                                    planExternalId: [Int]?,
                                    limit: Int?,
                                    offset: Int?,
                                    locale: String?,
                                    country: String?,
                                    completion: @escaping SubscriptionsAPICompletion<GetSubscriptionPublicPlansResponse>)

    func getSubscriptionPlans(accessToken: String,
                              projectId: Int,
                              planId: [Int]?,
                              planExternalId: [Int]?,
                              limit: Int?,
                              offset: Int?,
                              locale: String?,
                              country: String?,
                              completion: @escaping SubscriptionsAPICompletion<GetSubscriptionPlansResponse>)

    func getSubscriptions(accessToken: String,
                          projectId: Int,
                          limit: Int?,
                          offset: Int?,
                          locale: String?,
                          completion: @escaping SubscriptionsAPICompletion<GetSubscriptionsResponse>)

    func getSubscriptionDetails(accessToken: String,
                                projectId: Int,
                                subscriptionId: String,
                                locale: String?,
                                completion: @escaping SubscriptionsAPICompletion<GetSubscriptionDetailsResponse>)

    func cancelSubscription(accessToken: String,
                            projectId: Int,
                            subscriptionId: String,
                            completion: @escaping SubscriptionsAPICompletion<APIEmptyResponse>)

    func getSubscriptionRenewalUrl(accessToken: String,
                                   projectId: Int,
                                   subscriptionId: String,
                                   completion: @escaping SubscriptionsAPICompletion<GetSubscriptionRenewalUrlResponse>)

    func getSubscriptionPurchaseUrl(accessToken: String,
                                    projectId: Int,
                                    planExternalId: String,
                                    country: String?,
                                    paystationSettings: PaystationSettings?,
                                    completion: @escaping SubscriptionsAPICompletion<GetSubscriptionPurchaseUrlResponse>)

    func getSubscriptionManagementUrl(accessToken: String,
                                      projectId: Int,
                                      country: String?,
                                      completion: @escaping SubscriptionsAPICompletion<GetSubscriptionManagementUrlResponse>)
}
