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

/// List of subscription plans.
public struct SubscriptionPlans
{
    public let items: [Plan]
    public let hasMore: Bool

    public struct Plan
    {
        /// Subscription plan ID.
        public let planId: Int

        /// Subscription plan external ID (32 characters).
        public let planExternalId: String

        /// Group ID the plan is linked to.
        public let planGroupId: String?

        /// Plan type. **Deprecated**, always returns `all`.
        public let planType: String

        /// Plan name. Value consists of pairs `localization`:`plan name`. `localization’ can be `en` for English, `ru` for Russian, `cs` for Czech, `ar` for Arabic, `bg` for Bulgarian, `cn` for Chinese (Simplified), `tw` for Chinese (Traditional), `fr` for French, `de` for German, `he` for Hebrew, `it` for Italian, `ko` for Korean, `pl` for Polish, `pt` for Portuguese, `ro` for Romanian, `es` for Spanish, `th` for Thai, `tr` for Turkish, `vi` for Vietnamese, `ja` for Japanese.
        public let planName: String

        /// Plan description. Value consists of pairs `localization`:`plan description`. `localization’ can be `en` for English, `ru` for Russian, `cs` for Czech, `ar` for Arabic, `bg` for Bulgarian, `cn` for Chinese (Simplified), `tw` for Chinese (Traditional), `fr` for French, `de` for German, `he` for Hebrew, `it` for Italian, `ko` for Korean, `pl` for Polish, `pt` for Portuguese, `ro` for Romanian, `es` for Spanish, `th` for Thai, `tr` for Turkish, `vi` for Vietnamese, `ja` for Japanese.
        public let planDescription: String

        /// Start date of the season pass.
        public let planStartDate: Date?

        /// End date of the season pass.
        public let planEndDate: Date?

        /// Trial period in time periods.
        public let trialPeriod: Int?

        /// Time period in units.
        public let period: Period

        /// Billing details.
        public let charge: Charge

        /// Billing details by promotion.
        public let promotion: Promotion
    }
}
