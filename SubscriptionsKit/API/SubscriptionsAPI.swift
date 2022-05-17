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

class SubscriptionsAPI
{
    let requestPerformer: RequestPerformer
    let responseProcessor: ResponseProcessor
    
    init(requestPerformer: RequestPerformer, responseProcessor: ResponseProcessor)
    {
        logger.debug(.initialization, domain: .subscriptionsKit) { String(describing: Self.self) }
        
        self.requestPerformer = requestPerformer
        self.responseProcessor = responseProcessor
    }
    
    deinit
    {
        let deinitingType = String(describing: type(of: self))
        logger.debug(.deinitialization, domain: .subscriptionsKit) { deinitingType }
    }
}

extension SubscriptionsAPI: SubscriptionsAPIProtocol
{
    func getSubscriptionPublicPlans(projectId: Int,
                                    planId: [Int]?,
                                    planExternalId: [Int]?,
                                    limit: Int?,
                                    offset: Int?,
                                    locale: String?,
                                    country: String?,
                                    completion: @escaping SubscriptionsAPICompletion<GetSubscriptionPublicPlansResponse>)
    {
        let params = GetSubscriptionPublicPlansRequest.Params(projectId: projectId,
                                                              planId: planId,
                                                              planExternalId: planExternalId,
                                                              limit: limit,
                                                              offset: offset,
                                                              locale: locale,
                                                              country: country)
        
        let request = GetSubscriptionPublicPlansRequest(params: params, apiConfiguration: configuration)
        request.perform(completionHandler: completion)
    }
    
    func getSubscriptionPlans(accessToken: String,
                              projectId: Int,
                              planId: [Int]?,
                              planExternalId: [Int]?,
                              limit: Int?,
                              offset: Int?,
                              locale: String?,
                              country: String?,
                              completion: @escaping SubscriptionsAPICompletion<GetSubscriptionPlansResponse>)
    {
        let params = GetSubscriptionPlansRequest.Params(accessToken: accessToken,
                                                        projectId: projectId,
                                                        planId: planId,
                                                        planExternalId: planExternalId,
                                                        limit: limit,
                                                        offset: offset,
                                                        locale: locale,
                                                        country: country)
        
        let request = GetSubscriptionPlansRequest(params: params, apiConfiguration: configuration)
        request.perform(completionHandler: completion)
    }
    
    func getSubscriptions(accessToken: String,
                          projectId: Int,
                          limit: Int?,
                          offset: Int?,
                          locale: String?,
                          completion: @escaping SubscriptionsAPICompletion<GetSubscriptionsResponse>)
    {
        let params = GetSubscriptionsRequest.Params(accessToken: accessToken,
                                                    projectId: projectId,
                                                    limit: limit,
                                                    offset: offset,
                                                    locale: locale)
        
        let request = GetSubscriptionsRequest(params: params, apiConfiguration: configuration)
        request.perform(completionHandler: completion)
    }
    
    func getSubscriptionDetails(accessToken: String,
                                projectId: Int,
                                subscriptionId: String,
                                locale: String?,
                                completion: @escaping SubscriptionsAPICompletion<GetSubscriptionDetailsResponse>)
    {
        let params = GetSubscriptionDetailsRequest.Params(accessToken: accessToken,
                                                          projectId: projectId,
                                                          subscriptionId: subscriptionId,
                                                          locale: locale)
        
        let request = GetSubscriptionDetailsRequest(params: params, apiConfiguration: configuration)
        request.perform(completionHandler: completion)
        
    }
    
    func cancelSubscription(accessToken: String,
                            projectId: Int,
                            subscriptionId: String,
                            completion: @escaping SubscriptionsAPICompletion<APIEmptyResponse>)
    {
        let params = СancelSubscriptionRequest.Params(accessToken: accessToken,
                                                      projectId: projectId,
                                                      subscriptionId: subscriptionId)
        
        let request = СancelSubscriptionRequest(params: params, apiConfiguration: configuration)
        request.perform(completionHandler: completion)
    }
    
    func getSubscriptionRenewalUrl(accessToken: String,
                                   projectId: Int,
                                   subscriptionId: String,
                                   completion: @escaping SubscriptionsAPICompletion<GetSubscriptionRenewalUrlResponse>)
    {
        let params = GetSubscriptionRenewalUrlRequest.Params(accessToken: accessToken,
                                                             projectId: projectId,
                                                             subscriptionId: subscriptionId)
        
        let request = GetSubscriptionRenewalUrlRequest(params: params, apiConfiguration: configuration)
        request.perform(completionHandler: completion)
    }
    
    func getSubscriptionPurchaseUrl(accessToken: String,
                                    projectId: Int,
                                    planExternalId: String,
                                    country: String?,
                                    paystationSettings: PaystationSettings?,
                                    completion: @escaping SubscriptionsAPICompletion<GetSubscriptionPurchaseUrlResponse>)
    {
        let params = GetSubscriptionPurchaseUrlRequest.Params(accessToken: accessToken,
                                                              projectId: projectId,
                                                              planExternalId: planExternalId,
                                                              country: country,
                                                              paystationSettings: paystationSettings)
        
        let request = GetSubscriptionPurchaseUrlRequest(params: params, apiConfiguration: configuration)
        request.perform(completionHandler: completion)
    }
    
    func getSubscriptionManagementUrl(accessToken: String,
                                      projectId: Int,
                                      country: String?,
                                      completion: @escaping SubscriptionsAPICompletion<GetSubscriptionManagementUrlResponse>)
    {
        let params = GetSubscriptionManagementUrlRequest.Params(accessToken: accessToken,
                                                                projectId: projectId,
                                                                country: country)
        
        let request = GetSubscriptionManagementUrlRequest(params: params, apiConfiguration: configuration)
        request.perform(completionHandler: completion)
    }
}

extension SubscriptionsAPI
{
    var configuration: SubscriptionsAPIConfiguration
    {
        SubscriptionsAPIConfiguration(requestPerformer: requestPerformer,
                                      responseProcessor: responseProcessor,
                                      apiBasePath: "https://subscriptions.xsolla.com/api")
    }
}
