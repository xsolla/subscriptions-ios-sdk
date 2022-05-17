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

protocol ModelFactoryProtocol
{
    func getSubscriptionPublicPlansModel(response: GetSubscriptionPublicPlansResponse) -> SubscriptionPlans
    func getSubscriptionPlansModel(response: GetSubscriptionPlansResponse) -> SubscriptionPlans
    func getSubscriptionsModel(response: GetSubscriptionsResponse) -> Subscriptions
    func getSubscriptionDetailsModel(response: GetSubscriptionDetailsResponse) -> SubscriptionDetails
    func getUserPaystationUrl(response: UrlToPaystationResponse) -> PaystationUrl
}

class SubscriptionsKitModelFactory: ModelFactoryProtocol
{
    func getSubscriptionPublicPlansModel(response: GetSubscriptionPublicPlansResponse) -> SubscriptionPlans
    {
        let items = response.items.map
        { (item) -> SubscriptionPlans.Plan in

            let period = Period(value: item.period.value, unit: item.period.unit)
            let charge = Charge(amount: item.charge.amount,
                                setupFee: item.charge.setupFee,
                                currency: item.charge.currency)
            
            let promotion = Promotion(promotionChargeAmount: item.promotion.promotionChargeAmount,
                                      promotionRemainingCharges: item.promotion.promotionRemainingCharges)

            return SubscriptionPlans.Plan(planId: item.planId,
                                    planExternalId: item.planExternalId,
                                    planGroupId: item.planGroupId,
                                    planType: item.planType,
                                    planName: item.planName,
                                    planDescription: item.planDescription,
                                    planStartDate: item.planStartDate,
                                    planEndDate: item.planEndDate,
                                    trialPeriod: item.trialPeriod,
                                    period: period,
                                    charge: charge,
                                    promotion: promotion)
        }

        return SubscriptionPlans(items: items, hasMore: response.hasMore)
    }

    func getSubscriptionPlansModel(response: GetSubscriptionPlansResponse) -> SubscriptionPlans
    {
        let items = response.items.map
        { (item) -> SubscriptionPlans.Plan in

            let period = Period(value: item.period.value, unit: item.period.unit)
            let charge = Charge(amount: item.charge.amount,
                                setupFee: item.charge.setupFee,
                                currency: item.charge.currency)

            let promotion = Promotion(promotionChargeAmount: item.promotion.promotionChargeAmount,
                                      promotionRemainingCharges: item.promotion.promotionRemainingCharges)

            return SubscriptionPlans.Plan(planId: item.planId,
                                    planExternalId: item.planExternalId,
                                    planGroupId: item.planGroupId,
                                    planType: item.planType,
                                    planName: item.planName,
                                    planDescription: item.planDescription,
                                    planStartDate: item.planStartDate,
                                    planEndDate: item.planEndDate,
                                    trialPeriod: item.trialPeriod,
                                    period: period,
                                    charge: charge,
                                    promotion: promotion)
        }

        return SubscriptionPlans(items: items, hasMore: response.hasMore)
    }

    func getSubscriptionsModel(response: GetSubscriptionsResponse) -> Subscriptions
    {
        let items = response.items.map
        { (item) -> Subscriptions.Subscription in

            let period = Period(value: item.period.value, unit: item.period.unit)
            let charge = SubscriptionCharge(amount: item.charge.amount,
                                            amountWithPromotion: item.charge.amountWithPromotion,
                                            currency: item.charge.currency)

            return Subscriptions.Subscription(id: item.id,
                                              planId: item.planId,
                                              planExternalId: item.planExternalId,
                                              planName: item.planName,
                                              planDescription: item.planDescription,
                                              planStartDate: item.planStartDate,
                                              planEndDate: item.planEndDate,
                                              productId: item.productId,
                                              productExternalId: item.productExternalId,
                                              productName: item.productName,
                                              productDescription: item.productDescription,
                                              status: item.status,
                                              isInTrial: item.isInTrial,
                                              trialPeriod: item.trialPeriod,
                                              dateCreate: item.dateCreate,
                                              dateNextCharge: item.dateNextCharge,
                                              dateLastCharge: item.dateLastCharge,
                                              charge: charge,
                                              period: period)
        }

        return Subscriptions(items: items, hasMore: response.hasMore)
    }

    func getSubscriptionDetailsModel(response: GetSubscriptionDetailsResponse) -> SubscriptionDetails
    {
        let period = Period(value: response.period.value, unit: response.period.unit)
        let charge = SubscriptionCharge(amount: response.charge.amount,
                                        amountWithPromotion: response.charge.amountWithPromotion,
                                        currency: response.charge.currency)

        return SubscriptionDetails(id: response.id,
                                   planId: response.planId,
                                   planExternalId: response.planExternalId,
                                   planName: response.planName,
                                   planDescription: response.planDescription,
                                   planStartDate: response.planStartDate,
                                   planEndDate: response.planEndDate,
                                   productId: response.productId,
                                   productExternalId: response.productExternalId,
                                   productName: response.productName,
                                   productDescription: response.productDescription,
                                   status: response.status,
                                   isInTrial: response.isInTrial,
                                   trialPeriod: response.trialPeriod,
                                   dateCreate: response.dateCreate,
                                   dateNextCharge: response.dateNextCharge,
                                   dateLastCharge: response.dateLastCharge,
                                   dateEnd: response.dateEnd,
                                   charge: charge,
                                   period: period,
                                   isRenewPossible: response.isRenewPossible,
                                   isChangeToNonRenewPossible: response.isChangeToNonRenewPossible,
                                   isChangePlanAllowed: response.isChangePlanAllowed)
    }

    func getUserPaystationUrl(response: UrlToPaystationResponse) -> PaystationUrl
    {
        response.url
    }
}
