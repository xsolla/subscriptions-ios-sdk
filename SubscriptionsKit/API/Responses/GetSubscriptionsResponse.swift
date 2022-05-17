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

struct GetSubscriptionsResponse: Decodable
{
    let items: [Subscription]
    let hasMore: Bool

    init(items: [Subscription], hasMore: Bool)
    {
        self.items = items
        self.hasMore = hasMore
    }

    enum CodingKeys: String, CodingKey
    {
        case items
        case hasMore = "has_more"
    }
}

extension GetSubscriptionsResponse
{
    struct Subscription: Decodable
    {
        let id: Int
        let planId: Int
        let planExternalId: String
        let planName: String
        let planDescription: String
        let planStartDate: Date?
        let planEndDate: Date?
        let productId: Int?
        let productExternalId: String?
        let productName: String?
        let productDescription: String?
        let status: String
        let isInTrial: Bool
        let trialPeriod: Int?
        let dateCreate: Date
        let dateNextCharge: Date?
        let dateLastCharge: Date?
        let charge: Charge
        let period: Period

        init(id: Int,
             planId: Int,
             planExternalId: String,
             planName: String,
             planDescription: String,
             planStartDate: Date? = nil,
             planEndDate: Date? = nil,
             productId: Int? = nil,
             productExternalId: String? = nil,
             productName: String? = nil,
             productDescription: String? = nil,
             status: String,
             isInTrial: Bool,
             trialPeriod: Int? = nil,
             dateCreate: Date,
             dateNextCharge: Date? = nil,
             dateLastCharge: Date? = nil,
             charge: Charge,
             period: Period)
        {
            self.id = id
            self.planId = planId
            self.planExternalId = planExternalId
            self.planName = planName
            self.planDescription = planDescription
            self.planStartDate = planStartDate
            self.planEndDate = planEndDate
            self.productId = productId
            self.productExternalId = productExternalId
            self.productName = productName
            self.productDescription = productDescription
            self.status = status
            self.isInTrial = isInTrial
            self.trialPeriod = trialPeriod
            self.dateCreate = dateCreate
            self.dateNextCharge = dateNextCharge
            self.dateLastCharge = dateLastCharge
            self.charge = charge
            self.period = period
        }

        enum CodingKeys: String, CodingKey
        {
            case id
            case planId = "plan_id"
            case planExternalId = "plan_external_id"
            case planName = "plan_name"
            case planDescription = "plan_description"
            case planStartDate = "plan_start_date"
            case planEndDate = "plan_end_date"
            case productId = "product_id"
            case productExternalId = "product_external_id"
            case productName = "product_name"
            case productDescription = "product_description"
            case status
            case isInTrial = "is_in_trial"
            case trialPeriod = "trial_period"
            case dateCreate = "date_create"
            case dateNextCharge = "date_next_charge"
            case dateLastCharge = "date_last_charge"
            case charge
            case period
        }
    }
}

extension GetSubscriptionsResponse.Subscription
{
    struct Charge: Decodable
    {
        let amount: Float
        let amountWithPromotion: Float?
        let currency: String
        
        init(amount: Float, amountWithPromotion: Float? = nil, currency: String)
        {
            self.amount = amount
            self.amountWithPromotion = amountWithPromotion
            self.currency = currency
        }
        
        enum CodingKeys: String, CodingKey
        {
            case amount
            case amountWithPromotion = "amount_with_promotion"
            case currency
        }
    }
}

extension GetSubscriptionsResponse.Subscription
{
    struct Period: Decodable
    {
        let value: Int
        let unit: String

        init(value: Int, unit: String)
        {
            self.value = value
            self.unit = unit
        }
    }
}
