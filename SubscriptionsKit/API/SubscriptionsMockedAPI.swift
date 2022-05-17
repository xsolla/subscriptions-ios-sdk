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

class SubscriptionsMockedAPI: SubscriptionsAPIProtocol
{
    let requestPerformer: RequestPerformer
    let responseProcessor: ResponseProcessor
    
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
        request.perform(withResponseJSONString: subscriptionsPlansResponseJSON, statusCode: 400, completionHandler: completion)
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
        request.perform(withResponseJSONString: subscriptionsPlansResponseJSON, completionHandler: completion)
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
        request.perform(withResponseJSONString: error400int, statusCode: 400, completionHandler: completion)
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
        request.perform(withResponseJSONString: subscriptionDetailsResponseJSON, completionHandler: completion)
        
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
        request.perform(withResponseJSONString: "", completionHandler: completion)
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
        request.perform(withResponseJSONString: linkToPSResponseJSON, completionHandler: completion)
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
        request.perform(withResponseJSONString: linkToPSResponseJSON, completionHandler: completion)
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
        request.perform(withResponseJSONString: linkToPSResponseJSON, completionHandler: completion)
    }
    
    
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
    
    var configuration: SubscriptionsAPIConfiguration
    {
        SubscriptionsAPIConfiguration(requestPerformer: requestPerformer,
                                      responseProcessor: responseProcessor,
                                      apiBasePath: "https://subscriptions.xsolla.com/api")
    }
    
    var subscriptionsPlansResponseJSON: String
    {
"""
{
  "items": [
    {
      "plan_id": 54321,
      "plan_external_id": "PlanExternalId",
      "plan_group_id": "TestGroupId",
      "plan_type": "all",
      "plan_name": "Localized plan name",
      "plan_description": "Localized plan description",
      "plan_start_date": "2021-04-11T13:51:02+03:00",
      "plan_end_date": "2031-04-11T13:51:02+03:00",
      "trial_period": 7,
      "period": {
        "value": 1,
        "unit": "month"
      },
      "charge": {
        "amount": 4.99,
        "setup_fee": 0.99,
        "currency": "USD"
      },
      "promotion": {
        "promotion_charge_amount": 3.99,
        "promotion_remaining_charges": 3
      }
    }
  ],
  "has_more": false
}
"""
    }
    
    var subscriptionsResponseJSON: String
    {
"""
{
  "items": [
    {
      "id": 12345,
      "plan_id": 54321,
      "plan_external_id": "PlanExternalId",
      "plan_name": "Localized plan name",
      "plan_description": "Localized plan description",
      "plan_start_date": "2021-04-11T13:51:02+03:00",
      "plan_end_date": "2031-04-11T13:51:02+03:00",
      "product_id": 12345,
      "product_external_id": "ProductExternalId",
      "product_name": "Product name",
      "product_description": "Localized product description",
      "status": "active",
      "is_in_trial": false,
      "trial_period": 0,
      "date_create": "2031-04-11T13:51:02+03:00",
      "date_next_charge": "2031-04-11T13:51:02+03:00",
      "date_last_charge": "2031-04-11T13:51:02+03:00",
      "charge": {
        "amount": 4.99,
        "amount_with_promotion": 3.99,
        "currency": "USD"
      },
      "period": {
        "value": 1,
        "unit": "month"
      }
    }
  ],
  "has_more": false
}
"""
    }
    
    var subscriptionDetailsResponseJSON: String
    {
"""
{
  "id": 12345,
  "plan_id": 54321,
  "plan_external_id": "PlanExternalId",
  "plan_name": "Localized plan name",
  "plan_description": "Localized plan description",
  "plan_start_date": "2021-04-11T13:51:02+03:00",
  "plan_end_date": "2031-04-11T13:51:02+03:00",
  "product_id": 12345,
  "product_external_id": "ProductExternalId",
  "product_name": "Product name",
  "product_description": "Localized product description",
  "status": "active",
  "is_in_trial": false,
  "trial_period": 0,
  "date_create": "2031-04-11T13:51:02+03:00",
  "date_next_charge": "2031-04-11T13:51:02+03:00",
  "date_last_charge": "2031-04-11T13:51:02+03:00",
  "date_end": "2031-04-11T13:51:02+03:00",
  "charge": {
    "amount": 4.99,
    "amount_with_promotion": 3.99,
    "currency": "USD"
  },
  "period": {
    "value": 1,
    "unit": "month"
  },
  "is_renew_possible": true,
  "is_change_to_non_renew_possible": true,
  "is_change_plan_allowed": false
}
"""
    }
    
    var linkToPSResponseJSON: String
    {
"""
{
  "link_to_ps": "https://secure.xsolla.com/paystation2/?access_token=lifuhwefuiywegfuiywegfiuewgfakuifgadu"
}
"""
    }
    
    var error400int: String
    {
"""
{
  "error": {
    "code": 400,
    "description": "Subscription is not active"
  },
  "request_id": "e54d2081-33cc-4682-b65c-b22d98686d0a"
}
"""
    }
    var error400string: String
    {
"""
{
  "error": {
    "code": "subscriptions.access_denied",
    "description": "You don't have access to requested project or resource."
  },
  "request_id": "2ebee326-546d-4a4c-b6cb-bd8631140117"
}
"""
    }
    
    var error422: String
    {
"""
{
  "error": {
    "code": "subscriptions.bad_request",
    "description": [
      {
        "property": "promotions",
        "message": "This value should be of type iterable."
      },
      {
        "property": "promotions",
        "message": "This value should be of type array|Countable."
      }
    ]
  },
  "request_id": "63e9a2d8-dbfa-45d0-b6c3-5054a4b0a875"
}
"""
    }
}
private extension APIRequestProtocol
{
    func perform(withResponseJSONString json: String, statusCode code: Int = 200, completionHandler: Callback)
    {
        let request = self.request
        let processor = apiConfiguration.responseProcessor
        
        let response = HTTPURLResponse(url: request.url!.absoluteURL, statusCode: code, httpVersion: nil, headerFields: nil)
        
        let result: Result<ResponseModel, ErrorType> = processor.process(response: response,
                                                                         data: json.data(using: .utf8),
                                                                         request: request,
                                                                         error: nil,
                                                                         errorHandler: errorHandler,
                                                                         decoder: customJSONDecoder)
        switch result
        {
        case .success(let model): do
            {
                DispatchQueue.main.async { self.handleSuccess(model: model, completionHandler: completionHandler) }
            }
            
        case .failure(let error): do
            {
                logger.error(.networking, domain: .coreAPI) { error }
                DispatchQueue.main.async { self.handleFailure(error: error, completionHandler: completionHandler) }
            }
        }
    }
}
