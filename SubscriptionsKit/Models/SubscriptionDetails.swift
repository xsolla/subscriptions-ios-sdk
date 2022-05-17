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

/// Extended subscription information.
public struct SubscriptionDetails
{
    /// Subscription ID.
    public let id: Int

    /// Subscription plan ID.
    public let planId: Int

    /// Subscription plan external ID (32 characters).
    public let planExternalId: String

    /// Plan name. Value consists of pairs `localization`:`plan name`. `localization’ can be `en` for English, `ru` for Russian, `cs` for Czech, `ar` for Arabic, `bg` for Bulgarian, `cn` for Chinese (Simplified), `tw` for Chinese (Traditional), `fr` for French, `de` for German, `he` for Hebrew, `it` for Italian, `ko` for Korean, `pl` for Polish, `pt` for Portuguese, `ro` for Romanian, `es` for Spanish, `th` for Thai, `tr` for Turkish, `vi` for Vietnamese, `ja` for Japanese.
    public let planName: String

    /// Plan description. Value consists of pairs `localization`:`plan description`. `localization’ can be `en` for English, `ru` for Russian, `cs` for Czech, `ar` for Arabic, `bg` for Bulgarian, `cn` for Chinese (Simplified), `tw` for Chinese (Traditional), `fr` for French, `de` for German, `he` for Hebrew, `it` for Italian, `ko` for Korean, `pl` for Polish, `pt` for Portuguese, `ro` for Romanian, `es` for Spanish, `th` for Thai, `tr` for Turkish, `vi` for Vietnamese, `ja` for Japanese.
    public let planDescription: String

    /// Start date of the season pass.
    public let planStartDate: Date?

    /// End date of the season pass.
    public let planEndDate: Date?

    /// Product ID the subscription plan is linked to.
    public let productId: Int?

    /// Product external ID the subscription plan is linked to.
    public let productExternalId: String?

    /// Product name.
    public let productName: String?

    /// Product descriptions. Value consists of pairs `localization`:`product description`. `localization’ can be `en` for English, `ru` for Russian, `cs` for Czech, `ar` for Arabic, `bg` for Bulgarian, `cn` for Chinese (Simplified), `tw` for Chinese (Traditional), `fr` for French, `de` for German, `he` for Hebrew, `it` for Italian, `ko` for Korean, `pl` for Polish, `pt` for Portuguese, `ro` for Romanian, `es` for Spanish, `th` for Thai, `tr` for Turkish, `vi` for Vietnamese, `ja` for Japanese.
    public let productDescription: String?

    /// Subscription status. Can be `active`, `canceled`, `non_renewing`, or `pause`.
    public let status: String

    /// Whether the subscription is on trial period.
    public let isInTrial: Bool

    /// Trial period in time periods.
    public let trialPeriod: Int?

    /// Creation date of the subscription.
    public let dateCreate: Date

    /// Date of the next subscription charge.
    public let dateNextCharge: Date?

    /// Date of the last subscription charge.
    public let dateLastCharge: Date?

    /// Subscription end date.
    public let dateEnd: Date?

    /// Subscription billing details.
    public let charge: SubscriptionCharge

    /// Time period in units.
    public let period: Period

    /// Whether the subscription renewal is possible.
    public let isRenewPossible: Bool

    /// Whether the change of subscription plan to non-renewable is possible.
    public let isChangeToNonRenewPossible: Bool

    /// Whether the change of subscription plan is allowed.
    public let isChangePlanAllowed: Bool
}
