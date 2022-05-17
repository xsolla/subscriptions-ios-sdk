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

public final class SubscriptionsKit
{
    public static let shared = SubscriptionsKit()

    private var api: SubscriptionsAPIProtocol
    private var modelFactory: ModelFactoryProtocol
    private var errorTranslator: ErrorTranslatorProtocol

    convenience init()
    {
        let requestPerformer = XSDKNetwork(sessionConfiguration: XSDKNetwork.defaultSessionConfiguration)
        let responseProcessor = SubscriptionsAPIResponseProcessor()
        let api = SubscriptionsAPI(requestPerformer: requestPerformer, responseProcessor: responseProcessor)
        let modelFactory = SubscriptionsKitModelFactory()
        let errorTranslator = SubscriptionsKitErrorTranslator()

        self.init(api: api, modelFactory: modelFactory, errorTranslator: errorTranslator)
    }

    init(api: SubscriptionsAPIProtocol, modelFactory: ModelFactoryProtocol, errorTranslator: ErrorTranslatorProtocol)
    {
        self.api = api
        self.modelFactory = modelFactory
        self.errorTranslator = errorTranslator
    }
}

// MARK: - Public API

extension SubscriptionsKit
{
    /**
    Returns a list of all subscription plans, excluding promotions. Doesn’t require user authorization.

     - Parameters:
       - projectId: Project ID, can be found in Publisher Account next to the name of the project. **Required**.
       - planId: Array of subscription plan IDs. Plan ID can be found in the URL of the subscription details page in Publisher Account (`https://publisher.xsolla.com/{merchant_id}/projects/{project_id}/subscriptions/plans/{merplan_id}`).
       - planExternalId: List of subscription plan external IDs (32 characters per ID). Plan external ID can be found in Publisher Account in the **Subscriptions > Subscription plans** section next to the plan name.
       - limit: Limit for the number of elements on the page (15 elements are displayed by default).
       - offset: Number of elements from which the list is generated (the count starts from 0).
       - locale: Language of the UI. By default, it is determined by the user's IP address. Can be enforced by using an ISO 639-1 code.
       - сountry: User's country. Affects the choice of locale and currency. By default, it is determined by the user's IP address.
       - сompletion: Closure with `Result`: `SubscriptionPlans` in case of success and `Error` in case of failure.
     */

    public func getSubscriptionPublicPlans(projectId: Int,
                                           planId: [Int]? = nil,
                                           planExternalId: [Int]? = nil,
                                           limit: Int? = nil,
                                           offset: Int? = nil,
                                           locale: String? = nil,
                                           country: String? = nil,
                                           completion: @escaping (Result<SubscriptionPlans, Error>) -> Void)
    {
        let factory = modelFactory
        let translator = errorTranslator

        api.getSubscriptionPublicPlans(projectId: projectId,
                                       planId: planId,
                                       planExternalId: planExternalId,
                                       limit: limit,
                                       offset: offset,
                                       locale: locale,
                                       country: country)
        { result in

            completion(result
                .map { factory.getSubscriptionPublicPlansModel(response: $0) }
                .mapError { translator.translateError($0) }
            )
        }
    }

    /**
    Returns a list of all plans, including plans purchased by the user while promotions are active.

     - Parameters:
       - accessToken: User JWT obtained during authorization using [Xsolla Login](https://developers.xsolla.com/doc/login/).
       - projectId: Project ID, can be found in Publisher Account next to the name of the project. **Required**.
       - planId: Array of subscription plan IDs. Plan ID can be found in the URL of the subscription details page in Publisher Account (`https://publisher.xsolla.com/{merchant_id}/projects/{project_id}/subscriptions/plans/{merplan_id}`).
       - planExternalId: List of subscription plan external IDs (32 characters per ID). Plan external ID can be found in Publisher Account in the **Subscriptions > Subscription plans** section next to the plan name.
       - limit: Limit for the number of elements on the page (15 elements are displayed by default).
       - offset: Number of elements from which the list is generated (the count starts from 0).
       - locale: Language of the UI. By default, it is determined by the user's IP address. Can be enforced by using an ISO 639-1 code.
       - country: User's country. Affects the choice of locale and currency. By default, it is determined by the user's IP address.
       - completion: Closure with `Result`: `SubscriptionPlans` in case of success and `Error` in case of failure.
     */

    public func getSubscriptionPlans(accessToken: String,
                                     projectId: Int,
                                     planId: [Int]? = nil,
                                     planExternalId: [Int]? = nil,
                                     limit: Int? = nil,
                                     offset: Int? = nil,
                                     locale: String? = nil,
                                     country: String? = nil,
                                     completion: @escaping (Result<SubscriptionPlans, Error>) -> Void)
    {
        let factory = modelFactory
        let translator = errorTranslator

        api.getSubscriptionPlans(accessToken: accessToken,
                                 projectId: projectId,
                                 planId: planId,
                                 planExternalId: planExternalId,
                                 limit: limit,
                                 offset: offset,
                                 locale: locale,
                                 country: country)
        { result in

            completion(result
                .map { factory.getSubscriptionPlansModel(response: $0) }
                .mapError { translator.translateError($0) }
            )
        }
    }

    /**
    Returns a list of active recurrent subscriptions that have the status `active`, `non renewing`, and `pause`.

     - Parameters:
       - accessToken: User JWT obtained during authorization using [Xsolla Login](https://developers.xsolla.com/doc/login/).
       - projectId: Project ID, can be found in Publisher Account next to the name of the project. **Required**.
       - limit: Limit for the number of elements on the page (15 elements are displayed by default).
       - offset: Number of elements from which the list is generated (the count starts from 0).
       - locale: Language of the UI. By default, it is determined by the user's IP address. Can be enforced by using an ISO 639-1 code.
       - сountry: User's country. Affects the choice of locale and currency. By default, it is determined by the user's IP address.
       - сompletion: Closure with `Result`: `Subscriptions` in case of success and `Error` in case of failure.
     */
    public func getSubscriptions(accessToken: String,
                                 projectId: Int,
                                 limit: Int? = nil,
                                 offset: Int? = nil,
                                 locale: String? = nil,
                                 completion: @escaping (Result<Subscriptions, Error>) -> Void)
    {
        let factory = modelFactory
        let translator = errorTranslator

        api.getSubscriptions(accessToken: accessToken,
                             projectId: projectId,
                             limit: limit,
                             offset: offset,
                             locale: locale)
        { result in

            completion(result
                .map { factory.getSubscriptionsModel(response: $0) }
                .mapError { translator.translateError($0) }
            )
        }
    }

    /**
    Returns information about a subscription by its ID. Subscription can be in any status.

     - Parameters:
       - accessToken: User JWT obtained during authorization using [Xsolla Login](https://developers.xsolla.com/doc/login/).
       - projectId: Project ID, can be found in Publisher Account next to the name of the project. **Required**.
       - subscriptionId: Subscription ID. **Required**.
       - locale: Language of the UI. By default, it is determined by the user's IP address. Can be enforced by using an ISO 639-1 code.
       - сompletion: Closure with `Result`: `SubscriptionDetails` in case of success and `Error` in case of failure.
     */

    public func getSubscriptionDetails(accessToken: String,
                                       projectId: Int,
                                       subscriptionId: String,
                                       locale: String? = nil,
                                       completion: @escaping (Result<SubscriptionDetails, Error>) -> Void)
    {
        let factory = modelFactory
        let translator = errorTranslator

        api.getSubscriptionDetails(accessToken: accessToken, projectId: projectId, subscriptionId: subscriptionId, locale: locale)
        { result in

            completion(result
                .map { factory.getSubscriptionDetailsModel(response: $0) }
                .mapError { translator.translateError($0) }
            )
        }
    }

    /**
    Changes a regular subscription status to non_renewing (subscription is automatically canceled after expiration).

     - Parameters:
       - accessToken: User JWT obtained during authorization using [Xsolla Login](https://developers.xsolla.com/doc/login/).
       - projectId: Project ID, can be found in Publisher Account next to the name of the project. **Required**.
       - subscriptionId: Subscription ID. **Required**.
       - сompletion: Closure with `Result`: `Void` in case of success and `Error` in case of failure.
     */

    public func cancelSubscription(accessToken: String, projectId: Int, subscriptionId: String,
                                   completion: @escaping (Result<Void, Error>) -> Void)
    {
        let translator = errorTranslator

        api.cancelSubscription(accessToken: accessToken, projectId: projectId, subscriptionId: subscriptionId)
        { result in

            completion(result
                .map { _ in () }
                .mapError { translator.translateError($0) }
            )
        }

    }

    /**
    Returns Pay Station URL for the subscription renewal.

     - Parameters:
       - accessToken: User JWT obtained during authorization using [Xsolla Login](https://developers.xsolla.com/doc/login/).
       - projectId: Project ID, can be found in Publisher Account next to the name of the project. **Required**.
       - subscriptionId: Subscription ID. **Required**.
       - сompletion: Closure with `Result`: `PaystationUrl` in case of success and `Error` in case of failure.
     */

    public func getSubscriptionRenewalUrl(accessToken: String,
                                          projectId: Int,
                                          subscriptionId: String,
                                          completion: @escaping (Result<PaystationUrl, Error>) -> Void)
    {
        let factory = modelFactory
        let translator = errorTranslator

        api.getSubscriptionRenewalUrl(accessToken: accessToken, projectId: projectId, subscriptionId: subscriptionId)
        { result in

            completion(result
                .map { factory.getUserPaystationUrl(response: $0) }
                .mapError { translator.translateError($0) }
            )
        }
    }

    /**
    Returns Pay Station URL for the subscription purchase.

     - Parameters:
       - accessToken: User JWT obtained during authorization using [Xsolla Login](https://developers.xsolla.com/doc/login/).
       - projectId: Project ID, can be found in Publisher Account next to the name of the project. **Required**.
       - planExternalId: List of subscription plan external IDs (32 characters per ID). Plan external ID can be found in Publisher Account in the **Subscriptions > Subscription plans** section next to the plan name.
       - country: User's country. Affects the choice of locale and currency. By default, it is determined by the user's IP address.
       - paystationSettings: Custom settings of Pay Station UI.
       - сompletion: Closure with `Result`: `PaystationUrl` in case of success and `Error` in case of failure.
     */

    public func getSubscriptionPurchaseUrl(accessToken: String,
                                           projectId: Int,
                                           planExternalId: String,
                                           country: String? = nil,
                                           paystationSettings: PaystationSettings? = nil,
                                           completion: @escaping (Result<PaystationUrl, Error>) -> Void)
    {
        let factory = modelFactory
        let translator = errorTranslator

        api.getSubscriptionPurchaseUrl(accessToken: accessToken,
                                       projectId: projectId,
                                       planExternalId: planExternalId,
                                       country: country,
                                       paystationSettings: paystationSettings)
        { result in

            completion(result
                .map { factory.getUserPaystationUrl(response: $0) }
                .mapError { translator.translateError($0) }
            )
        }
    }

    /**
    Returns Pay Station URL for the subscription management.

     - Parameters:
       - accessToken: User JWT obtained during authorization using [Xsolla Login](https://developers.xsolla.com/doc/login/).
       - projectId: Project ID, can be found in Publisher Account next to the name of the project. **Required**.
       - country: User's country. Affects the choice of locale and currency. By default, it is determined by the user's IP address.
       - сompletion: Closure with `Result`: `PaystationUrl` in case of success and `Error` in case of failure.
     */

    public func getSubscriptionManagementUrl(accessToken: String,
                                             projectId: Int,
                                             country: String? = nil,
                                             completion: @escaping (Result<PaystationUrl, Error>) -> Void)
    {
        let factory = modelFactory
        let translator = errorTranslator

        api.getSubscriptionManagementUrl(accessToken: accessToken,
                                         projectId: projectId,
                                         country: country)
        { result in

            completion(result
                .map { factory.getUserPaystationUrl(response: $0) }
                .mapError { translator.translateError($0) }
            )
        }
    }
}
