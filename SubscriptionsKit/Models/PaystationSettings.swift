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

/// Custom Pay Station settings.

public struct PaystationSettings: Codable
{
    /// Whether to open payment UI in the sandbox mode. The option is available for users specified in the list of company users.
    public var sandbox: Bool?

    /// Pay Station interface settings.
    public var ui: UI?

    /// Preferred payment currency. Three-letter currency code per ISO 4217.
    public var currency: String?

    /// Interface language (English by default). Accepts values according to the ISO 639-1 standard.
    public var locale: String?

    /// Transaction ID in the game. Has to be unique for each user payment.
    public var externalId: String?

    /// Payment method ID.
    public var paymentMethod: Int?

    /// Page to redirect the user to after payment. Parameters `user_id`, `foreigninvoice`, `invoice_id` and `status` will be automatically added to the link.
    public var returnUrl: String?

    /// Redirect policy rules and settings.
    public var redirectPolicy: RedirectPolicy?

    public init(sandbox: Bool? = nil,
                ui: UI? = nil,
                currency: String? = nil,
                locale: String? = nil,
                externalId: String? = nil,
                paymentMethod: Int? = nil,
                returnUrl: String? = nil,
                redirectPolicy: RedirectPolicy? = nil)
    {
        self.sandbox = sandbox
        self.ui = ui
        self.currency = currency
        self.locale = locale
        self.externalId = externalId
        self.paymentMethod = paymentMethod
        self.returnUrl = returnUrl
        self.redirectPolicy = redirectPolicy
    }

    public enum CodingKeys: String, CodingKey
    {
        case sandbox
        case ui
        case currency
        case locale
        case externalId = "external_id"
        case paymentMethod = "payment_method"
        case returnUrl = "return_url"
        case redirectPolicy = "redirect_policy"
    }
}

extension PaystationSettings
{
    /// Pay Station interface settings.
    public struct UI: Codable
    {
        /// Payment UI size. Can be:
        /// - [small](https://livedemo.xsolla.com/developers/small/): the least possible size of the payment UI. Use this value when the window size is strictly limited (dimensions: 620 x 630).
        /// - [medium](https://livedemo.xsolla.com/developers/medium/): recommended size. Use this value to display the payment UI in a lightbox (dimensions: 740 x 760).
        /// - [large](https://livedemo.xsolla.com/developers/large/): the optimal size for displaying the payment UI in a new window or tab (dimensions: 820 x 840).\n
        public var size: Size?

        /// Payment UI theme. Can be `default` or `default_dark`.
        public var theme: String?

        /// Device type.
        public var version: Version?

        /// Interface settings for the desktop version.
        public var desktop: Desktop?

        /// Interface settings for the mobile version.
        public var mobile: Mobile?

        /// Link to the EULA.
        public var licenseUrl: String?

        /// Interface mode in Pay Station.
        public var mode: Mode?

        /// User account details.
        public var userAccount: UserAccount?

        public init(size: Size? = nil,
                    theme: String? = nil,
                    version: Version? = nil,
                    desktop: Desktop? = nil,
                    mobile: Mobile? = nil,
                    licenseUrl: String? = nil,
                    mode: Mode? = nil,
                    userAccount: UserAccount? = nil)
        {
            self.size = size
            self.theme = theme
            self.version = version
            self.desktop = desktop
            self.mobile = mobile
            self.licenseUrl = licenseUrl
            self.mode = mode
            self.userAccount = userAccount
        }

        public enum CodingKeys: String, CodingKey
        {
            case size
            case theme
            case version
            case desktop
            case mobile
            case licenseUrl = "license_url"
            case mode
            case userAccount = "user_account"
        }

        public enum Size: String, Codable
        {
            case large = "large"
            case medium = "medium"
            case small = "small"
        }

        public enum Version: String, Codable
        {
            case desktop = "desktop"
            case mobile = "mobile"
        }

        public enum Mode: String, Codable
        {
            case userAccount = "user_account"
            case withoutPurchase = "without_purchase"
        }
    }
}

extension PaystationSettings.UI
{
    public struct Desktop: Codable
    {
        /// Header settings.
        public var header: Header?

        public init(header: Header? = nil)
        {
            self.header = header
        }
    }

    /// Header settings.
    public struct Header: Codable
    {
        public var isVisible: Bool?
        public var visibleLogo: Bool?
        public var visibleName: Bool?
        public var type: ModelType?
        public var closeButton: Bool?

        public init(isVisible: Bool? = nil,
                    visibleLogo: Bool? = nil,
                    visibleName: Bool? = nil,
                    type: ModelType? = nil,
                    closeButton: Bool? = nil)
        {
            self.isVisible = isVisible
            self.visibleLogo = visibleLogo
            self.visibleName = visibleName
            self.type = type
            self.closeButton = closeButton
        }

        public enum CodingKeys: String, CodingKey
        {
            case isVisible = "is_visible"
            case visibleLogo = "visible_logo"
            case visibleName = "visible_name"
            case type
            case closeButton = "close_button"
        }

        public enum ModelType: String, Codable
        {
            case compact = "compact"
            case normal = "normal"
        }
    }
}

extension PaystationSettings.UI
{
    public struct Mobile: Codable
    {
        /// Interface mode in Pay Station.
        public var mode: Mode?

        /// Footer settings.
        public var footer: Footer?

        /// Header settings.
        public var header: Header?

        public init(mode: Mode? = nil, footer: Footer? = nil, header: Header? = nil)
        {
            self.mode = mode
            self.footer = footer
            self.header = header
        }

        public enum Mode: String, Codable
        {
            case savedAccounts = "saved_accounts"
        }

        public struct Footer: Codable
        {
            public var isVisible: Bool?

            public init(isVisible: Bool? = nil)
            {
                self.isVisible = isVisible
            }

            public enum CodingKeys: String, CodingKey
            {
                case isVisible = "is_visible"
            }
        }

        public struct Header: Codable
        {
            public var closeButton: Bool?

            public init(closeButton: Bool? = nil)
            {
                self.closeButton = closeButton
            }

            public enum CodingKeys: String, CodingKey
            {
                case closeButton = "close_button"
            }
        }
    }
}

extension PaystationSettings.UI
{
    /// User account details.
    public struct UserAccount: Codable
    {
        /// **History** submenu.
        public var history: History?

        /// **My payment accounts** submenu.
        public var paymentAccounts: PaymentAccounts?

        /// Page **My account**.
        public var info: Info?

        /// **Manage subscriptions** submenu.
        public var subscriptions: Subscriptions?

        public init(history: History? = nil,
                    paymentAccounts: PaymentAccounts? = nil,
                    info: Info? = nil,
                    subscriptions: Subscriptions? = nil)
        {
            self.history = history
            self.paymentAccounts = paymentAccounts
            self.info = info
            self.subscriptions = subscriptions
        }

        public enum CodingKeys: String, CodingKey
        {
            case history
            case paymentAccounts = "payment_accounts"
            case info
            case subscriptions
        }

        public struct History: Codable
        {
            public var enable: Bool?
            public var order: Int?

            public init(enable: Bool? = nil, order: Int? = nil)
            {
                self.enable = enable
                self.order = order
            }
        }

        public struct PaymentAccounts: Codable
        {
            public var enable: Bool?
            public var order: Int?

            public init(enable: Bool? = nil, order: Int? = nil)
            {
                self.enable = enable
                self.order = order
            }
        }

        public struct Subscriptions: Codable
        {
            public var enable: Bool?
            public var order: Int?

            public init(enable: Bool? = nil, order: Int? = nil)
            {
                self.enable = enable
                self.order = order
            }
        }

    }

    public struct Info: Codable
    {
        public var enable: Bool?
        public var order: Int?

        public init(enable: Bool? = nil, order: Int? = nil)
        {
            self.enable = enable
            self.order = order
        }
    }
}

extension PaystationSettings
{
    /// Redirect policy settings.
    public struct RedirectPolicy: Codable
    {
        /// Payment status that triggers user redirection to the return URL. Can be `none`, `successful`, `successful_or_canсeled`, or `any`.
        public var redirectConditions: RedirectConditions?

        /// Delay (in seconds) after which a user is automatically redirected to the return URL.
        public var delay: Int?

        /// Payment status that triggers the display of a button clicking which redirects the user to the return URL. Can be `none`, `successful`, `successful_or_canсeled`, or `any`.
        public var statusForManualRedirection: StatusForManualRedirection?

        /// Text on the button for manual redirection.
        public var redirectButtonCaption: String?

        public init(redirectConditions: RedirectConditions? = nil,
                    delay: Int? = nil,
                    statusForManualRedirection: StatusForManualRedirection? = nil,
                    redirectButtonCaption: String? = nil)
        {
            self.redirectConditions = redirectConditions
            self.delay = delay
            self.statusForManualRedirection = statusForManualRedirection
            self.redirectButtonCaption = redirectButtonCaption
        }

        public enum CodingKeys: String, CodingKey
        {
            case redirectConditions = "redirect_conditions"
            case delay
            case statusForManualRedirection = "status_for_manual_redirection"
            case redirectButtonCaption = "redirect_button_caption"
        }

        public enum RedirectConditions: String, Codable
        {
            case `none` = "none"
            case successful = "successful"
            case successfulOrCanceled = "successful_or_canceled"
            case any = "any"
        }

        public enum StatusForManualRedirection: String, Codable
        {
            case `none` = "none"
            case vc = "vc"
            case successful = "successful"
            case successfulOrCanceled = "successful_or_canceled"
            case any = "any"
        }
    }
}
