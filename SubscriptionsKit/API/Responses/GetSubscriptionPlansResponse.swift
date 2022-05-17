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

struct GetSubscriptionPlansResponse: Decodable
{
    let items: [Plan]
    let hasMore: Bool

    init(items: [Plan], hasMore: Bool)
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

extension GetSubscriptionPlansResponse
{
    struct Plan: Decodable
    {
        let planId: Int
        let planExternalId: String
        let planGroupId: String?
        let planType: String
        let planName: String
        let planDescription: String
        let planStartDate: Date?
        let planEndDate: Date?
        let trialPeriod: Int?
        let period: Period
        let charge: Charge
        let promotion: Promotion

        init(planId: Int,
             planExternalId: String,
             planGroupId: String? = nil,
             planType: String,
             planName: String,
             planDescription: String,
             planStartDate: Date? = nil,
             planEndDate: Date? = nil,
             trialPeriod: Int? = nil,
             period: Period,
             charge: Charge,
             promotion: Promotion)
        {
            self.planId = planId
            self.planExternalId = planExternalId
            self.planGroupId = planGroupId
            self.planType = planType
            self.planName = planName
            self.planDescription = planDescription
            self.planStartDate = planStartDate
            self.planEndDate = planEndDate
            self.trialPeriod = trialPeriod
            self.period = period
            self.charge = charge
            self.promotion = promotion
        }

        enum CodingKeys: String, CodingKey
        {
            case planId = "plan_id"
            case planExternalId = "plan_external_id"
            case planGroupId = "plan_group_id"
            case planType = "plan_type"
            case planName = "plan_name"
            case planDescription = "plan_description"
            case planStartDate = "plan_start_date"
            case planEndDate = "plan_end_date"
            case trialPeriod = "trial_period"
            case period
            case charge
            case promotion
        }
    }
}

extension GetSubscriptionPlansResponse.Plan
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

    struct Charge: Decodable
    {
        let amount: Float
        let setupFee: Float?
        let currency: String

        init(amount: Float, setupFee: Float? = nil, currency: String)
        {
            self.amount = amount
            self.setupFee = setupFee
            self.currency = currency
        }

        enum CodingKeys: String, CodingKey
        {
            case amount
            case setupFee = "setup_fee"
            case currency
        }
    }

    struct Promotion: Decodable
    {
        let promotionChargeAmount: Float?
        let promotionRemainingCharges: Int?

        init(promotionChargeAmount: Float? = nil, promotionRemainingCharges: Int? = nil)
        {
            self.promotionChargeAmount = promotionChargeAmount
            self.promotionRemainingCharges = promotionRemainingCharges
        }

        enum CodingKeys: String, CodingKey
        {
            case promotionChargeAmount = "promotion_charge_amount"
            case promotionRemainingCharges = "promotion_remaining_charges"
        }
    }
}
